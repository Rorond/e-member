import 'dart:convert';
import 'package:emembers/index.dart';
import 'package:emembers/ui/home/homepage_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:emembers/data/classes/auth.dart';
import 'package:flutter/widgets.dart';
// import 'package:emembers/utils/core/theme.dart';
import 'package:emembers/data/models/user.dart';
import 'package:emembers/data/web_client.dart';

import '../../../constants.dart';

class FormVerifyNRK {
  final String nrk;
  final String birthdate;

  FormVerifyNRK(this.nrk, this.birthdate);
}

class VerifyNRK extends StatefulWidget {
  VerifyNRK({required Key key, required this.user}) : super(key: key);
  final User user;
  @override
  VerifyNRKHomeState createState() => VerifyNRKHomeState();
}

class VerifyNRKHomeState extends State<VerifyNRK> {
  late TextEditingController _controllerNrk, _controllerBirthdate;

  @override
  initState() {
    _controllerNrk = TextEditingController();
    _controllerBirthdate = TextEditingController();
    super.initState();
  }

  final _formKey = new GlobalKey<FormState>();
  //final _scaffoldKey = GlobalKey<ScaffoldState>();
  // final _passKey = GlobalKey<FormFieldState>();

  bool _isButtonDisabled = true;
  bool _agreedToTOS = false;
  void _setAgreedToTOS(bool? newValue) {
    if (newValue != null) {
      setState(() {
        _agreedToTOS = newValue;
        _isButtonDisabled = newValue == true ? false : true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          "Verify SML Employee",
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
                          Checkbox(
                            value: _agreedToTOS,
                            onChanged: _setAgreedToTOS,
                          ),
                          GestureDetector(
                            //onTap: () => _setAgreedToTOS(!_agreedToTOS),
                            child: Container(
                              width: MediaQuery.of(context).size.width - 50,
                              child: const Text(
                                'Dengan ini Saya Mengetahui dan Menyetujui atas Data yang diinput pada Aplikasi e-Members.',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: new TextFormField(
                          controller: _controllerNrk,
                          autocorrect: false,
                          keyboardType: TextInputType.number,
                          maxLength: 25,
                          validator: (val) =>
                              val.toString().length < 1 ? 'NRK Required' : null,
                          decoration: InputDecoration(
                              hintText: "NRK",
                              labelText: "NRK",
                              suffixIcon: Icon(Icons.people_alt),
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
                    ListTile(
                      title: new TextFormField(
                          controller: _controllerBirthdate,
                          // inputFormatters: [
                          //   new MaskTextInputFormatter(
                          //       mask: '##.##.####',
                          //       filter: {"#": RegExp(r'[0-9]')},
                          //       type: MaskAutoCompletionType.lazy)
                          // ],
                          autocorrect: false,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          validator: (val) => val.toString().length < 1
                              ? 'Card Number Required'
                              : null,
                          decoration: InputDecoration(
                              hintText: "DD.MM.YYYY",
                              labelText: "Birth Date",
                              suffixIcon: Icon(Icons.calendar_today),
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
                    'Verify SML Employee',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  onPressed: _isButtonDisabled
                      ? () {
                          _alertVerifyNrkMsg(
                              context, false, 'Please choose agreement.');
                        }
                      : () {
                          final form = _formKey.currentState;
                          if (form!.validate()) {
                            if (_controllerNrk.text != '' &&
                                _controllerBirthdate.text != '') {
                              final fcp = new FormVerifyNRK(_controllerNrk.text,
                                  _controllerBirthdate.text);
                              _verifyNrk(fcp);
                            } else {
                              _alertVerifyNrkMsg(context, false,
                                  'NRK dan Birth Date is required');
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

  Future<bool> _alertVerifyNrkMsg(
    BuildContext context,
    bool withLogout,
    String message,
  ) async {
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Info'),
        content: Text(message),
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
                _auth
                    .loginById(
                  token: widget.user.token,
                  userid: widget.user.userId,
                )
                    .then((result) {
                  if (result) {
                    Navigator.of(context).pushReplacementNamed('/homepage');
                  }
                });
              }
            },
          ),
        ],
      ),
    );
    return result ?? false;
  }

  Future<void> navigateToHomePage(BuildContext context, user) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomepageWidget(user: user)),
    );
  }

  _verifyNrk(FormVerifyNRK fcp) async {
    var _token = widget.user.token;
    Uri validateURL =
        Uri.parse(Constants.apiGateway + "/Guest/ValidateEmployee");
    Uri updateURL = Uri.parse(Constants.apiGateway + "/Guest/UpdateAsEmployee");

    Map data = {
      "EmployeeId": fcp.nrk,
      "BirthDate": fcp.birthdate,
    };

    var response = await WebClient(User(token: _token)).post(validateURL, data);
    var responseJson = json.decode(response.toString());

    if (responseJson["returnStatus"] == true) {
      Map data = {"Id": widget.user.userId, "EmployeeId": fcp.nrk};
      var responseUpdate =
          await WebClient(User(token: _token)).post(updateURL, data);
      var responseJsonUpdate = json.decode(responseUpdate.toString());
      _alertVerifyNrkMsg(
          context, true, responseJsonUpdate["returnMessage"].toString());
    } else {
      _alertVerifyNrkMsg(
          context, false, responseJson["returnMessage"].toString());
    }
  }
}
