// import 'dart:io';
// import 'dart:convert';

import 'package:emembers/ui/member/price_list.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:emembers/data/models/user.dart';
import 'package:emembers/data/models/membershipModel.dart';

import 'package:emembers/data/web_client.dart';
import '../../../constants.dart';

class MembershipListRoute extends PageRouteBuilder {
  final ProjectList project;
  final User user;
  MembershipListRoute({required this.project, required this.user})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return MembershipListPage(project: project, user: user);
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: new Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: new SlideTransition(
                position: new Tween<Offset>(
                  begin: Offset.zero,
                  end: const Offset(-1.0, 0.0),
                ).animate(secondaryAnimation),
                child: child,
              ),
            );
          },
        );
}

class MembershipListPage extends StatefulWidget {
  final ProjectList project;
  final User user;
  MembershipListPage({required this.project, required this.user});

  @override
  MembershipListState createState() => MembershipListState();
}

class MembershipListState extends State<MembershipListPage> {
  final TextEditingController searchController = TextEditingController();
  bool isShowSearchButton = false;
  int selectedIndex = 0;
  bool isLoading = false;
  List membership = [];
  List searchResults = [];

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    var now = new DateTime.now();
    String nowDate = DateFormat('dd.MM.yyyy').format(now);
    var dateFilter = " validFrom <= Convert(date, '" +
        nowDate +
        "',104) AND validTo >= Convert(date, '" +
        nowDate +
        "',104) AND ";
    var _token = widget.user.token;
    Uri memberURL = Uri.parse(Constants.apiGateway +
        "/Membership/Inquiry" +
        BaseUrlParams.baseUrlParams(widget.user.userId.toString()) +
        "&WhereClause=" +
        dateFilter +
        "projectId=" +
        widget.project.id.toString() +
        "&isGuest=true&PageSize=9999&CurrentPageNumber=1&SortDirection=ASC&SortExpression=Name");
    var response = await WebClient(User(token: _token)).get(memberURL);
    if (response["returnStatus"] == true) {
      var dataset = response["entity"];
      membership = (dataset)
          .map((dataset) => new MembershipList.fromJson(dataset))
          .toList();
      setState(() {
        isLoading = false;
      });
    }
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchData());
  }

  @override
  Widget build(BuildContext context) {
    // todo: implement build
    return Scaffold(
      backgroundColor: AppColors.nearlyWhite,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 30.0, left: 16.0, right: 16.0),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                          Text(
                            'Membership Package List',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20.0),
                          ),
                        ],
                      )),
                  _getSearchSection(),
                  _getClubHouseListSection()
                ],
              ),
            ),
    );
  }

  Widget _getSearchSection() {
    Widget searchBar = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration.collapsed(
                hintText: 'Search for membership package list',
              ),
              onChanged: _searchTextChanged,
            ),
          ),
        )
      ],
    );
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      height: 56.0,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
          child: searchBar,
        ),
      ),
    );
  }

  Widget _getClubHouseListSection() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                decoration:
                    BoxDecoration(color: Colors.white, boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: Offset(0, -2),
                      blurRadius: 0.8),
                ]),
                child: ListView.builder(
                    itemCount: searchController.text.isEmpty
                        ? membership.length
                        : searchResults.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          _getReceiverSection(
                              searchController.text.isEmpty
                                  ? membership[index]
                                  : searchResults[index],
                              widget.user),
                          if (index != membership.length - 1)
                            Divider(thickness: 3)
                        ],
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getReceiverSection(MembershipList receiver, User user) {
    return GestureDetector(
      onTapUp: (tapDetail) {
        Navigator.push(context, PriceListRoute(receiver, user));
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                child: Text(receiver.name.substring(0, 1)),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    receiver.name,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.card_membership,
                            size: 16.0, color: Color(0xFF929091)),
                      ),
                      Text(
                        receiver.price,
                        style:
                            TextStyle(fontSize: 16.0, color: Color(0xFF929091)),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _searchTextChanged(String text) {
    isShowSearchButton = text.isNotEmpty;
    searchResults = membership.where((i) {
      return i.name.toLowerCase().contains(text.toLowerCase());
    }).toList();
    setState(() {});
  }
}
