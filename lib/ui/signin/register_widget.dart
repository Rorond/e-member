import 'package:scoped_model/scoped_model.dart';
import '../../constants.dart';
import '../../data/classes/auth.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FormGuest {
  final String username;
  final String mobilephone;
  final String password;
  final String firstname;
  final String lastname;

  FormGuest(this.username, this.mobilephone, this.password, this.firstname,
      this.lastname);
}

class CreateGuest extends StatefulWidget {
  CreateGuestHomeState createState() => CreateGuestHomeState();
}

class CreateGuestHomeState extends State<CreateGuest> {
  bool _agreedToTOS = true;

  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }

  late TextEditingController _controllerUsername,
      _controllerMobilephone,
      _controllerPassword,
      _controllerConfirmPassword,
      _controllerFirstname,
      _controllerLastname;

  late bool passwordVisibility1;
  TextEditingController? textController6;

  late bool passwordVisibility2;
  final formKey = GlobalKey<FormState>();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    _controllerUsername = TextEditingController();
    _controllerMobilephone = TextEditingController();
    _controllerPassword = TextEditingController();
    _controllerConfirmPassword = TextEditingController();
    _controllerFirstname = TextEditingController();
    _controllerLastname = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: WillPopScope(
            onWillPop: () async =>
                !await _navigatorKey.currentState!.maybePop(),
            child: Navigator(
              key: _navigatorKey,
              onGenerateRoute: (settings) {
                switch (settings.name) {
                  case '/':
                    return MaterialPageRoute(
                        builder: (context) => FormStep1(
                              _setAgreedToTOS,
                              _agreedToTOS,
                              _controllerUsername,
                              _controllerMobilephone,
                              _controllerPassword,
                              _controllerConfirmPassword,
                              _controllerFirstname,
                              _controllerLastname,
                            ));
                    break;
                  case '/step1':
                    return MaterialPageRoute(builder: (context) => FormStep2());
                    break;
                  default:
                    return MaterialPageRoute(
                        builder: (_) => Scaffold(
                              body: Center(
                                  child: Text(
                                      'No route defined for ${settings.name}')),
                            ));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class FormStep1 extends StatefulWidget {
  final TextEditingController controllerUsername,
      controllerMobilephone,
      controllerPassword,
      controllerConfirmPassword,
      controllerFirstname,
      controllerLastname;
  final bool agreedToTOS;
  final Function setAgreedToTOS;
  FormStep1(
      this.setAgreedToTOS,
      this.agreedToTOS,
      this.controllerUsername,
      this.controllerMobilephone,
      this.controllerPassword,
      this.controllerConfirmPassword,
      this.controllerFirstname,
      this.controllerLastname);

  FormStep1Page createState() => FormStep1Page();
}

class FormStep1Page extends State<FormStep1> {
  bool _agreedToTOS = true;

  void _setAgreedToTOS(bool? newValue) {
    setState(() {
      _agreedToTOS = newValue!;
    });
  }

  late bool passwordVisibility1;
  TextEditingController? textController6;

  late bool passwordVisibility2;
  final formKey = GlobalKey<FormState>();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    passwordVisibility1 = false;
    textController6 = TextEditingController();
    passwordVisibility2 = false;
  }

  @override
  void dispose() {
    textController6?.dispose();
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);

    Future _alertCreateGuestMsg(BuildContext context, String message) {
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
            ),
          ],
        ),
      );
    }

    final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
    return Scaffold(
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
                  height: MediaQuery.of(context).size.height * 1.0,
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 300.0,
                          height: 200.0,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: 500.0,
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 5.0),
                                child: Text(
                                  'Full Name',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Outfit',
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.425,
                                    height: 65.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 5.0, 5.0, 5.0),
                                      child: Container(
                                        width: double.infinity,
                                        child: TextFormField(
                                          controller:
                                              widget.controllerFirstname,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily: 'Quicksand',
                                                    ),
                                            hintText: 'First Name',
                                            hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily: 'Quicksand',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .hintText,
                                                    ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
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
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.425,
                                        height: 65.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                        alignment:
                                            AlignmentDirectional(1.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5.0, 5.0, 0.0, 5.0),
                                          child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                              controller:
                                                  widget.controllerLastname,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              'Quicksand',
                                                        ),
                                                hintText: 'Last Name',
                                                hintStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily: 'Quicksand',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .hintText,
                                                    ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .alternate,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Quicksand',
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                              validator: (val) {
                                                if (val == null ||
                                                    val.isEmpty) {
                                                  return 'Field is required';
                                                }

                                                return null;
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 5.0),
                                child: Text(
                                  'Email',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Outfit',
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                                child: Container(
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller: widget.controllerUsername,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Quicksand',
                                          ),
                                      hintText: 'Enter your e-mail',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Quicksand',
                                            color: FlutterFlowTheme.of(context)
                                                .hintText,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Quicksand',
                                          fontSize: 14,
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 5.0),
                                child: Text(
                                  'Phone Number',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Outfit',
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 5.0),
                                child: Container(
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller: widget.controllerMobilephone,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Quicksand',
                                          ),
                                      hintText: 'Enter your phone number',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Quicksand',
                                            color: FlutterFlowTheme.of(context)
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
                                    keyboardType: TextInputType.phone,
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 5.0),
                                child: Text(
                                  'Password',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Outfit',
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 5.0),
                                child: Container(
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller: widget.controllerPassword,
                                    obscureText: false,
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
                                            color: FlutterFlowTheme.of(context)
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 5.0),
                                child: FFButtonWidget(
                                  onPressed: () {
                                    // print(widget.controllerFirstname.value.text);
                                    _auth
                                        .register(
                                      username: widget
                                          .controllerUsername.value.text
                                          .toString()
                                          .toLowerCase()
                                          .trim(),
                                      phone: widget
                                          .controllerMobilephone.value.text
                                          .toString()
                                          .trim(),
                                      password: widget
                                          .controllerPassword.value.text
                                          .toString()
                                          .trim(),
                                      firstname: widget
                                          .controllerFirstname.value.text
                                          .toString()
                                          .trim(),
                                      lastname: widget
                                          .controllerLastname.value.text
                                          .toString()
                                          .trim(),
                                      image: "",
                                    )
                                        .then((result) async {
                                      if (result) {
                                        Navigator.pop(context, true);
                                      } else {
                                        _alertCreateGuestMsg(
                                            context, _auth.errorMsg);
                                      }
                                    });
                                  },
                                  text: 'Create Account',
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 67.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Quicksand',
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
                                    0.0, 5.0, 0.0, 5.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 25.0,
                                  decoration: BoxDecoration(),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Already have account? ',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Quicksand',
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.pushNamed(
                                            'Login',
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey:
                                                  TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType
                                                        .bottomToTop,
                                              ),
                                            },
                                          );
                                        },
                                        child: Text(
                                          'Sign In',
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
    );
  }
}

