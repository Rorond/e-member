import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:emembers/data/web_client.dart';
// import 'package:emembers/constants.dart';
import 'package:emembers/data/models/user.dart';
import 'package:emembers/data/classes/auth.dart';

// import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../constants.dart';

class OtpPage extends StatefulWidget {
  final User user;
  OtpPage({required this.user});
  @override
  OtpPageState createState() => OtpPageState();
}

class OtpPageState extends State<OtpPage> {
  TextEditingController controller1 = new TextEditingController();
  TextEditingController controller2 = new TextEditingController();
  TextEditingController controller3 = new TextEditingController();
  TextEditingController controller4 = new TextEditingController();
  TextEditingController controller5 = new TextEditingController();
  TextEditingController controller6 = new TextEditingController();

  TextEditingController currController = new TextEditingController();
  String konten = '   Verification OTP ...';
  String _currentDigit = "";
  @override
  void dispose() {
    super.dispose();
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    controller5.dispose();
    controller6.dispose();
  }

  @override
  void initState() {
    super.initState();
    currController = controller1;
    controller6 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    List<Widget> widgetList = [
      Padding(
        padding: EdgeInsets.only(left: 0.0, right: 2.0),
        child: new Container(
          color: Colors.transparent,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 2.0, left: 2.0),
        child: new Container(
            alignment: Alignment.center,
            decoration: new BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                border: new Border.all(
                    width: 1.0, color: Color.fromRGBO(0, 0, 0, 0.1)),
                borderRadius: new BorderRadius.circular(4.0)),
            child: new TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
              ],
              enabled: false,
              controller: controller1,
              autofocus: false,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0, color: Colors.black),
            )),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 2.0, left: 2.0),
        child: new Container(
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              border: new Border.all(
                  width: 1.0, color: Color.fromRGBO(0, 0, 0, 0.1)),
              borderRadius: new BorderRadius.circular(4.0)),
          child: new TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            controller: controller2,
            autofocus: false,
            enabled: false,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24.0, color: Colors.black),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 2.0, left: 2.0),
        child: new Container(
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              border: new Border.all(
                  width: 1.0, color: Color.fromRGBO(0, 0, 0, 0.1)),
              borderRadius: new BorderRadius.circular(4.0)),
          child: new TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            keyboardType: TextInputType.number,
            controller: controller3,
            textAlign: TextAlign.center,
            autofocus: false,
            enabled: false,
            style: TextStyle(fontSize: 24.0, color: Colors.black),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 2.0, left: 2.0),
        child: new Container(
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              border: new Border.all(
                  width: 1.0, color: Color.fromRGBO(0, 0, 0, 0.1)),
              borderRadius: new BorderRadius.circular(4.0)),
          child: new TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            textAlign: TextAlign.center,
            controller: controller4,
            autofocus: false,
            enabled: false,
            style: TextStyle(fontSize: 24.0, color: Colors.black),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 2.0, left: 2.0),
        child: new Container(
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              border: new Border.all(
                  width: 1.0, color: Color.fromRGBO(0, 0, 0, 0.1)),
              borderRadius: new BorderRadius.circular(4.0)),
          child: new TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            textAlign: TextAlign.center,
            controller: controller5,
            autofocus: false,
            enabled: false,
            style: TextStyle(fontSize: 24.0, color: Colors.black),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 2.0, left: 2.0),
        child: new Container(
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              border: new Border.all(
                  width: 1.0, color: Color.fromRGBO(0, 0, 0, 0.1)),
              borderRadius: new BorderRadius.circular(4.0)),
          child: new TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            textAlign: TextAlign.center,
            controller: controller6,
            autofocus: false,
            enabled: false,
            style: TextStyle(fontSize: 24.0, color: Colors.black),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 2.0, right: 0.0),
        child: new Container(
          color: Colors.transparent,
        ),
      ),
    ];

    return new Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Enter OTP"),
        backgroundColor: AppColors.primaryColor,
      ),
      backgroundColor: Color(0xFFeaeaea),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Verifying your number!",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, top: 4.0, right: 16.0),
                    child: Text(
                      "Periksa kode verifikasi registasi pada inbox, spam atau junk email.",
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, top: 4.0, right: 16.0),
                    child: Text(
                      "Dan ketik kode verifikasi yang dikirim ke email ",
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, top: 2.0, right: 30.0),
                    child: Text(
                      widget.user.emailAddress == null
                          ? ''
                          : widget.user.emailAddress,
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Image(
                      image: AssetImage('assets/images/otp-icon.png'),
                      height: 120.0,
                      width: 120.0,
                    ),
                  )
                ],
              ),
              flex: 90,
            ),
            Flexible(
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    GridView.count(
                        crossAxisCount: 8,
                        mainAxisSpacing: 10.0,
                        shrinkWrap: true,
                        primary: false,
                        scrollDirection: Axis.vertical,
                        children: List<Container>.generate(
                            8,
                            (int index) =>
                                Container(child: widgetList[index]))),
                  ]),
              flex: 20,
            ),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 16.0, right: 8.0, bottom: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          MaterialButton(
                            onPressed: () {
                              inputTextToField("1", _auth);
                            },
                            child: Text("1",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                          ),
                          MaterialButton(
                            onPressed: () {
                              inputTextToField("2", _auth);
                            },
                            child: Text("2",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                          ),
                          MaterialButton(
                            onPressed: () {
                              inputTextToField("3", _auth);
                            },
                            child: Text("3",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                    ),
                  ),
                  new Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 4.0, right: 8.0, bottom: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          MaterialButton(
                            onPressed: () {
                              inputTextToField("4", _auth);
                            },
                            child: Text("4",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                          ),
                          MaterialButton(
                            onPressed: () {
                              inputTextToField("5", _auth);
                            },
                            child: Text("5",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                          ),
                          MaterialButton(
                            onPressed: () {
                              inputTextToField("6", _auth);
                            },
                            child: Text("6",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                    ),
                  ),
                  new Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 4.0, right: 8.0, bottom: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          MaterialButton(
                            onPressed: () {
                              inputTextToField("7", _auth);
                            },
                            child: Text("7",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                          ),
                          MaterialButton(
                            onPressed: () {
                              inputTextToField("8", _auth);
                            },
                            child: Text("8",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                          ),
                          MaterialButton(
                            onPressed: () {
                              inputTextToField("9", _auth);
                            },
                            child: Text("9",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                    ),
                  ),
                  new Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 4.0, right: 8.0, bottom: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new SizedBox(
                            width: 90.0,
                          ),
                          MaterialButton(
                            onPressed: () {
                              inputTextToField("0", _auth);
                            },
                            child: Text("0",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center),
                          ),
                          MaterialButton(
                              onPressed: () {
                                deleteText();
                              },
                              child: Image.asset('assets/images/delete.png',
                                  width: 25.0, height: 25.0)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              flex: 90,
            ),
          ],
        ),
      ),
    );
  }

  void inputTextToField(String i, AuthModel auth) {
    setState(() {
      _currentDigit = i;
      if (controller1.text == '') {
        controller1.text = _currentDigit;
      } else if (controller2.text == '') {
        controller2.text = _currentDigit;
      } else if (controller3.text == '') {
        controller3.text = _currentDigit;
      } else if (controller4.text == '') {
        controller4.text = _currentDigit;
      } else if (controller5.text == '') {
        controller5.text = _currentDigit;
      } else if (controller6.text == '') {
        controller6.text = _currentDigit;

        verifyOTP(controller6.text, auth);
        // Verify your otp by here. API call
      }
    });
  }

  void deleteText() {
    setState(() {
      if (controller6.text != '') {
        controller6.text = '';
      } else if (controller5.text != '') {
        controller5.text = '';
      } else if (controller4.text != '') {
        controller4.text = '';
      } else if (controller3.text != '') {
        controller3.text = '';
      } else if (controller2.text != '') {
        controller2.text = '';
      } else if (controller1.text != '') {
        controller1.text = '';
      }
    });
  }

  verifyOTP(String value, AuthModel auth) async {
    String otpText = controller1.text +
        controller2.text +
        controller3.text +
        controller4.text +
        controller5.text +
        controller6.text;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext builderContext) {
          return AlertDialog(
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return new Material(
                  child: new MyDialogContent(
                      auth: auth,
                      user: widget.user,
                      otpText: otpText,
                      evCode: widget.user.evCode),
                );
              },
            ),
          );
        });
  }
}

