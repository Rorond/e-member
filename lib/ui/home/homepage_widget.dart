import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:emembers/data/models/eventnewsModel.dart';
import 'package:emembers/data/models/user.dart';
import 'package:emembers/flutter_flow/flutter_flow_widgets.dart';
import 'package:emembers/navbar.dart';
import 'package:emembers/services/customer_point_service.dart';
import 'package:emembers/ui/golf%20old/golfListProject.dart';
import 'package:emembers/ui/golf/golfListProject.dart';
import 'package:emembers/ui/menuLoyalty/comingsoon.dart';
import 'package:emembers/ui/transaction/transaction_widget.dart';
import 'package:emembers/ui/activity/history_page.dart';
import 'package:emembers/ui/app/app_drawer.dart';
import 'package:emembers/ui/banner/detailinfo.dart';
import 'package:emembers/ui/card/bank_card.dart';
import 'package:emembers/ui/clublist/clubHouseHome.dart';
import 'package:emembers/ui/lockedscreen/voucher_point_saya_widget.dart';
import 'package:emembers/ui/menuLoyalty/point_voucher.dart';
import 'package:emembers/ui/member/member_detail.dart';
import 'package:emembers/ui/signin/login_widget.dart';
import 'package:emembers/data/SourceData/eventnews_SourceData.dart';
import 'package:emembers/ui/ticket/ticketing_widget.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:emembers/ui/widgets/appbar_widget.dart';
import 'package:http/http.dart' as http;

import '../../data/models/membershipModel.dart';
import '../../data/web_client.dart';
import '../ticket/termcondition.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'homepage_model.dart';
export 'homepage_model.dart';

import 'package:emembers/constants.dart';
import 'package:emembers/data/classes/auth.dart';

class HomepageWidget extends StatefulWidget {
  final User? user;
  final NewsEventModel? newsEventModel;

  const HomepageWidget({Key? key, this.user, this.newsEventModel})
      : super(key: key);

  @override
  _HomepageWidgetState createState() => _HomepageWidgetState();
}

class _HomepageWidgetState extends State<HomepageWidget> {
  PageController _pageController = PageController(initialPage: 0);

  int _currentPage = 0;

  EventNewsSourceData eventNewsSourceData = EventNewsSourceData();
  late HomepageModel _model;
  List<NewsEventModel>? eventNewsList = [];

  final _scrollController = ScrollController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  bool isLoading = false;

  List<ProjectList> project = List.empty();
  String? nowDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  int _currentIndex = 0;
  int customerPoint = 0;
  // User currentUser = User();
  void getNewEvent() async {
    eventNewsList = await eventNewsSourceData.fetchData();
    setState(() {});
  }

  Future fetchCustomerPoint() async {
    var result = await CustomerPointService().fetchCustomerPoint(widget.user!);
    customerPoint = result.length > 0 ? result[0].customerTotalPoint! : 0;
    widget.user!.totalPoint = customerPoint.toString();

    setState(() {});
  }

