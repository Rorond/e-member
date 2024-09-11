import 'dart:convert';
import 'dart:io';

import 'package:emembers/core/circle_avatar_photo.dart';
import 'package:emembers/flutter_flow/flutter_flow_theme.dart';
import 'package:emembers/ui/home/homepage_widget.dart';
import 'package:flutter/material.dart';
// import 'package:native_widgets/native_widgets.dart';

import 'package:emembers/data/models/user.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;
import 'package:emembers/data/web_client.dart';
import 'package:emembers/constants.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({required Key key, required this.user}) : super(key: key);
  final User user;
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TextEditingController _controllerEmployeeId,
      _controllerFirstname,
      _controllerLastname,
      _controllerEmail,
      _controllerMobile,
      _controllerKTP,
      _controllerSIM,
      _controllerNPWP;
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  static final memberURLDetail = Constants.apiGateway + "/Guest/GetDetail";
  final Uri memberURLUpdate = Uri.parse(Constants.apiGateway + "/Guest/Update");
  final Uri memberURLComm = Uri.parse(Constants.apiGateway + "/Guest");
  String? imageProfileUrl;
  String imageUrl = "";
  PickedFile? _imageFile;
  final _picker = ImagePicker();
  dynamic _pickImageError;
  late String _retrieveDataError;
  late int idMobilePhone;
  List cards = [];
  User? _user;
  var isLoading = false;
  String mobilePhone = "";
  var datasetComm;
  bool isEmployee = false;

  _fetchData() async {
    Uri uri = Uri.parse(memberURLDetail +
        BaseUrlParams.baseUrlParams(widget.user.userId.toString()) +
        "&Id=" +
        widget.user.userId.toString());
    var _token = widget.user.token;
    var response = await WebClient(User(token: _token)).get(uri);
    bool responseData = response == null ? false : true;
    if (response["returnStatus"] == true && responseData == true) {
      var dataset = response["entity"];
      _user = new User.fromJson(dataset);

      Uri uriComm = Uri.parse(Constants.apiGateway +
          '/GuestCommunication/InquiryByGuestId' +
          "?GuestId=" +
          widget.user.userId.toString());
      var responseComm = await WebClient(User(token: _token)).get(uriComm);
      bool responseDataComm = responseComm == null ? false : true;
      if (responseComm["returnStatus"] == true && responseDataComm == true) {
        datasetComm = responseComm["entity"];
        for (var i = 0; i < datasetComm.length; i++) {
          if (datasetComm[i]["type"] == "Handphone") {
            idMobilePhone = datasetComm[i]["id"];
            mobilePhone = datasetComm[i]["contactNo"];
          }
        }
      }
      if (mounted) {
        setState(() {
          _controllerEmployeeId =
              TextEditingController(text: _user?.employeeId);
          _controllerFirstname = TextEditingController(text: _user?.firstName);
          _controllerLastname = TextEditingController(text: _user?.lastName);
          _controllerEmail = TextEditingController(text: _user?.emailAddress);
          _controllerMobile = TextEditingController(text: mobilePhone);
          _controllerKTP = TextEditingController(text: _user?.ktp);
          _controllerSIM = TextEditingController(text: _user?.sim);
          _controllerNPWP = TextEditingController(text: _user?.npwp);
          imageProfileUrl = _user!.imageUrl;
          isEmployee = _user!.isEmployee;
        });
      }
    }
  }

  _updateData() async {
    setState(() {
      isLoading = true;
    });
    var _token = widget.user.token;
    Map updateData;
    String base64Image;
    _user = widget.user;

    if (_imageFile != null) {
      File imageFile = new File(_imageFile!.path);
      List<int> imageBytes = imageFile.readAsBytesSync();
      base64Image = "data:image/png;base64," + base64.encode(imageBytes);
      updateData = {
        "Id": widget.user.userId,
        "MemberNo": widget.user.memberNo,
        "FirstName": _controllerFirstname.text,
        "LastName": _controllerLastname.text,
        "EmailAddress": _controllerEmail.text,
        "isMember": widget.user.isMember,
        "GuestTypeId": 1,
        "GenderId": 1,
        "ReligionID": 1,
        "BloodTypeId": 1,
        "MaritalStatusId": 1,
        "EVCodeStatus": 1,
        "KTP": _controllerKTP.text,
        "SIM": _controllerSIM.text,
        "NPWP": _controllerNPWP.text,
        "imageBase64String": base64Image,
      };
    } else {
      Uri imageUrl =
          Uri.parse(Constants.apiImage + "/Guest/" + _user!.imageUrl);
      var strBase64Image = await networkImageToBase64(imageUrl);
      base64Image = "data:image/png;base64," + strBase64Image!;

      updateData = {
        "Id": widget.user.userId,
        "MemberNo": widget.user.memberNo,
        "FirstName": _controllerFirstname.text,
        "LastName": _controllerLastname.text,
        "EmailAddress": _controllerEmail.text,
        "isMember": widget.user.isMember,
        "GuestTypeId": 1,
        "GenderId": 1,
        "ReligionID": 1,
        "BloodTypeId": 1,
        "MaritalStatusId": 1,
        "EVCodeStatus": 1,
        "KTP": _controllerKTP.text,
        "SIM": _controllerSIM.text,
        "NPWP": _controllerNPWP.text,
        "imageBase64String": base64Image,
      };
    }
    var response =
        await WebClient(User(token: _token)).post(memberURLUpdate, updateData);

    bool responseStatus = response == null ? false : true;
    if (responseStatus == true) {
      var responseData = json.decode(response);
      if (responseData["returnStatus"] == true) {
        if (datasetComm.length == 0) {
          Uri uriCommCreate =
              Uri.parse(Constants.apiGateway + '/GuestCommunication/Create');
          await WebClient(User(token: _token)).post(uriCommCreate, {
            "GuestId": widget.user.userId,
            "Type": "Handphone",
            "ContactNo": _controllerMobile.text,
          });
        } else {
          Uri uriCommUpdate =
              Uri.parse(Constants.apiGateway + '/GuestCommunication/Update');
          await WebClient(User(token: _token)).post(uriCommUpdate, {
            "Id": idMobilePhone,
            "GuestId": widget.user.userId,
            "Type": "Handphone",
            "ContactNo": _controllerMobile.text,
          });
        }
        var dataset = responseData["entity"];
        _user = new User.fromJson(dataset);
        if (mounted) {
          setState(() {
            _controllerFirstname =
                TextEditingController(text: _user?.firstName);
            _controllerLastname = TextEditingController(text: _user?.lastName);
            _controllerEmail = TextEditingController(text: _user?.emailAddress);
            _controllerMobile =
                TextEditingController(text: _controllerMobile.text);
            _controllerKTP = TextEditingController(text: _user?.ktp);
            _controllerSIM = TextEditingController(text: _user?.sim);
            _controllerNPWP = TextEditingController(text: _user?.npwp);
            imageProfileUrl = _user!.imageUrl;

            isLoading = false;
          });
        }
      }
    }
  }

  void initState() {
    _controllerFirstname = TextEditingController(text: widget.user.firstName);
    _controllerLastname = TextEditingController(text: widget.user.lastName);
    _controllerEmail = TextEditingController(text: widget.user.emailAddress);
    _controllerMobile = TextEditingController(text: mobilePhone);
    _controllerKTP = TextEditingController(text: widget.user.ktp);
    _controllerSIM = TextEditingController(text: widget.user.sim);
    _controllerNPWP = TextEditingController(text: widget.user.npwp);
    imageProfileUrl = widget.user.imageUrl;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchData());
  }

  // void _onImageButtonPressed(ImageSource source) async {
  //   try {
  //     _imageFile =
  //         await _picker.getImage(source: source, maxHeight: 600, maxWidth: 400);
  //     setState(() {});
  //   } catch (e) {
  //     _pickImageError = e;
  //   }
  // }

  void _onImageButtonPressed(ImageSource source) async {
    try {
      _imageFile = (await _picker.pickImage(
          source: source, maxHeight: 600, maxWidth: 400)) as PickedFile;
      setState(() {});
    } catch (e) {
      _pickImageError = e;
    }
  }

  Widget _previewImage() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    final File file = File(_imageFile!.path);
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile != null) {
      return Image.file(file);
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Future<void> retrieveLostData() async {
    final LostData response = (await _picker.retrieveLostData()) as LostData;
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file!;
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  Future<String?> networkImageToBase64(Uri imageUrl) async {
    http.Response response = await http.get(imageUrl);
    final bytes = response?.bodyBytes;
    return (bytes != null ? base64Encode(bytes) : null);
  }

  Future<bool> navigateToHomePage(BuildContext context, User user) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomepageWidget()),
    );
    return false;
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      // _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.black,
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/homepage");
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Text(
                "My Profile",
                style: ListTittleProfile,
              ),
              Spacer(flex: 2),
            ],
          ),
        ),
        body: new WillPopScope(
            onWillPop: () {
              return navigateToHomePage(context, widget.user);
            },
            child: Container(
              color: AppColors.nearlyWhite,
              child: new ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      _titleView(_user ?? widget.user),
                      new Container(
                        color: Color(0xffFFFFFF),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 25.0),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text('Personal Information',
                                              style: ListTittleProfile),
                                        ],
                                      ),
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          _status
                                              ? _getEditIcon()
                                              : new Container(),
                                        ],
                                      )
                                    ],
                                  )),
                              isEmployee == true
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: new Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          new Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              new Text('Employee ID',
                                                  style: AppTittle1),
                                            ],
                                          ),
                                        ],
                                      ))
                                  : new Container(),
                              isEmployee == true
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 2.0),
                                      child: new Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          new Flexible(
                                            child: new TextField(
                                              decoration: const InputDecoration(
                                                  hintText:
                                                      "Enter Employee ID"),
                                              enabled: false,
                                              controller: _controllerEmployeeId,
                                            ),
                                          ),
                                        ],
                                      ))
                                  : new Container(),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          child: new Text('Firstname',
                                              style: AppTittle1),
                                        ),
                                        flex: 2,
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: new Text('Lastname',
                                              style: AppTittle1),
                                        ),
                                        flex: 2,
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: new TextField(
                                            decoration: const InputDecoration(
                                                hintText: "Enter Firstname"),
                                            enabled: !_status,
                                            controller: _controllerFirstname,
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                      Flexible(
                                        child: new TextField(
                                          decoration: const InputDecoration(
                                              hintText: "Enter Lastname"),
                                          enabled: !_status,
                                          controller: _controllerLastname,
                                        ),
                                        flex: 2,
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text('Email ID',
                                              style: AppTittle1),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextField(
                                          decoration: const InputDecoration(
                                              hintText: "Enter Email ID"),
                                          enabled: !_status,
                                          controller: _controllerEmail,
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text('Mobile', style: AppTittle1),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextField(
                                          decoration: const InputDecoration(
                                              hintText: "Enter Mobile Number"),
                                          enabled: !_status,
                                          controller: _controllerMobile,
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          child: new Text('No. KTP',
                                              style: AppTittle1),
                                        ),
                                        flex: 2,
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: new Text('No. NPWP',
                                              style: AppTittle1),
                                        ),
                                        flex: 2,
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: new TextField(
                                            decoration: const InputDecoration(
                                                hintText: "Enter KTP Number"),
                                            enabled: !_status,
                                            controller: _controllerKTP,
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                      Flexible(
                                        child: new TextField(
                                          decoration: const InputDecoration(
                                              hintText: "Enter NPWP Number"),
                                          enabled: !_status,
                                          controller: _controllerNPWP,
                                        ),
                                        flex: 2,
                                      ),
                                    ],
                                  )),
                              !_status ? _getActionButtons() : new Container(),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )));
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 5.0),
              child: Container(
                  child: TextButton(
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.primaryColor)),
                onPressed: () {
                  _updateData();
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: Container(
                  child: TextButton(
                child: Text("Cancel",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColors.grey)),
                // padding: EdgeInsets.only(left: 25.0, right: 25.0),
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return Row(children: <Widget>[
      new GestureDetector(
        child: new CircleAvatar(
          backgroundColor: AppColors.primaryColor,
          radius: 14.0,
          child: new Icon(
            Icons.edit,
            color: Colors.white,
            size: 16.0,
          ),
        ),
        onTap: () {
          setState(() {
            _status = false;
          });
        },
      ),
    ]);
  }

  Widget _titleView(User user) {
    String imgUrl = imageProfileUrl == null
        ? Constants.apiImage + "/Guest/unknown.jpg"
        : Constants.apiImage +
            "/Guest/" +
            user.imageUrl +
            "?v=" +
            DateTime.now().toString();
    return new Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [AppColors.red, AppColors.primaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
              topRight: Radius.circular(68.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: AppColors.grey.withOpacity(0.6),
                offset: Offset(1.1, 1.1),
                blurRadius: 10.0),
          ],
          image: DecorationImage(
              image: AssetImage('assets/images/frame.png'), fit: BoxFit.cover)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: new Stack(fit: StackFit.loose, children: <Widget>[
                new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      width: 140.0,
                      height: 140.0,
                      child: PSCircleAvatar(
                        borderWidth: 5,
                        color: AppColors.nearlyWhite,
                        child: imageProfileUrl.toString() != "null" &&
                                _imageFile == null
                            ?
                            //  MeetNetworkImage(
                            //   imageUrl:
                            //       imgUrl,
                            //   loadingBuilder: (context) => Center(
                            //         child: CircularProgressIndicator(),
                            //       ),
                            //   errorBuilder: (context, e) => Center(
                            //         child: Text('Error appear!'),
                            //       ),
                            // )
                            Image.network(imgUrl, fit: BoxFit.fitWidth)
                            : _previewImage(),
                      ),
                    ),
                  ],
                ),
                !_status
                    ? Padding(
                        padding: EdgeInsets.only(top: 20.0, right: 140.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () =>
                                  _onImageButtonPressed(ImageSource.camera),
                              child: new CircleAvatar(
                                backgroundColor: AppColors.primaryColor,
                                radius: 25.0,
                                child: new Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ))
                    : new Padding(padding: EdgeInsets.only(top: 0.0)),
                !_status
                    ? Padding(
                        padding: EdgeInsets.only(top: 80.0, right: 140.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () =>
                                  _onImageButtonPressed(ImageSource.gallery),
                              child: new CircleAvatar(
                                backgroundColor: AppColors.primaryColor,
                                radius: 25.0,
                                child: new Icon(
                                  Icons.image,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ))
                    : new Padding(padding: EdgeInsets.only(top: 0.0))
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                widget.user.memberNo.toString() == 'null'
                    ? "Non Member"
                    : widget.user.memberNo,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: AppColors.fontName,
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                  letterSpacing: 0.0,
                  color: AppColors.white,
                ),
              ),
            ),
            Text(
              widget.user.firstName + ' ' + widget.user.lastName,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: AppColors.fontName,
                fontWeight: FontWeight.normal,
                fontSize: 14,
                letterSpacing: 0.0,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
