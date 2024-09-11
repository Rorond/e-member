import 'package:emembers/flutter_flow/flutter_flow_theme.dart';
import 'package:emembers/ui/member/membership_list.dart';
import 'package:emembers/ui/menuLoyalty/point_voucher.dart';
import 'package:emembers/ui/menuLoyalty/loyalty_page.dart';
import 'package:emembers/ui/ticket/termcondition.dart';
import 'package:emembers/ui/ticket/ticketing_widget.dart';
import 'package:flutter/material.dart';
import 'package:emembers/data/models/user.dart';
import 'package:emembers/data/models/membershipModel.dart';
import 'package:emembers/ui/clublist/clubListView.dart';
import 'package:emembers/constants.dart';
import 'package:emembers/ui/member/membership_package_list_widget.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
//import 'package:meet_network_image/meet_network_image.dart';

class ClubListView extends StatelessWidget {
  final VoidCallback callback;
  final ProjectList clubData;
  final AnimationController animationController;
  final Animation<double> animation;
  final User user;
  final String selectedMenu;

  const ClubListView({
    Key? key,
    required this.clubData,
    required this.user,
    required this.animationController,
    required this.animation,
    required this.callback,
    required this.selectedMenu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imgDefault =
        Constants.apiContent + "uploads/186bee965af64e269788653e7411a5ec.jpg";

    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 12, right: 12, top: 8, bottom: 16),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () async {
                  await navigateToSelectedMenu(
                      context, selectedMenu, clubData, user);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        offset: Offset(4, 4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            AspectRatio(
                              aspectRatio: 2,
                              child: Image.network(
                                clubData.imageUrl == null
                                    ? imgDefault
                                    : Constants.apiImage +
                                        "/Project/" +
                                        clubData.imageUrl,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                              color: AppColors.chipBackground,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, top: 8, bottom: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(clubData.name,
                                                textAlign: TextAlign.left,
                                                style: clubname),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Icon(
                                                      Icons.location_on_rounded,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      size: 16,
                                                    ),
                                                    Text(clubData.city!,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodySmall),
                                                  ],
                                                ),
                                                SizedBox(width: 4),
                                              ],
                                            ),
                                          ],
                                        ),
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
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> navigateToSelectedMenu(
    BuildContext context,
    String selectedMenu,
    ProjectList clubData,
    User user,
  ) async {
    if (selectedMenu == "Join Member") {
      await Navigator.push(
          context, MembershipListRoute(project: clubData, user: user));
    } else if (selectedMenu == "Ticketing") {
      String imgUrls = Constants.apiImage +
          "/Project/" +
          clubData.imageUrl +
          "?v=" +
          DateTime.now().toString();

      await Navigator.push(context,
          TermConditionRoute(project: clubData, user: user, img: imgUrls));

      // MaterialPageRoute(
      //     builder: (context) => new TicketingListWidget(
      //           user: user,
      //           project: clubData,
      //           img: '',
      //         ))
      // );
    } else if (selectedMenu == "Loyalty") {
      // await Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => new VoucherPointWidget(
      //               initialMenuIndex: 0,
      //               user: user,
      //               project: clubData,
      //             )));

      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => new LoyaltyPage(
                    initialMenuIndex: 0,
                    user: user,
                    project: clubData,
                  )));
    } else if (selectedMenu == "Golf") {
      String imgUrls = Constants.apiImage +
          "/Project/" +
          clubData.imageUrl +
          "?v=" +
          DateTime.now().toString();

      await Navigator.push(context,
          TermConditionRoute(project: clubData, user: user, img: imgUrls));
    }
  }
}