  _fetchData() async {
    setState(() {
      isLoading = true;
    });

    Uri memberURL = Uri.parse(Constants.apiGateway +
        "/Project/Inquiry" +
        BaseUrlParams.baseUrlParams(widget.user!.userId.toString()) +
        "&WhereClause=BusinessUnit IN (1,3)&PageSize=10&CurrentPageNumber=1&SortDirection=ASC&SortExpression=id");
    var _token = widget.user!.token;
    var response = await WebClient(User(token: _token)).get(memberURL);
    bool responseData = response == null ? false : true;
    if (response["returnStatus"] == true && responseData == true) {
      var dataset = [];

      // project = (dataset)
      //     .map((dataset) => new ProjectList.fromJson(dataset))
      //     .toList();
      // List set = [];
      // project.clear();
      for (int i = 0; i < response["entity"].length; i++) {
        String price = "0";
        Uri priceUrl = Uri.parse(Constants.apiGateway +
            "/Product/InquiryProductAndPriceByDateParams?OtherClause=" +
            nowDate +
            "&WhereClause=Product.validFrom <= '" +
            nowDate +
            "' AND projectId=" +
            response["entity"][i]["id"].toString() +
            " AND productCategoryId=2&PageSize=9999&CurrentPageNumber=1&SortDirection=ASC&SortExpression=id");
        var responsePrice = await WebClient(User(token: _token)).get(priceUrl);
        if (responsePrice["returnStatus"] == true) {
          var datasetPrice = responsePrice["entity"];
          price =
              datasetPrice.length > 0 ? datasetPrice[0]["priceWeekDay"] : "0";
        }
        Map<String, dynamic> p = {
          "id": response["entity"][i]["id"],
          "name": response["entity"][i]['name'].toString(),
          "companyId": response["entity"][i]['companyId'],
          "imageUrl": response["entity"][i]['imageUrl'],
          "ticketClosedTime": response["entity"][i]['ticketClosedTime'],
          "city": response["entity"][i]['city'] == null
              ? ""
              : response["entity"][i]['city'],
          "currentPrice": price
        };

        dataset.add(p);
        // set.add({
        //   "id": item.id,
        //   "name": item['name'].toString(),
        //   "companyId": item['companyId'],
        //   "imageUrl": item['imageUrl'],
        //   "ticketClosedTime": item['ticketClosedTime'],
        //   "city": item['city'] == null ? "" : item['city'],
        //   "currentPrice": price
        // });
      }
      project = ProjectList.fromJsonList(dataset);
      // project = set;
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCustomerPoint();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchData());

    Timer.periodic(Duration(seconds: 10), (Timer timer) {
      if (_currentPage < eventNewsList!.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });

    getNewEvent();
    _model = createModel(context, () => HomepageModel());
  }

  @override
  void dispose() {
    _model.dispose();
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String imgDefault =
        Constants.apiContent + "uploads/186bee965af64e269788653e7411a5ec.jpg";
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        drawer: AppDrawer(key: UniqueKey(), user: widget.user!),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlutterFlowIconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.bars,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 24,
                  ),
                  onPressed: () async {
                    scaffoldKey.currentState!.openDrawer();
                  },
                ),
                FlutterFlowIconButton(
                  icon: Icon(
                    Icons.notifications_outlined,
                    size: 32,
                  ),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HistoryPage(
                              key: UniqueKey(), user: widget.user!)),
                    );
                  },
                ),
                // Row(
                //   children: [

                //     FlutterFlowIconButton(
                //       borderRadius: 20,
                //       borderWidth: 1,
                //       icon: Icon(
                //         Icons.list_alt,
                //         size: 28,
                //       ),
                //       onPressed: () async {
                //         await Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => HistoryPage(
                //                   key: UniqueKey(), user: widget.user!)),
                //         );
                //       },
                //     )
                //   ],
                // ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: BoxDecoration(),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Stack(
                                children: [
                                  // News
                                  ListView.builder(
                                    controller: _pageController,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: eventNewsList!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      String imageUrl = Constants.apiContent +
                                          eventNewsList![index]
                                              .mainImages!
                                              .first
                                              .url;
                                      return Padding(
                                        padding: EdgeInsets.only(right: 12),
                                        child: InkWell(
                                          onTap: () async {
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MembershipListPage(
                                                  eventnews:
                                                      eventNewsList![index],
                                                  user: widget.user!,
                                                ),
                                              ),
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            child: Image.network(
                                              imageUrl,
                                              width: 315,
                                              height: 80,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  // Say Hello
                                  Align(
                                    alignment: AlignmentDirectional(0.04, 1.63),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.85,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 2,
                                            color: Color(0x33000000),
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15, 0, 10, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Hello, ${widget.user != null ? widget.user!.firstName : "User"}',
                                                  style: AppTittle1,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () async {
                                                        await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                ComingSoon(),
                                                          ),
                                                        );
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .discount_rounded,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              size: 24,
                                                            ),
                                                            SizedBox(height: 4),
                                                            Text('Voucher',
                                                                style:
                                                                    AppTittle1),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 20),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                ComingSoon(),
                                                          ),
                                                        );
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Image.asset(
                                                              'assets/images/Star.png',
                                                              width: 24,
                                                            ),
                                                            SizedBox(height: 4),
                                                            Text(
                                                              '${widget.user != null ? widget.user!.totalPoint : "Point"}',
                                                              style: AppTittle1,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
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
                          ].divide(SizedBox(width: 5)),
                        ),
                      ),

                      // Padding(
                      //   padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                      //   child: Container(
                      //     width: MediaQuery.of(context).size.width * 0.95,
                      //     height: 140,
                      //     decoration: BoxDecoration(),
                      //     child: Row(
                      //       mainAxisSize: MainAxisSize.max,
                      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //       children: [
                      //         Column(
                      //           mainAxisSize: MainAxisSize.max,
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Container(
                      //               width: 60,
                      //               height: 60,
                      //               decoration: BoxDecoration(
                      //                 color: FlutterFlowTheme.of(context)
                      //                     .primaryBackground,
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     blurRadius: 2,
                      //                     color: Color(0x1A000000),
                      //                     offset: Offset(0, -2),
                      //                   ),
                      //                 ],
                      //                 borderRadius: BorderRadius.circular(50),
                      //                 border: Border.all(
                      //                   color: Color(0x15000000),
                      //                   width: 1,
                      //                 ),
                      //               ),
                      //               child: InkWell(
                      //                 onTap: () async {
                      //                   await Navigator.push(
                      //                     context,
                      //                     ClubHouseHomeRoute(
                      //                       userData: _auth.user,
                      //                       menuSelected: "Join Member",
                      //                     ),
                      //                   );
                      //                 },
                      //                 child: Image.asset(
                      //                   'assets/images/member.png',
                      //                   fit: BoxFit.cover,
                      //                 ),
                      //               ),
                      //             ),
                      //             SizedBox(height: 3),
                      //             Text('Join Member', style: MenuApps),
                      //           ],
                      //         ),
                      //         Column(
                      //           mainAxisSize: MainAxisSize.max,
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Container(
                      //               width: 60,
                      //               height: 60,
                      //               decoration: BoxDecoration(
                      //                 color: FlutterFlowTheme.of(context)
                      //                     .primaryBackground,
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     blurRadius: 2,
                      //                     color: Color(0x1A000000),
                      //                     offset: Offset(0, -2),
                      //                   ),
                      //                 ],
                      //                 borderRadius: BorderRadius.circular(50),
                      //                 border: Border.all(
                      //                   color: Color(0x15000000),
                      //                   width: 1,
                      //                 ),
                      //               ),
                      //               child: InkWell(
                      //                 onTap: () async {
                      //                   await Navigator.push(
                      //                     context,
                      //                     ClubHouseHomeRoute(
                      //                       userData: _auth.user,
                      //                       menuSelected: "Ticketing",
                      //                     ),
                      //                   );
                      //                 },
                      //                 child: Image.asset(
                      //                   'assets/images/Ticket.png',
                      //                   fit: BoxFit.cover,
                      //                 ),
                      //               ),
                      //             ),
                      //             SizedBox(height: 3),
                      //             Text('Ticketing', style: MenuApps),
                      //           ],
                      //         ),
                      //         Column(
                      //           mainAxisSize: MainAxisSize.max,
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Container(
                      //               width: 60,
                      //               height: 60,
                      //               decoration: BoxDecoration(
                      //                 color: FlutterFlowTheme.of(context)
                      //                     .primaryBackground,
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     blurRadius: 2,
                      //                     color: Color(0x1A000000),
                      //                     offset: Offset(0, -2),
                      //                   ),
                      //                 ],
                      //                 borderRadius: BorderRadius.circular(50),
                      //                 border: Border.all(
                      //                   color: Color(0x15000000),
                      //                   width: 1,
                      //                 ),
                      //               ),
                      //               child: InkWell(
                      //                 onTap: () async {
                      //                   await Navigator.push(
                      //                     context,
                      //                     MaterialPageRoute(
                      //                       builder: (context) => ComingSoon(),
                      //                     ),
                      //                   );
                      //                 },
                      //                 child: Image.asset(
                      //                   'assets/images/discount.png',
                      //                   fit: BoxFit.cover,
                      //                 ),
                      //               ),
                      //             ),
                      //             SizedBox(height: 3),
                      //             Text('Loyalty', style: MenuApps),
                      //           ],
                      //         ),
                      //         Column(
                      //           mainAxisSize: MainAxisSize.max,
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Container(
                      //               width: 60,
                      //               height: 60,
                      //               decoration: BoxDecoration(
                      //                 color: FlutterFlowTheme.of(context)
                      //                     .primaryBackground,
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     blurRadius: 2,
                      //                     color: Color(0x1A000000),
                      //                     offset: Offset(0, -2),
                      //                   ),
                      //                 ],
                      //                 borderRadius: BorderRadius.circular(50),
                      //                 border: Border.all(
                      //                   color: Color(0x15000000),
                      //                   width: 1,
                      //                 ),
                      //               ),
                      //               child: InkWell(
                      //                 onTap: () async {
                      //                   await Navigator.push(
                      //                     context,
                      //                     MaterialPageRoute(
                      //                       builder: (context) =>
                      //                           MemberDetailPage(
                      //                               userData: _auth.user),
                      //                     ),
                      //                   );
                      //                 },
                      //                 child: Image.asset(
                      //                   'assets/images/id-card.png',
                      //                   fit: BoxFit.cover,
                      //                 ),
                      //               ),
                      //             ),
                      //             SizedBox(height: 3),
                      //             Text('My Card', style: MenuApps),
                      //           ],
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 60, 0, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          height: 200,
                          decoration: BoxDecoration(),
                          child: GridView.count(
                            crossAxisCount: 4,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                            shrinkWrap: true,
                            children: [
                              menuItem(context, 'assets/images/member.png',
                                  'Join Member', () async {
                                await Navigator.push(
                                  context,
                                  ClubHouseHomeRoute(
                                    userData: _auth.user,
                                    menuSelected: "Join Member",
                                  ),
                                );
                              }),
                              menuItem(context, 'assets/images/Ticket.png',
                                  'Ticketing', () async {
                                await Navigator.push(
                                  context,
                                  ClubHouseHomeRoute(
                                    userData: _auth.user,
                                    menuSelected: "Ticketing",
                                  ),
                                );
                              }),
                              menuItem(context, 'assets/images/Ticket.png',
                                  'Loyalty', () async {
                                await Navigator.push(
                                  context,
                                  ClubHouseHomeRoute(
                                    userData: _auth.user,
                                    menuSelected: "Loyalty",
                                  ),
                                );
                              }),
                              // menuItem(context, 'assets/images/discount.png',
                              //     'Loyalty', () async {
                              //   await Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => ComingSoon(),
                              //     ),
                              //   );
                              // }),
                              menuItem(context, 'assets/images/id-card.png',
                                  'My Card', () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MemberDetailPage(userData: _auth.user),
                                  ),
                                );
                              }),
                              menuItem(context, 'assets/images/golf-player.png',
                                  'Golf', () async {
                                await Navigator.push(
                                  context,
                                  ClubHouseHomeRoute(
                                    userData: _auth.user,
                                    menuSelected: "Golf",
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.90,
                        height: 35,
                        child: Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Text("Ticketing Populer", style: AppTittle1),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 230,
                        child: ListView.builder(
                          padding: EdgeInsets.only(left: 20, right: 10),
                          scrollDirection: Axis.horizontal,
                          itemCount: project.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: InkWell(
                                onTap: () async {
                                  String imgUrls = Constants.apiImage +
                                      "/Project/" +
                                      project[index].imageUrl +
                                      "?v=" +
                                      DateTime.now().toString();

                                  await Navigator.push(
                                    context,
                                    TermConditionRoute(
                                      project: project[index],
                                      user: widget.user!,
                                      img: imgUrls,
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 180,
                                  height: 230,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4,
                                        color: Color(0x33000000),
                                        offset: Offset(0, 1),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8),
                                        ),
                                        child: Image.network(
                                          project[index].imageUrl == null
                                              ? imgDefault
                                              : Constants.apiImage +
                                                  "/Project/" +
                                                  project[index].imageUrl,
                                          width: double.infinity,
                                          height: 120,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              project[index].name!,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  size: 16,
                                                ),
                                                Text(
                                                  project[index].city!,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodySmall,
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text(
                                                  'Start From',
                                                  style: bodyText,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  'Rp.${project[index].currentPrice}',
                                                  style: AppTittle,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget menuItem(
    BuildContext context, String assetPath, String label, VoidCallback onTap) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              color: Color(0x1A000000),
              offset: Offset(0, -2),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: Color(0x15000000),
            width: 1,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          child: Image.asset(
            assetPath,
            fit: BoxFit.cover,
          ),
        ),
      ),
      SizedBox(height: 3),
      Text(label, style: MenuApps),
    ],
  );
}