class MyDialogContent extends StatefulWidget {
  MyDialogContent({
    Key? key,
    required this.auth,
    required this.user,
    required this.otpText,
    required this.evCode,
  }) : super(key: key);

  final User user;
  final AuthModel auth;
  final String otpText;
  final String evCode;
  @override
  _MyDialogContentState createState() => new _MyDialogContentState();
}

class _MyDialogContentState extends State<MyDialogContent> {
  final AuthModel _auth = AuthModel();
  String konten = '   Verification OTP ...';
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      if (widget.otpText == widget.evCode) {
        setState(() {
          konten = '   Otp matched successfully.';
        });
      } else {
        setState(() {
          konten = '   Otp code does not matched.';
        });
      }
    });
    Timer(Duration(seconds: 3), () {
      if (widget.otpText == widget.evCode) {
        setState(() {
          konten = '   Logging In...';
        });
        updateOTP(widget.auth);
      } else {
        updateOTPNotMatch(widget.auth);
      }
    });
  }

  _getContent() {
    return new Row(
      children: <Widget>[
        CircularProgressIndicator.adaptive(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
        ),
        Text(konten)
      ],
    );
  }

  updateOTP(AuthModel auth) async {
    Uri memberURLUpdate =
        Uri.parse(Constants.apiGateway + "/Guest/UpdateOTPStatus");
    var _token = widget.user.token;

    Map updateData = {"Id": widget.user.userId, "EVCodeStatus": "1"};
    var response =
        await WebClient(User(token: _token)).post(memberURLUpdate, updateData);
    bool responseStatus = response == null ? false : true;
    var responseData = json.decode(response);
    if (responseStatus == true) {
      Navigator.of(context).pop(false);

      auth.logout();
      auth
          .loginById(
        token: _token,
        userid: widget.user.userId,
      )
          .then((result) {
        if (result) {
          Navigator.of(context).pushReplacementNamed('/homepage');
        }
      });
    } else {
      Navigator.of(context).pop(false);

      String msgError = responseData["returnMessage"];
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Warning"),
              content: Text(msgError),
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    })
              ],
            );
          });
    }
  }

  updateOTPNotMatch(AuthModel auth) async {
    Uri memberURLUpdate =
        Uri.parse(Constants.apiGateway + "/Guest/UpdateOTPStatus");
    var _token = widget.user.token;

    Map updateData = {"Id": widget.user.userId, "EVCodeStatus": "3"};
    var response =
        await WebClient(User(token: _token)).post(memberURLUpdate, updateData);
    bool responseStatus = response == null ? false : true;
    var responseData = json.decode(response);
    if (responseStatus == true) {
      Navigator.of(context).pop(false);

      String msgError = 'Kode OTP tidak cocok.';
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Warning"),
              content: Text(msgError),
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    })
              ],
            );
          });
    } else {
      Navigator.of(context).pop(false);

      String msgError = responseData["returnMessage"];
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Warning"),
              content: Text(msgError),
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    })
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _getContent();
  }
}
