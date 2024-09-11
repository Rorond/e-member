import 'dart:async';
import 'dart:convert';
import 'package:emembers/ui/home/homepage_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';

// import 'package:native_widgets/native_widgets.dart';

import 'package:emembers/data/classes/auth.dart';
import 'package:flutter/widgets.dart';
// import 'package:emembers/utils/core/theme.dart';
import 'package:emembers/data/models/user.dart';
import 'package:emembers/data/web_client.dart';

import '../../../constants.dart';

class FormDeleteAccount {
  final String reason;

  FormDeleteAccount(this.reason);
}

class DeleteAccount extends StatefulWidget {
  DeleteAccount({required Key key, required this.user}) : super(key: key);
  final User user;
  @override
  DeleteAccountHomeState createState() => DeleteAccountHomeState();
}

class DeleteAccountHomeState extends State<DeleteAccount> {
  late TextEditingController _controllerReason;

  final Uri memberURLDelete = Uri.parse(Constants.apiGateway + "/Guest/Delete");
  @override
  initState() {
    _controllerReason = TextEditingController();
    super.initState();
  }

  final _formKey = new GlobalKey<FormState>();
  //final _scaffoldKey = GlobalKey<ScaffoldState>();
  // final _passKey = GlobalKey<FormFieldState>();

  bool _isButtonDisabled = true;
  bool _agreedToTOS = false;
  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
      _isButtonDisabled = newValue == true ? false : true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          "Detele Account",
          textScaleFactor: AppColors.textScaleFactor,
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: WillPopScope(
        onWillPop: () async {
          await navigateToHomePage(context, widget.user);
          return false;
        },
        child: Container(
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        children: <Widget>[
                          // Checkbox(
                          //   value: _agreedToTOS,
                          //   onChanged: _setAgreedToTOS,
                          // ),
                          GestureDetector(
                            //onTap: () => _setAgreedToTOS(!_agreedToTOS),
                            child: Container(
                              width: MediaQuery.of(context).size.width - 50,
                              child: const Text(
                                'Dengan ini Saya Mengetahui dan Menyetujui penghapusan akun saya pada Aplikasi e-Members.',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: new TextFormField(
                          controller: _controllerReason,
                          autocorrect: false,
                          maxLength: 255,
                          maxLines: 5,
                          validator: (val) => val.toString().length < 1
                              ? 'Reason Required'
                              : null,
                          decoration: InputDecoration(
                              hintText: "Reason",
                              labelText: "Reason",
                              suffixIcon: Icon(
                                Icons.delete_forever,
                                size: 42,
                              ),
                              hintStyle: const TextStyle(color: Colors.grey),
                              fillColor: Colors.white,
                              filled: true,
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green)),
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)),
                              errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              border: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green)),
                              errorMaxLines: 1)),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: TextButton(
                  style: ButtonStyle(
                      backgroundColor: _isButtonDisabled
                          ? MaterialStateProperty.all(AppColors.grey)
                          : MaterialStateProperty.all(AppColors.primaryColor)),
                  child: Text(
                    'Delete Account',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  onPressed: _isButtonDisabled
                      ? () {
                          _alertVerifyMsg(
                              context, false, 'Please choose agreement.');
                        }
                      : () {
                          final form = _formKey.currentState;
                          if (form!.validate()) {
                            if (_controllerReason.text != '') {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Informasi'),
                                  content: Text(
                                      "Do you really want to delete this account!"),
                                  actions: <Widget>[
                                    TextButton(
                                        child: const Text(
                                          'Yes',
                                          style: TextStyle(
                                              color: Colors.redAccent),
                                        ),
                                        onPressed: () async {
                                          Navigator.of(context).pop(true);
                                          final fcp = new FormDeleteAccount(
                                              _controllerReason.text);
                                          _deleteData(fcp);
                                        }),
                                    TextButton(
                                        child: const Text(
                                          'No',
                                          style: TextStyle(
                                              color: Colors.redAccent),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        })
                                  ],
                                ),
                              );
                            } else {
                              _alertVerifyMsg(
                                  context, false, 'Reason is required');
                            }
                          }
                        },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _alertVerifyMsg(
    BuildContext context,
    bool withLogout,
    String message,
  ) {
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    Completer<bool> completer = Completer<bool>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Info'),
        content: Text('$message'),
        actions: <Widget>[
          TextButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(AppColors.primaryColor),
            ),
            child: Text(
              'Ok',
              textScaleFactor: AppColors.textScaleFactor,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
              if (withLogout) {
                _auth.logout();
              }
              completer.complete(false);
            },
          ),
        ],
      ),
    );

    return completer.future;
  }

  Future<void> navigateToHomePage(BuildContext context, user) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomepageWidget(user: user)),
    );
  }

  _deleteData(FormDeleteAccount fcp) async {
    final Uri memberURLDelete =
        Uri.parse(Constants.apiGateway + "/Guest/Delete");
    var _token = widget.user.token;
    Map deleteData = {
      "Id": widget.user.userId,
      "MemberNo": widget.user.memberNo,
      "FirstName": widget.user.firstName,
      "LastName": widget.user.lastName,
      "EmailAddress": widget.user.emailAddress,
      "isMember": widget.user.isMember,
      "GuestTypeId": 1,
      "GenderId": 1,
      "ReligionID": 1,
      "BloodTypeId": 1,
      "MaritalStatusId": 1,
      "EVCodeStatus": 1,
    };
    var response =
        await WebClient(User(token: _token)).post(memberURLDelete, deleteData);

    bool responseStatus = response == null ? false : true;
    if (responseStatus == true) {
      var responseData = json.decode(response);
      if (responseData["returnStatus"] == true) {
        _alertVerifyMsg(
            context, true, responseData["returnMessage"].toString());
      } else {
        _alertVerifyMsg(
            context, false, responseData["returnMessage"].toString());
      }
    }
  }
}
