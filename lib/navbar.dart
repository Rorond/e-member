import 'package:emembers/constants.dart';
import 'package:emembers/ui/activity/history_page.dart';
import 'package:emembers/ui/banner/detailinfo.dart';
import 'package:emembers/ui/qrcode/scan.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:emembers/data/models/user.dart';
import 'package:emembers/data/classes/auth.dart';
import 'package:emembers/ui/home/homepage_widget.dart';
import 'package:emembers/ui/transaction/transaction_widget.dart';
import 'package:emembers/ui/member/member_detail.dart';
import 'package:emembers/ui/profile/profilepage.dart';

import 'flutter_flow/flutter_flow_theme.dart';

class MainScreen extends StatefulWidget {
  final AuthModel auth;
  final User user;

  MainScreen({required this.auth, required this.user});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    if (_currentIndex != 0) {
      setState(() {
        _currentIndex = 0;
      });
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Center(child: _getWidget(widget.user)),
        bottomNavigationBar: FancyBottomNavigationBar(
          currentIndex: _currentIndex,
          onTabTapped: onTabTapped,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SizedBox(
          height: 60,
          width: 60,
          child: FloatingActionButton(
            onPressed: () => onTabTapped(2),
            backgroundColor: AppColors.red,
            shape: CircleBorder(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.qr_code_scanner_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                SizedBox(height: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getWidget(User user) {
    switch (_currentIndex) {
      case 0:
        return HomepageWidget(user: widget.auth.user);
      case 1:
        return TransactionWidget(user: widget.auth.user);
      case 2:
        return ScanScreen(userData: widget.auth.user);
      case 3:
        return HistoryPage(key: UniqueKey(), user: widget.auth.user);
      case 4:
        return ProfilePage(key: UniqueKey(), user: widget.user);
      default:
        return HomepageWidget(user: widget.auth.user);
    }
  }
}

class FancyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  FancyBottomNavigationBar(
      {required this.currentIndex, required this.onTabTapped});

  @override
  Widget build(BuildContext context) {
    Scaffold(backgroundColor: Colors.white);
    return BottomAppBar(
      color: AppColors.primaryBackground,
      shape: CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Container(
        height: 60.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildTabItem(
              context,
              index: 0,
              icon: Icons.home_filled,
              label: 'Home',
            ),
            _buildTabItem(
              context,
              index: 1,
              icon: Icons.credit_card_rounded,
              label: 'Trans',
            ),
            SizedBox(
              width: 80.0,
              child: Text(
                '\nCheck In/Out',
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: FlutterFlowTheme.of(context).bodySmall.fontSize,
                ),
              ),
            ),
            _buildTabItem(
              context,
              index: 3,
              icon: Icons.list_alt,
              label: 'Activity',
            ),
            _buildTabItem(
              context,
              index: 4,
              icon: Icons.person,
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(BuildContext context,
      {required int index, required IconData icon, required String label}) {
    bool isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTabTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon,
              color: isSelected
                  ? FlutterFlowTheme.of(context).primary
                  : Colors.black),
          Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? FlutterFlowTheme.of(context).primary
                  : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: FlutterFlowTheme.of(context).bodySmall.fontSize,
            ),
          ),
        ],
      ),
    );
  }
}
