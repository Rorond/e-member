import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:emembers/data/web_client.dart';
import 'package:emembers/data/models/user.dart';
// import 'package:native_widgets/native_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

import '../../../constants.dart';

class PaidConfirmPage extends StatefulWidget {
  final User user;

  PaidConfirmPage({Key? key, required this.user}) : super(key: key);

  @override
  _PaidConfirmState createState() => _PaidConfirmState();
}

class _PaidConfirmState extends State<PaidConfirmPage> {
  final memberURL = Constants.apiGateway + "/Guest/GetMembership";

  List<XFile>? _mediaFileList;

  void _setImageFileListFromFile(XFile? value) {
    _mediaFileList = value == null ? null : <XFile>[value];
  }

  final picker = ImagePicker();
  dynamic _pickImageError;
  late String idCardType, idCardNum;
  String? _retrieveDataError;

  String? membership, atasNama, noRek;
  late TextEditingController _controllerAtasNama, _controllerNoRek;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List cards = [];
  List<String> cardsList = [];
  var isLoading = false;

  _fetchData() async {
    Uri uri = Uri.parse(memberURL +
        BaseUrlParams.baseUrlParams(widget.user.userId.toString()) +
        "&GuestId=" +
        widget.user.userId.toString());
    var _token = widget.user.token;
    var response = await WebClient(User(token: _token)).get(uri);
    //var responseJson = json.decode(response.body);
    var datasets = response["entity"];
    cards = (datasets)
        .map((datasets) => new MemberDetail.fromJson(datasets))
        .toList();

    for (var i = 0; i < cards.length; i++) {
      if (cards[i].status != "Active") {
        cardsList.add(
            cards[i].membershipId.toString() + ';' + cards[i].membershipName);
      }
    }
  }

  @override
  initState() {
    _controllerAtasNama = TextEditingController();
    _controllerNoRek = TextEditingController();
    super.initState();
    _fetchData();
  }

