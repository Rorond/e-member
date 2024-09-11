import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

class RegisterSuccessWidget extends StatefulWidget {
  const RegisterSuccessWidget({Key? key}) : super(key: key);

  @override
  _RegisterSuccessWidgetState createState() => _RegisterSuccessWidgetState();
}

class _RegisterSuccessWidgetState extends State<RegisterSuccessWidget> {
  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      height: 400,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            'assets/images/signupSuccess.png',
            width: 260,
            height: 194,
            fit: BoxFit.cover,
          ),
          Container(
            width: 210,
            height: 50,
            decoration: BoxDecoration(),
            child: Text(
              'Your account has been successfully registered!',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Quicksand',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Container(
            width: 210,
            height: 50,
            decoration: BoxDecoration(),
            child: Text(
              'You can log in to your account ',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Quicksand',
                    color: FlutterFlowTheme.of(context).secondaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ),
          Container(
            width: 280,
            height: 50,
            decoration: BoxDecoration(),
            child: FFButtonWidget(
              onPressed: () {
                print('Button pressed ...');
              },
              text: 'Ok, Got it!',
              options: FFButtonOptions(
                width: 130,
                height: 40,
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                color: FlutterFlowTheme.of(context).primaryColor,
                textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                      fontFamily: 'Quicksand',
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
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
    );
  }
}
