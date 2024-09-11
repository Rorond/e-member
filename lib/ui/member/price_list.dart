import 'dart:io';
import 'dart:convert';

import 'package:emembers/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:emembers/data/models/membershipModel.dart';
//import 'package:emembersui/signin/newguest.dart';
// import 'package:native_widgets/native_widgets.dart';
import 'package:emembers/data/models/user.dart';
//import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';
import 'package:emembers/data/web_client.dart';
import '../../../constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

import 'succes_screen.dart';
//import '../../../utils/popUp.dart';

class PriceListRoute extends PageRouteBuilder {
  PriceListRoute(MembershipList membership, User user)
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return PriceList(membership: membership, user: user);
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: new Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: new SlideTransition(
                position: new Tween<Offset>(
                  begin: Offset.zero,
                  end: const Offset(-1.0, 0.0),
                ).animate(secondaryAnimation),
                child: child,
              ),
            );
          },
        );
}

class PriceList extends StatefulWidget {
  final MembershipList membership;
  final User user;
  PriceList({required this.membership, required this.user});

  @override
  PriceListState createState() => PriceListState();
}

class PriceListState extends State<PriceList> {
  static final memberURL = Constants.apiGateway + "/Guest/GetMembership";
  var isLoading = false;
  int selectedCardIndex = 0;

  List<XFile>? _mediaFileList;

  void _setImageFileListFromFile(XFile? value) {
    _mediaFileList = value == null ? null : <XFile>[value];
  }

  final picker = ImagePicker();
  dynamic _pickImageError;
  late String idCardType, idCardNum;
  String? _retrieveDataError;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final List transferTo = [];
  String memberURLBank = Constants.apiGateway + "/BankAccount/InquiryByProject";

  _fetchData() async {
    Uri uri = Uri.parse(memberURLBank +
        BaseUrlParams.baseUrlParams(widget.user.userId.toString()) +
        "&ProjectId=" +
        widget.membership.projectId.toString());
    var _token = widget.user.token;
    var response = await WebClient(User(token: _token)).get(uri);
    bool responseData = response == null ? false : true;
    if (response["returnStatus"] == true && responseData == true) {
      var dataset = response["entity"];
      setState(() {
        for (var i = 0; i < dataset.length; i++) {
          transferTo.add(dataset[i]);
        }
      });
    }
  }

