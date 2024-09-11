import 'package:emembers/core/circle_avatar_photo.dart';
import 'package:emembers/data/models/user.dart';
import 'package:emembers/flutter_flow/flutter_flow_theme.dart';
import 'package:emembers/ui/home/homepage_widget.dart';
import 'package:emembers/ui/profile/deleteaccount.dart';
import 'package:emembers/ui/profile/profilepage.dart';
import 'package:emembers/ui/profile/verifysmlemp.dart';
import 'package:emembers/ui/setting/changepassword.dart';
import 'package:emembers/ui/setting/settings.dart';
import 'package:flutter/material.dart';
import 'package:emembers/constants.dart';
import 'package:emembers/data/classes/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoped_model/scoped_model.dart';

import '../profile/paid_confirm.dart';

class AppDrawer extends StatelessWidget {
  final User user;
  AppDrawer({required Key key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    String imgUrl = user.imageUrl == null || user.imageUrl.isEmpty
        ? Constants.apiImage + "/Guest/unknown.jpg"
        : Constants.apiImage +
            "/Guest/" +
            user.imageUrl +
            "?v=" +
            DateTime.now().toString();

    return Drawer(
      child: SafeArea(
        // color: Colors.grey[50],
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              //       decoration: BoxDecoration(
              //   image: DecorationImage(
              //       image: AssetImage(card.bgAsset), fit: BoxFit.cover),
              // ),
              decoration: new BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bgkartu.png'),
                    fit: BoxFit.cover),
              ),
              accountName: Text(
                _auth.user.firstName + " " + _auth.user.lastName,
                style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              accountEmail: Text(
                _auth.user.memberNo.toString() == "" ||
                        _auth.user.memberNo.toString() == "null"
                    ? ""
                    : _auth.user.memberNo.toString(),
                textScaleFactor: AppColors.textScaleFactor,
                maxLines: 1,
              ),
              currentAccountPicture: SizedBox(
                width: 150,
                height: 150,
                child: PSCircleAvatar(
                  borderWidth: 5,
                  color: AppColors.nearlyWhite,
                  child:
                      // MeetNetworkImage(
                      //     imageUrl:imgUrl,
                      //     loadingBuilder: (context) => Center(
                      //           child: CircularProgressIndicator(),
                      //         ),
                      //     errorBuilder: (context, e) => Center(
                      //           child: Text('Error appear!'),
                      //         ),
                      //   ),
                      Image.network(
                    imgUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              onDetailsPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProfilePage(user: user, key: key!)));
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text(
                "Home",
                style: ListTittleProfile,
                textScaleFactor: AppColors.textScaleFactor,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomepageWidget(user: user)));
              },
            ),
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text(
                'Paid Confirm',
                style: ListTittleProfile,
                textScaleFactor: AppColors.textScaleFactor,
              ),
              onTap: () {
                // Navigator.of(context).popAndPushNamed("/paid");
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaidConfirmPage(user: user),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.security),
              title: Text(
                'Change Password',
                style: ListTittleProfile,
                textScaleFactor: AppColors.textScaleFactor,
              ),
              onTap: () {
                //Navigator.of(context).popAndPushNamed("/settings");
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangePassword(
                        key: GlobalKey(),
                        user: user,
                      ),
                    ));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                'Settings',
                style: ListTittleProfile,
                textScaleFactor: AppColors.textScaleFactor,
              ),
              onTap: () {
                //Navigator.of(context).popAndPushNamed("/settings");
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text(
                'Verify SML Employee',
                style: ListTittleProfile,
                textScaleFactor: AppColors.textScaleFactor,
              ),
              onTap: () {
                //Navigator.of(context).popAndPushNamed("/settings");
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VerifyNRK(
                      key: GlobalKey(),
                      user: user,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.delete_forever),
              title: Text(
                'Delete Account',
                style: ListTittleProfile,
                textScaleFactor: AppColors.textScaleFactor,
              ),
              onTap: () {
                //Navigator.of(context).popAndPushNamed("/settings");
                Navigator.pop(context);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => DeleteAccount(user: user))
                //         );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.arrow_back),
              title: Text(
                'Logout',
                style: LogOutText,
                textScaleFactor: AppColors.textScaleFactor,
              ),
              onTap: () => _auth.logout(),
            ),
          ],
        ),
      ),
    );
  }
}