class FormStep2 extends StatefulWidget {
  final FormGuest? formGuest;
  FormStep2({Key? key, this.formGuest}) : super(key: key);

  FormStep2Page createState() => FormStep2Page();
}

class FormStep2Page extends State<FormStep2> {
  // bool _isButtonDisabled = true;
  // String buttonText = 'Create Account';

  // void _setButtonDisabled(bool newValue) {
  //   setState(() {
  //     _isButtonDisabled = newValue;
  //     if (newValue == false) {
  //       buttonText = 'Create Account Processing..';
  //     } else {
  //       buttonText = 'Create Account';
  //     }
  //   });
  // }

  // @override
  // Widget build(BuildContext context) {
  //   final CameraStore camera = CameraStore();

  //   return AppPageView(
  //     child: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(children: <Widget>[
  //         Text(
  //           'How about a quick selfie?',
  //           textAlign: TextAlign.center,
  //           style: theme.headingTextStyle,
  //         ),
  //         Expanded(
  //           child: Stack(
  //             fit: StackFit.expand,
  //             alignment: AlignmentDirectional.center,
  //             children: <Widget>[
  //               Observer(
  //                   builder: (_) => camera.isCameraReady
  //                       ? PSCircleAvatar(
  //                           child: CameraPreview(camera.controller))
  //                       : PSCircleAvatar(
  //                           color: theme.lightGray,
  //                           child: Center(
  //                               child: Text(
  //                             'No Camera',
  //                             style: TextStyle(color: theme.lightGray),
  //                           )))),
  //               Observer(
  //                   builder: (_) => Align(
  //                         alignment: Alignment.bottomLeft,
  //                         child: SizedBox(
  //                           width: 150,
  //                           height: 150,
  //                           child: PSCircleAvatar(
  //                               borderWidth: 5,
  //                               color: camera.isCameraReady
  //                                   ? theme.radiantRed
  //                                   : theme.lightGray,
  //                               child: camera.capturedPhotoFile != null
  //                                   ? Image.file(File(camera.capturedPhotoFile),
  //                                       fit: BoxFit.fitWidth)
  //                                   : Center(
  //                                       child: Text(
  //                                         'Your Photo',
  //                                         style: theme.actionTextStyle
  //                                             .apply(color: theme.lightGray),
  //                                       ),
  //                                     )),
  //                         ),
  //                       ))
  //             ],
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(vertical: 20.0),
  //           child: _buildActionButtonBar(context, camera, widget.formGuest),
  //         ),
  //       ]),
  //     ),
  //   );
  // }

