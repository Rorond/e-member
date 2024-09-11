import 'package:emembers/ui/signin/register_widget.dart';
import 'package:emembers/ui/signin/reset_password_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:emembers/constants.dart';
import 'package:emembers/data/classes/auth.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({this.username});
  final String? username;

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool invisible = false;
  late var dataLogin;
  final AuthModel _auth = AuthModel();

  TextEditingController? _controllerUsername;
  TextEditingController? _controllerPassword;
  late bool passwordVisibility;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    invisible = true;
    _loadUsername();
    _auth.loadSettings();

    super.initState();
    _controllerUsername = TextEditingController(text: 'nadipw@gmail.com');
    passwordVisibility = true;
    _controllerPassword = TextEditingController(text: 'sml12345');
  }

  @override
  void dispose() {
    _controllerUsername?.dispose();
    _controllerPassword?.dispose();
    _unfocusNode.dispose();
    super.dispose();
  }

  void _loadUsername() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _username = _prefs.getString("saved_username") ?? "";
      var _remeberMe = _prefs.getBool("remember_me") ?? false;

      if (_remeberMe) {
        _controllerUsername?.text = _username ?? "";
      }
    } catch (e) {
      print(e);
    }
  }

  Future _alertLoginMsg(BuildContext context, String message) {
    return showDialog(
      context: context,
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
            onPressed: () => Navigator.of(context).pop(true),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AuthModel>(
      model: _auth,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: MediaQuery.of(context).size.height * 0.9,
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 220,
                            height: 120,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        Text('Welcome Sobat \ne-Members!',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: clubname),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.5,
                          decoration: BoxDecoration(),
                          child: Form(
                            key: formKey,
                            autovalidateMode: AutovalidateMode.disabled,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.all(0),
                                  child: Text(
                                    'Email/Phone',
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Quicksand',
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.only(top: 10),
                                  child: Container(
                                    width: double.infinity,
                                    child: TextFormField(
                                      controller: _controllerUsername,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Quicksand',
                                            ),
                                        hintText:
                                            'Enter your email/phone number',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Quicksand',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .hintText,
                                            ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Quicksand',
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return 'Field is required';
                                        }

                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.only(top: 10),
                                  child: Text(
                                    'Password',
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Quicksand',
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.only(top: 10),
                                  child: Container(
                                    width: double.infinity,
                                    child: TextFormField(
                                      controller: _controllerPassword,
                                      obscureText: passwordVisibility,
                                      decoration: InputDecoration(
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Quicksand',
                                            ),
                                        hintText: 'Enter your password',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Quicksand',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .hintText,
                                            ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        suffixIcon: InkWell(
                                          onTap: () => setState(
                                            () => passwordVisibility =
                                                !passwordVisibility,
                                          ),
                                          focusNode:
                                              FocusNode(skipTraversal: true),
                                          child: Icon(
                                            passwordVisibility
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            color: Color(0xFF757575),
                                            size: 22,
                                          ),
                                        ),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Quicksand',
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return 'Field is required';
                                        }

                                        if (val.length < 8) {
                                          return 'Requires at least 8 characters.';
                                        }

                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      bottom: 60, top: 10),
                                  child: InkWell(
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              new ResetPasswordWidget(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 25.0,
                                      decoration: BoxDecoration(),
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional(1.0, 0.0),
                                        child: Text(
                                          'Forgot Password?',
                                          textAlign: TextAlign.end,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Quicksand',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 5.0, 0.0, 5.0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      _auth
                                          .login(
                                        username: _controllerUsername!.text
                                            .toString()
                                            .toLowerCase()
                                            .trim(),
                                        password: _controllerPassword!.text
                                            .toString()
                                            .trim(),
                                      )
                                          .then((result) async {
                                        if (result) {
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  '/homepage');
                                        } else {
                                          _alertLoginMsg(
                                              context, _auth.errorMsg);
                                        }
                                      });
                                    },
                                    text: 'Login',
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 67.0,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'Quicksand',
                                            fontSize: 16.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                      elevation: 3.0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 5.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 25.0,
                                    decoration: BoxDecoration(),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Don\'t have account? ',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Quicksand',
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    new CreateGuest(),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Sign Up',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Quicksand',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