  @override
  initState() {
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

  // Widget _previewImage1() {
  //   final Text retrieveError = _getRetrieveErrorWidget();
  //   if (retrieveError != null) {
  //     return retrieveError;
  //   }
  //   if (_imageFile != null) {
  //     return Image.file(new File(_imageFile.path));
  //   } else if (_pickImageError != null) {
  //     return Text(
  //       'Pick image error: $_pickImageError',
  //       textAlign: TextAlign.center,
  //     );
  //   } else {
  //     return const Text(
  //       'You have not yet picked an image.',
  //       textAlign: TextAlign.center,
  //     );
  //   }
  // }

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

  // Future<void> retrieveLostData() async {
  //   final LostData response = await picker.getLostData();
  //   if (response.isEmpty) {
  //     return;
  //   }
  //   if (response.file != null) {
  //     setState(() {
  //       _imageFile = response.file!;
  //     });
  //   } else {
  //     _retrieveDataError = response.exception!.code;
  //   }
  // }

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
    // todo: implement build
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Price of ' + widget.membership.name,
          style: ListTittleProfile,
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFF4F4F4),
      ),
      backgroundColor: Color(0xFFF4F4F4),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return _getSection(index);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getSection(int index) {
    switch (index) {
      case 0:
        return _getReceiverSection(widget.membership);
      case 1:
        return _getEnterAmountSection(widget.membership);
      case 2:
        return _getBankCardSection();
      default:
        return _getSendSection(widget.membership, widget.user);
    }
  }

  Widget _getReceiverSection(MembershipList receiver) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              child: Text(receiver.name.substring(0, 1)),
            ),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                receiver.name,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _getEnterAmountSection(MembershipList receiver) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(11.0))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                child: Text(
                  'Amount',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '\IDR',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30.0),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          receiver.price,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30.0),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getBankCardSection() {
    return Container(
//      color: Colors.yellow,
      margin: EdgeInsets.all(16.0),
//      height: 200.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Transfer to',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          Card(
            margin: EdgeInsets.all(0.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(11.0))),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ListView.builder(
                  itemCount: transferTo.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return _getBankCard(index);
                  }),
            ),
          ),
          widget.user.isMember == false
              ? Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Upload KTP/SIM/Passport',
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Your ID has been verified',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                ),
          widget.user.isMember == false
              ? Card(
                  margin: EdgeInsets.all(0.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(11.0))),
                  child: Row(children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 85,
                      height: 150,
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
                    Padding(
                        padding: EdgeInsets.only(top: 90.0),
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
                  ]),
                )
              : Padding(padding: const EdgeInsets.symmetric(vertical: 5.0)),
        ],
      ),
    );
  }

  Widget _getBankCard(int index) {
    String _accountNo = transferTo[index]["accountNo"];
    String _accountName = transferTo[index]["accountName"];
    String _account = transferTo[index]["name"];
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Image.asset(index % 2 == 0
              ? 'assets/images/ico_logo_red.png'
              : 'assets/images/ico_logo_blue.png'),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                ' $_account\n Num. : $_accountNo \n Name :$_accountName',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
          )),
          Radio(
            activeColor: AppColors.primaryColor,
            value: transferTo[index]["id"],
            groupValue: selectedCardIndex,
            onChanged: (value) {
              selectedCardIndex = value;
              setState(() {});
            },
          )
        ],
      ),
    );
  }

  Widget _getSendSection(MembershipList membershipList, User user) {
    // var theme;
    return Container(
      margin: EdgeInsets.all(16.0),
      child: GestureDetector(
        onTapUp: (tapDetail) {
          _createMembership(membershipList, user).then((response) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => new SuccessScreen(
                          user: widget.user,
                          membership: membershipList,
                        )));
          });
        },
        child: Container(
          width: double.infinity,
          height: 50.0,
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(11.0))),
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Text(
            'Join Member',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  _createMembership(MembershipList membership, User user) async {
    var _token = user.token;
    Uri memberURL = Uri.parse(Constants.apiGateway + "/Guest/CreateMembership");

    Map data = {"id": user.userId};
    var response = await WebClient(User(token: _token)).post(memberURL, data);
    var responseJson = json.decode(response.toString());
    if (responseJson["returnStatus"] == true) {
      final snackbar = SnackBar(
        duration: Duration(seconds: 3),
        content: Row(
          children: <Widget>[
            CircularProgressIndicator.adaptive(),
            Text("  Submit membership ...")
          ],
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      _sendMembership(membership, user);
    }
  }

  _sendMembership(MembershipList membership, User user) async {
    setState(() {
      isLoading = true;
    });
    var _token = user.token;
    Uri memberURL =
        Uri.parse(Constants.apiGateway + "/Guest/CreateMembershipDetail");
    Uri memberURLDoc =
        Uri.parse(Constants.apiGateway + "/GuestDocument/Create");

    var now = new DateTime.now();
    String joinDate = DateFormat('dd.MM.yyyy').format(now);
    var newDate;
    if (membership.period == "Half Yearly") {
      newDate = new DateTime(now.year, now.month + 6, now.day);
    } else if (membership.period == "Annual") {
      newDate = new DateTime(now.year + 1, now.month, now.day);
    } else {
      newDate = new DateTime(now.year, now.month + 1, now.day);
    }

    String validTo = DateFormat('dd.MM.yyyy').format(newDate);
    Map data = {
      "GuestId": user.userId,
      "MembershipId": membership.id,
      "CurrencyId": membership.currencyId,
      "MembershipName": membership.name,
      "JoinDate": joinDate,
      "ValidForm": joinDate,
      "ValidTo": validTo,
      "Price": membership.price,
      "Tax": membership.tax,
      "Discount": membership.discount,
      "Amount": membership.price,
      "Period": membership.period,
      "FreeFlag": "false"
    };
    var response = await WebClient(User(token: _token)).post(memberURL, data);
    var responseJson = json.decode(response.toString());

    if (responseJson["returnStatus"] == true) {
      var dataset = responseJson["returnMessage"];
      if (user.isMember == false) {
        File imageFile = new File(_mediaFileList!.first.path);
        List<int> imageBytes = imageFile.readAsBytesSync();
        String base64Image =
            "data:image/png;base64," + base64.encode(imageBytes);
        await WebClient(User(token: _token)).post(memberURLDoc, {
          "GuestId": user.userId,
          "Name": user.userId,
          "imageBase64String": base64Image,
        });
      }
      final snackbar = SnackBar(
        duration: Duration(seconds: 3),
        content: Row(
          children: <Widget>[
            CircularProgressIndicator.adaptive(),
            Text(dataset.toString())
          ],
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);

      await Future.delayed(Duration(seconds: 3));
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      Navigator.pop(context);
      setState(() {
        isLoading = false;
      });
    } else {
      //throw Exception('Failed to load data');
      final snackbar = SnackBar(
        duration: Duration(seconds: 3),
        content: Row(
          children: <Widget>[
            CircularProgressIndicator.adaptive(),
            Text(responseJson["returnMessage"].toString())
          ],
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);

      await Future.delayed(Duration(seconds: 3));
      //_scaffoldKey.currentState.hideCurrentSnackBar();
    }
  }
}
