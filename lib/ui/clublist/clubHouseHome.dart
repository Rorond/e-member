import 'package:emembers/constants.dart';
import 'package:emembers/core/loading_page.dart';
import 'package:emembers/data/web_client.dart';
import 'package:emembers/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:emembers/data/models/user.dart';
import 'package:emembers/data/models/membershipModel.dart';
import 'package:emembers/ui/clublist/clubListView.dart';

class ClubHouseHomeRoute extends PageRouteBuilder {
  final User userData;
  final menuSelected;
  ClubHouseHomeRoute({required this.userData, required this.menuSelected})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return ClubHouseHome(
              userData: userData,
              menuSelected: menuSelected,
            );
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

class ClubHouseHome extends StatefulWidget {
  final User userData;
  final String menuSelected;
  ClubHouseHome({required this.userData, required this.menuSelected});

  @override
  ClubHouseHomeState createState() => ClubHouseHomeState();
}

class ClubHouseHomeState extends State<ClubHouseHome>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  final TextEditingController searchController = TextEditingController();
  bool isShowSearchButton = false;
  int selectedIndex = 0;
  bool isLoading = false;

  List project = [];

  List searchResults = [];

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    String strWhere = "";

    if (widget.menuSelected == "Join Member") {
      strWhere = "&WhereClause=BusinessUnit IN (2,3)";
    } else if (widget.menuSelected == "Ticketing") {
      strWhere = "&WhereClause=BusinessUnit IN (1,3)";
    } else if (widget.menuSelected == "Golf") {
      strWhere = "&WhereClause=BusinessUnit = 4";
    }
    Uri memberURL = Uri.parse(Constants.apiGateway +
        "/Project/Inquiry" +
        BaseUrlParams.baseUrlParams(widget.userData.userId.toString()) +
        strWhere +
        "&PageSize=10&CurrentPageNumber=1&SortDirection=ASC&SortExpression=id");
    var _token = widget.userData.token;
    var response = await WebClient(User(token: _token)).get(memberURL);
    bool responseData = response == null ? false : true;
    if (response["returnStatus"] == true && responseData == true) {
      var dataset = response["entity"];

      project = (dataset)
          .map((dataset) => new ProjectList.fromJson(dataset))
          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void initState() {
    animationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchData());
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // todo: implement build
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      body: isLoading
          ? LoadingPage()
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
                          Spacer(),
                          Text('Club House List', style: ListTittleProfile),
                          Spacer(flex: 2),
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
                hintText: 'Search for club house',
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
            borderRadius: BorderRadius.all(Radius.circular(11.0))),
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
                color: AppColors.chipBackground,
                child: ListView.builder(
                  itemCount: searchController.text.isEmpty
                      ? project.length
                      : searchResults.length,
                  padding: EdgeInsets.only(top: 8),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    var countList = searchController.text.isEmpty
                        ? project.length
                        : searchResults.length;
                    var count = countList > 10 ? 10 : countList;
                    var animation = Tween(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                            parent: animationController,
                            curve: Interval((1 / count) * index, 1.0,
                                curve: Curves.fastOutSlowIn)));
                    animationController.forward();
                    return ClubListView(
                      key: UniqueKey(),
                      callback: () {},
                      clubData: searchController.text.isEmpty
                          ? project[index]
                          : searchResults[index],
                      user: widget.userData,
                      animation: animation,
                      animationController: animationController,
                      selectedMenu: widget.menuSelected,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _searchTextChanged(String text) {
    isShowSearchButton = text.isNotEmpty;
    searchResults = project.where((i) {
      return i.name.toLowerCase().contains(text.toLowerCase());
    }).toList();
    setState(() {});
  }
}