  // Future<bool> _alertCreateGuestMsg(BuildContext context, String message) {
  //   return showDialog(
  //         context: context,
  //         builder: (context) => new AlertDialog(
  //           title: new Text('Info'),
  //           content: new Text('$message'),
  //           actions: <Widget>[
  //             new TextButton(
  //               style: ButtonStyle(
  //                   backgroundColor:
  //                       MaterialStateProperty.all(AppColors.primaryColor)),
  //               child: Text(
  //                 'Ok',
  //                 textScaleFactor: AppColors.textScaleFactor,
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //               onPressed: () => Navigator.of(context).pop(true),
  //             ),
  //           ],
  //         ),
  //       ) ??
  //       false;
  // }

  // Observer _buildActionButtonBar(
  //     BuildContext context, CameraStore camera, FormGuest formGuest) {
  //   final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
  //   final _scaffoldKey = GlobalKey<ScaffoldState>();
  //   return Observer(
  //     key: _scaffoldKey,
  //     builder: (_) => camera.isCameraReady
  //         ? Column(
  //             children: <Widget>[
  //               CupertinoButton(
  //                   child: Container(
  //                       padding: EdgeInsets.all(16),
  //                       decoration: ShapeDecoration(
  //                           shape: CircleBorder(), color: theme.radiantRed),
  //                       child: Icon(
  //                         CupertinoIcons.photo_camera_solid,
  //                         size: 40,
  //                         color: Colors.white,
  //                       )),
  //                   onPressed: camera.takePicture),
  //               CupertinoButton(
  //                   onPressed: (camera.capturedPhotoFile != null)
  //                       ? () async {
  //                           if (_isButtonDisabled == true) {
  //                             _setButtonDisabled(false);
  //                             File imageFile =
  //                                 new File(camera.capturedPhotoFile);
  //                             List<int> imageBytes =
  //                                 imageFile.readAsBytesSync();
  //                             String base64Image = "data:image/png;base64," +
  //                                 base64.encode(imageBytes);
  //                             _auth
  //                                 .register(
  //                               username: formGuest.username
  //                                   .toString()
  //                                   .toLowerCase()
  //                                   .trim(),
  //                               phone: formGuest.mobilephone.toString().trim(),
  //                               password: formGuest.password.toString().trim(),
  //                               firstname:
  //                                   formGuest.firstname.toString().trim(),
  //                               lastname: formGuest.lastname.toString().trim(),
  //                               image: base64Image,
  //                             )
  //                                 .then((result) async {
  //                               _setButtonDisabled(true);
  //                               if (result) {
  //                                 Navigator.pop(context, true);
  //                               } else {
  //                                 _alertCreateGuestMsg(context, _auth.errorMsg);
  //                               }
  //                             });
  //                             camera.capturedPhotoFile;
  //                           }
  //                         }
  //                       : null,
  //                   color: theme.radiantRed,
  //                   child: Text(
  //                     buttonText,
  //                     style: TextStyle(fontSize: 16),
  //                   ))
  //             ],
  //           )
  //         : CupertinoButton(
  //             child: Text('Proceed without Photo'),
  //             onPressed: () {
  //               _auth
  //                   .register(
  //                 username: formGuest.username.toString().toLowerCase().trim(),
  //                 phone: formGuest.mobilephone.toString().trim(),
  //                 password: formGuest.password.toString().trim(),
  //                 firstname: formGuest.firstname.toString().trim(),
  //                 lastname: formGuest.lastname.toString().trim(),
  //                 image: "",
  //               )
  //                   .then((result) async {
  //                 if (result) {
  //                   Navigator.pop(context, true);
  //                 } else {
  //                   _alertCreateGuestMsg(context, _auth.errorMsg);
  //                 }
  //               });
  //             },
  //           ),
  //   );
  // }
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