  void _onImageButtonPressed(ImageSource source) async {
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 400,
        maxHeight: 600,
      );
      setState(() {
        _setImageFileListFromFile(pickedFile);
      });
    } catch (e) {
      _pickImageError = e;
    }
  }

  Widget _previewImage() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_mediaFileList != null) {
      return Semantics(
        label: 'image_picker_example_picked_images',
        child: ListView.builder(
          key: UniqueKey(),
          itemBuilder: (BuildContext context, int index) {
            final String? mime = lookupMimeType(_mediaFileList![index].path);

            return Semantics(
              label: 'image_picker_example_picked_image',
              child: kIsWeb
                  ? Image.network(_mediaFileList![index].path)
                  : Image.file(
                      File(_mediaFileList![index].path),
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return const Center(
                            child: Text('This image type is not supported'));
                      },
                    ),
            );
          },
          itemCount: _mediaFileList!.length,
        ),
      );
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
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        if (response.files == null) {
          _setImageFileListFromFile(response.file);
        } else {
          _mediaFileList = response.files;
        }
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Paid Confirm"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SafeArea(
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          key: PageStorageKey("Divider 1"),
          children: <Widget>[
            Row(children: [
              Card(
                margin: EdgeInsets.all(5.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(11.0))),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 85,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Center(
                    child: !kIsWeb &&
                            defaultTargetPlatform == TargetPlatform.android
                        ? FutureBuilder<void>(
                            future: retrieveLostData(),
                            builder: (BuildContext context,
                                AsyncSnapshot<void> snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                case ConnectionState.waiting:
                                  return const Text(
                                    'You have not yet picked an image.',
                                    textAlign: TextAlign.center,
                                  );
                                case ConnectionState.done:
                                  return _previewImage();
                                case ConnectionState.active:
                                  if (snapshot.hasError) {
                                    return Text(
                                      'Pick image/video error: ${snapshot.error}}',
                                      textAlign: TextAlign.center,
                                    );
                                  } else {
                                    return const Text(
                                      'You have not yet picked an image.',
                                      textAlign: TextAlign.center,
                                    );
                                  }
                              }
                            },
                          )
                        : _previewImage(),
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 10.0),
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
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 5.0, left: 10.0),
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
                                Icons.camera,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              )
            ]),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  ListTile(
                      title: DropdownButtonFormField(
                    decoration: InputDecoration(
                        labelText: 'Membership Ordered',
                        icon: Icon(Icons.card_membership)),
                    items: cardsList.map((String category) {
                      return new DropdownMenuItem(
                          value: category,
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.card_membership),
                              Text(category.split(";")[1]),
                            ],
                          ));
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() => membership = newValue!);
                    },
                    validator: (val) => val.toString().length < 1
                        ? 'Membership Ordered Required'
                        : null,
                    value: membership,
                  )),
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'No. Rekening', icon: Icon(Icons.email)),
                      validator: (val) => val.toString().length < 1
                          ? 'No. Rekening Required'
                          : null,
                      onSaved: (val) => noRek = val!,
                      obscureText: false,
                      controller: _controllerNoRek,
                      autocorrect: false,
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Atas Nama/Pemilik Rekening ',
                          icon: Icon(Icons.people)),
                      validator: (val) => val.toString().length < 1
                          ? 'Atas Nama Required'
                          : null,
                      onSaved: (val) => atasNama = val!,
                      obscureText: false,
                      controller: _controllerAtasNama,
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: TextButton(
                child: Text(
                  'Save',
                  textScaleFactor: 1.0,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.primaryColor)),
                onPressed: () async {
                  final form = _formKey.currentState;
                  if (form!.validate()) {
                    form.save();
                    final snackbar = SnackBar(
                      duration: Duration(seconds: 30),
                      content: Row(
                        children: <Widget>[
                          CircularProgressIndicator.adaptive(),
                          Text("  Sending Up...")
                        ],
                      ),
                    );
                    if (_mediaFileList!.first.path != null) {
                      final snackbar = SnackBar(
                        duration: Duration(seconds: 30),
                        content: Row(
                          children: <Widget>[
                            CircularProgressIndicator.adaptive(),
                            Text("  Sending Up...")
                          ],
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      var membershipSplit = membership!.split(";");
                      final pC = new PaidConfrim(
                          membershipSplit[0].toString(),
                          membershipSplit[1].toString(),
                          noRek.toString(),
                          atasNama.toString());
                      _sendMembership(pC, widget.user);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _sendMembership(PaidConfrim paidConfrim, User user) async {
    var _token = user.token;
    Uri memberURL = Uri.parse(Constants.apiGateway + "/Guest/PayMembership");
    var now = new DateTime.now();
    String joinDate = DateFormat('dd.MM.yyyy').format(now);
    File imageFile = new File(_mediaFileList!.first.path);
    List<int> imageBytes = imageFile.readAsBytesSync();
    String base64Image = "data:image/png;base64," + base64.encode(imageBytes);

    Map data = {
      "GuestId": user.userId,
      "MembershipId": paidConfrim.membershipId,
      "MembershipName": paidConfrim.membershipName,
      "TransferDate": joinDate,
      "BankAccountNo": paidConfrim.noRek,
      "BankAccountName": paidConfrim.atasNama,
      "ImageBase64String": base64Image
    };
    //encode Map to JSON
    // var body = json.encode(data);
    //   final response = await http.post(memberURL,
    //    body: body,
    //      headers: {
    //       HttpHeaders.contentTypeHeader: 'application/json',
    //       HttpHeaders.authorizationHeader: "Bearer $_token",
    //     }
    //   );
    //   if (response.statusCode == 200) {
    var response = await WebClient(User(token: _token)).post(memberURL, data);
    var responseJson = json.decode(response.toString());
    var dataset = responseJson["returnMessage"];

    final snackbar = SnackBar(
      duration: Duration(seconds: 3),
      content: Row(
        children: <Widget>[
          CircularProgressIndicator.adaptive(),
          Text("  Paid confirm send..." + dataset.toString())
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);

    await Future.delayed(Duration(seconds: 3));
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    Navigator.pop(context);

    // } else {
    //   _scaffoldKey.currentState.hideCurrentSnackBar();
    //   //throw Exception('Failed to load data');
    // }
  }
}

class PaidConfrim {
  final String membershipId;
  final String membershipName;
  final String noRek;
  final String atasNama;

  PaidConfrim(
      this.membershipId, this.membershipName, this.noRek, this.atasNama);
}

class MemberDetail {
  final int membershipId;
  final String membershipName;
  final String validTo;
  final String price;
  final String status;

  MemberDetail._(
      {required this.membershipId,
      required this.membershipName,
      required this.validTo,
      required this.price,
      required this.status});

  factory MemberDetail.fromJson(Map<String, dynamic> json) {
    return new MemberDetail._(
        membershipId: json['membershipId'],
        membershipName: json['membershipName'].toString(),
        validTo: json['validTo'].toString(),
        price: json['price'].toString(),
        status: json['status'].toString());
  }
}
