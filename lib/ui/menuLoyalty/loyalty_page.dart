import 'package:emembers/data/models/membershipModel.dart';
import 'package:emembers/data/models/user.dart';
import 'package:emembers/flutter_flow/flutter_flow_theme.dart';
import 'package:emembers/ui/menuLoyalty/history/loyalty_history_page.dart';
import 'package:emembers/ui/menuLoyalty/point/point_page.dart';
import 'package:emembers/ui/menuLoyalty/voucher/voucher_page.dart';
import 'package:emembers/ui/menuLoyalty/loyalty_controller.dart';
import 'package:emembers/ui/menuLoyalty/widgets/info_card.dart';
import 'package:flutter/material.dart';

class LoyaltyPage extends StatefulWidget {
  final int initialMenuIndex;
  final User? user;
  final ProjectList? project;

  const LoyaltyPage({
    Key? key,
    required this.initialMenuIndex,
    this.user,
    this.project,
  }) : super(key: key);

  @override
  State<LoyaltyPage> createState() => LoyaltyController();

  Widget build(context, LoyaltyController controller) {
    controller.view = this;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'User Point',
          style: ListTittleProfile,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Align(
                  alignment: AlignmentDirectional(0.04, 1.38),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 120,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          color: Color(0x33000000),
                          offset: Offset(0, 2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(controller.userPoints.toString() + ' Point',
                                style: AppTittle1),
                            Divider(color: Colors.black),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CardInfo(
                                  icon: Icons.point_of_sale_outlined,
                                  label: 'Poin',
                                  onTap: () {
                                    controller.setActiveMenu(0);
                                  },
                                  isActive: controller.activeMenuIndex == 0,
                                ),
                                VerticalDivider(
                                  thickness: 2,
                                  color: Theme.of(context).dividerColor,
                                ),
                                CardInfo(
                                  icon: Icons.history_edu_rounded,
                                  label: 'Voucher',
                                  onTap: () {
                                    controller.setActiveMenu(1);
                                  },
                                  isActive: controller.activeMenuIndex == 1,
                                ),
                                VerticalDivider(
                                  thickness: 2,
                                  color: Theme.of(context).dividerColor,
                                ),
                                CardInfo(
                                  icon: Icons.history,
                                  label: 'History',
                                  onTap: () {
                                    controller.setActiveMenu(2);
                                  },
                                  isActive: controller.activeMenuIndex == 2,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: controller.isViewVoucherActive
                    ? PointPage(
                        user: user,
                        project: project,
                      )
                    : controller.isAssignVoucherActive
                        ? VoucherPage(
                            user: user,
                            project: project!,
                          )
                        : LoyaltyHistoryPage(
                            user: user,
                            project: project!,
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
