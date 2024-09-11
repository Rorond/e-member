import 'dart:io';

import 'package:emembers/ui/home/homepage_widget.dart';
import 'package:flutter/material.dart';
// import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../constants.dart';
import '../../../data/classes/auth.dart';

// Stateful widget for managing name data
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    return new Scaffold(
        appBar: AppBar(
          title: Text(
            "Settings",
            textScaleFactor: AppColors.textScaleFactor,
          ),
          backgroundColor: AppColors.primaryColor,
        ),
        body: new WillPopScope(
          onWillPop: () {
            return navigateToHomePage(context, _auth.user);
          },
          child: SingleChildScrollView(
              child: SafeArea(
            child: ListBody(
              children: <Widget>[
                Container(
                  height: 10.0,
                ),
                // ListTile(
                //   leading: Icon(Icons.fingerprint),
                //   title: Text(
                //     'Enable Biometrics',
                //     textScaleFactor: AppColors.textScaleFactor,
                //   ),
                //   subtitle: Platform.isIOS
                //       ? Text(
                //           'TouchID or FaceID',
                //           textScaleFactor: AppColors.textScaleFactor,
                //         )
                //       : Text(
                //           'Fingerprint',
                //           textScaleFactor: AppColors.textScaleFactor,
                //         ),
                //   trailing: Switch.adaptive(
                //     activeColor: AppColors.primaryColor,
                //     onChanged: _auth.handleIsBioSetup,
                //     value: _auth.isBioSetup,
                //   ),
                // ),
                Divider(
                  height: 20.0,
                ),
                ListTile(
                  leading: Icon(Icons.account_box),
                  title: Text(
                    'Stay Logged In',
                    textScaleFactor: AppColors.textScaleFactor,
                  ),
                  subtitle: Text(
                    'Logout from the Main Menu',
                    textScaleFactor: AppColors.textScaleFactor,
                  ),
                  trailing: Switch.adaptive(
                    activeColor: AppColors.primaryColor,
                    onChanged: _auth.handleStayLoggedIn,
                    value: _auth.stayLoggedIn,
                  ),
                ),
                Divider(height: 20.0),
              ],
            ),
          )),
        ));
  }

  // Future<bool> navigateToHomePage(BuildContext context, user) async {
  //   return Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => new MyHomePage(user: user)),
  //   );
  // }
  Future<bool> navigateToHomePage(BuildContext context, user) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomepageWidget(user: user)),
    );
    return true;
  }
}
