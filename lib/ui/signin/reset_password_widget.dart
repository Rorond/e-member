import 'dart:convert';

import '../../ui/signin/login_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
// import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

import '../../constants.dart';

import '../../data/models/user.dart';
import '../../data/web_client.dart';

class FormResetPassword {
  final String email;

  FormResetPassword(this.email);
}

class ResetPasswordWidget extends StatefulWidget {
  const ResetPasswordWidget({Key? key}) : super(key: key);

  @override
  _ResetPasswordWidgetState createState() => _ResetPasswordWidgetState();
}

class _ResetPasswordWidgetState extends State<ResetPasswordWidget> {
  late TextEditingController _controllerUsername;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controllerUsername = TextEditingController();
  }

  final _formKey = new GlobalKey<FormState>();

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: ListView(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 5, bottom: 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 10,
                          borderWidth: 1,
                          buttonSize: 45,
                          icon: FaIcon(
                            FontAwesomeIcons.chevronLeft,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 30,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.8,
                    decoration: BoxDecoration(),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      children: [
                        Text(
                          'Reset Passsword',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Quicksand',
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          'Please enter your registered email or phone number below',
                          style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Quicksand',
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                fontWeight: FontWeight.normal,
                              ),
                        ),
                        Container(
                          width: 100,
                          height: MediaQuery.of(context).size.height * 0.14,
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                                child: Text(
                                  'Email Address',
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                              TextFormField(
                                controller: _controllerUsername,
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Ex. user123@sinarmasland.com',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .bodyText2
                                      .override(
                                        fontFamily: 'Quicksand',
                                        lineHeight: 0.75,
                                        fontWeight: FontWeight.w800,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black87,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black87,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black87,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black87,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Quicksand',
                                      lineHeight: 0.75,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14,
                                    ),
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Field is required';
                                  }

                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                          child: FFButtonWidget(
                            onPressed: () {
                              final form = _formKey.currentState;
                              if (form!.validate()) {
                                //Navigator.pushNamed(context, '/step1');
                                final fcp = new FormResetPassword(
                                    _controllerUsername.text);
                                _resetPassword(fcp);
                              }
                            },
                            text: 'Submit',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 43,
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              iconPadding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: FlutterFlowTheme.of(context).primaryColor,
                              textStyle: FlutterFlowTheme.of(context)
                                  .subtitle2
                                  .override(
                                    fontFamily: 'Quicksand',
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
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

  Future _alertChangePasswordMsg(BuildContext context, String message) {
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
            onPressed: () => navigateToHomePage(context),
          ),
        ],
      ),
    );
  }

  Future<Future> navigateToHomePage(BuildContext context) async {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => new LoginWidget()),
    );
  }

  _resetPassword(FormResetPassword fcp) async {
    //var _token = widget.user.token;
    Uri memberURL = Uri.parse(Constants.apiGateway + "/Guest/ResetPassword");

    Map data = {
      "EmailAddress": fcp.email,
    };

    var response = await WebClient(User(token: "")).post(memberURL, data);
    var responseJson = json.decode(response.toString());
    var dataset = responseJson["returnMessage"];
    _alertChangePasswordMsg(context, dataset.toString());
  }
}
