import 'dart:convert';
import 'package:emembers/ui/home/homepage_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:flutter/widgets.dart';
// import 'package:emembers/utils/core/theme.dart';
import 'package:emembers/data/models/user.dart';
import 'package:emembers/data/classes/auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:emembers/data/web_client.dart';

import '../../../constants.dart';

class FormChangePassword {
  final String email;
  final String password;
  final String passwordConfirm;

  FormChangePassword(this.email, this.password, this.passwordConfirm);
}

class ChangePassword extends StatefulWidget {
  ChangePassword({required Key key, required this.user}) : super(key: key);
  final User user;
  @override
  ChangePasswordHomeState createState() => ChangePasswordHomeState();
}

class ChangePasswordHomeState extends State<ChangePassword> {
  late TextEditingController _controllerUsername,
      _controllerPassword,
      _controllerConfirmPassword;

  @override
  initState() {
    _controllerUsername = TextEditingController(text: widget.user.emailAddress);
    _controllerPassword = TextEditingController();
    _controllerConfirmPassword = TextEditingController();
    super.initState();
  }

  final _formKey = new GlobalKey<FormState>();
  //final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _passKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings", style: TextStyle(color: Colors.white),
          // textScaleFactor: AppColors.textScaleFactor,
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: new WillPopScope(
        onWillPop: () async {
          await navigateToHomePage(context, widget.user);
          return false;
        },
        // onWillPop: () {
        //   return navigateToHomePage(context, widget.user);
        // },
        child: Container(
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Email', icon: Icon(Icons.email)),
                        validator: (val) =>
                            val.toString().length < 1 ? 'Email Required' : null,
                        onSaved: (val) => val,
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        controller: _controllerUsername,
                        autocorrect: false,
                      ),
                    ),
                    ListTile(
                      title: TextFormField(
                        key: _passKey,
                        decoration: InputDecoration(
                            labelText: 'Password', icon: Icon(Icons.lock)),
                        validator: (val) => val.toString().length < 1
                            ? 'Password Required'
                            : null,
                        onSaved: (val) => val,
                        obscureText: true,
                        controller: _controllerPassword,
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                      ),
                    ),
                    ListTile(
                      title: new Padding(
                        padding: EdgeInsets.fromLTRB(35.0, 0.0, 0.0, 0.0),
                        child: TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Retype Password'),
                          validator: (confirmation) {
                            if (confirmation!.isEmpty)
                              return 'Enter confirm password';
                            var password = _passKey.currentState!.value;
                            return (confirmation == password)
                                ? null
                                : "Confirm Password should match password";
                          },
                          onSaved: (val) => val,
                          obscureText: true,
                          controller: _controllerConfirmPassword,
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.primaryColor)),
                  child: Text(
                    'Change Password',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form!.validate()) {
                      //Navigator.pushNamed(context, '/step1');
                      final fcp = new FormChangePassword(
                          _controllerUsername.text,
                          _controllerPassword.text,
                          _controllerConfirmPassword.text);
                      _changePassword(fcp);
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

  void _alertChangePasswordMsg(
      BuildContext context, FormChangePassword fcp, String message) {
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => new AlertDialog(
            title: new Text('Info'),
            content: new Text('$message'),
            actions: <Widget>[
              new TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.primaryColor)),
                  child: Text(
                    'Ok',
                    textScaleFactor: AppColors.textScaleFactor,
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                    _auth.logout();
                    _auth
                        .login(
                      username: fcp.email.toString().toLowerCase().trim(),
                      password: fcp.password.toString().trim(),
                    )
                        .then((result) {
                      if (result) {
                        navigateToHomePage(context, widget.user);
                      }
                    });
                  }),
            ],
          ),
        ) ??
        false;
  }

  // Future<bool> navigateToHomePage(BuildContext context, user) async {
  //   return Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => new MyHomePage(user: user)),
  //   );
  // }

  Future<void> navigateToHomePage(BuildContext context, user) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomepageWidget(user: user)),
    );
  }

  _changePassword(FormChangePassword fcp) async {
    var _token = widget.user.token;
    Uri memberURL = Uri.parse(Constants.apiGateway + "/Guest/ChangePassword");

    Map data = {
      "EmailAddress": fcp.email,
      "Password": fcp.password,
      "PasswordConfirmation": fcp.passwordConfirm,
    };

    var response = await WebClient(User(token: _token)).post(memberURL, data);
    var responseJson = json.decode(response.toString());
    var dataset = responseJson["returnMessage"];
    _alertChangePasswordMsg(context, fcp, dataset.toString());
  }
}
