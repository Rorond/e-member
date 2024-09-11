import 'dart:convert';
import 'dart:io';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:emembers/data/models/viewVoucherHeader.dart';
import 'package:emembers/helpers/shared_preferences.dart';
import 'package:emembers/services/loyalty_service.dart';
import 'package:emembers/ui/ticket/termcondition.dart';
import 'package:flutter/material.dart';
import 'package:emembers/data/models/addproductModels.dart';
import 'package:emembers/data/models/productModels.dart';
import 'package:emembers/data/web_client.dart';
import 'package:emembers/ui/ticket/checkout.dart';
import 'package:emembers/ui/widgets/custom_button.dart';
import 'package:http/http.dart' as http;

import 'package:emembers/constants.dart';
import 'package:emembers/data/models/membershipModel.dart';
import 'package:emembers/data/models/user.dart';
import 'package:emembers/index.dart';
import 'package:emembers/ui/transaction/transaction_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductGolfRoute extends PageRouteBuilder {
  final ProjectList project;
  final User user;
  final String img;
  ProductGolfRoute({
    required this.project,
    required this.user,
    required this.img,
  }) : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return ProductListWidget(
              project: project,
              user: user,
              img: img,
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

class ProductListWidget extends StatefulWidget {
  final ProjectList project;
  final User user;
  final String img;
  ProductListWidget({
    required this.project,
    required this.user,
    required this.img,
  });

  @override
  _GolfWidgetState createState() => _GolfWidgetState();
}

class _GolfWidgetState extends State<ProductListWidget>
    with TickerProviderStateMixin {
  final TextEditingController searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final ScrollController scrollController = ScrollController();
  late TextEditingController _controller;
  //String _initialValue;
  String valueChanged = '';
  String valueToValidate = '';
  String valueSaved = '';

  late AnimationController animationController;
  bool isShowSearchButton = false;
  int selectedIndex = 0;
  bool isLoading = false;
  List productList = [];
  List promoList = [];
  List productCheckout = [];
  List addproduct = [];
  List checkout = [];
  List adminFeeBegining = [];
  List adminFee = [];
  List searchResults = [];
  DateTime initDate = DateTime.now();
  num defaultValue = 0;
  List<num> counter = [];
  List<num> items = [];
  List<num> amount = [];
  num summary = 0;
  num sumCounter = 0;
  late String nowDate;
  DateTime bookingLastDate = DateTime.now();
  DateTime bookingDateSelected = DateTime.now();
  final format = DateFormat("dd MM yyyy");
  List closedperiodes = [];
  static final double _initialToolbarHeight = 300;
  static final double _maxSizeFactor = 1.3;
  static final double _transformSpeed = 0.001;

  List<viewVoucherHeaderData> assignedVouchers = [];

  late ScrollController _controllerScroll;
  double _factor = 1;
  double expandedToolbarHeight = _initialToolbarHeight;

  _fetchData() async {
    setState(() {
      isLoading = true;
    });

    checkPromolog();

    Uri uriBookingPeriode = Uri.parse(Constants.apiContent +
        "/booking-periodes?projectid=" +
        widget.project.id.toString());
    final responseBookingPeriode = await http.get(uriBookingPeriode, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    if (responseBookingPeriode.statusCode == 200) {
      var responseJsonBP = json.decode(responseBookingPeriode.body);
      bookingLastDate =
          initDate.add(Duration(days: responseJsonBP[0]["periode"]));
    }
    Uri uriClosedDate = Uri.parse(Constants.apiContent +
        "/closedperiodes?projectid=" +
        widget.project.id.toString());
    final responseClosedDate = await http.get(uriClosedDate, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    if (responseClosedDate.statusCode == 200) {
      closedperiodes = json.decode(responseClosedDate.body);
    }
    // var bookingDate;
    // if (valueChanged == "") {
    //   bookingDate = new DateTime.now();
    // } else {
    //   bookingDate =
    //       DateTime.parse(valueChanged.replaceAll("-", "") + "T000000");
    // }

    nowDate = DateFormat('yyyy-MM-dd').format(bookingDateSelected);
    String dateFilter = " Product.validFrom <= '" + nowDate + "' AND ";
    String categoryFilter = widget.user.isEmployee == true
        ? " AND productCategoryId IN (2,6) "
        : " AND productCategoryId = 2";
    var _token = widget.user.token;
    Uri memberURL = Uri.parse(Constants.apiGateway +
        "/Product/InquiryProductAndPriceByDateParams?OtherClause=" +
        nowDate +
        "&WhereClause=" +
        dateFilter +
        "projectId=" +
        widget.project.id.toString() +
        categoryFilter +
        "&PageSize=9999&CurrentPageNumber=1&SortDirection=ASC&SortExpression=id");
    var response = await WebClient(User(token: _token)).get(memberURL);
    if (response["returnStatus"] == true) {
      var dataset = response["entity"];
      productList = (dataset)
          .map((dataset) => new ProductListData.fromJson(dataset))
          .toList();
      int idx = 0;
      summary = 0;
      sumCounter = 0;
      productList.forEach((element) {
        if (counter.length > 0) {
          if (counter[idx] > 0) {
            counter[idx] = 0;
          }
          idx++;
        }
        counter.add(0);
        items.add(0);
        amount.add(0);
        adminFeeBegining.add(0);
        adminFee.add(0);
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  _getLastOrder() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var _orderIdOld = _prefs.getString("orderId") ?? "";
    print(_orderIdOld);
    if (_orderIdOld != "") {}
  }

  addToCart(List products, int index, String action) async {
    var bookingDate;
    int qty = 0;
    int sumItems = 0;
    int total = 0;

    addproduct.clear();
    // checkout.clear();
    adminFee.clear();
    // if (valueChanged == "") {
    //   bookingDate = new DateTime.now();
    // } else {
    //   bookingDate =
    //       DateTime.parse(valueChanged.replaceAll("-", "") + "T000000");
    // }
    String _bookingDate = DateFormat('dd.MM.yyyy').format(bookingDateSelected);
    var _token = widget.user.token;
    var empId =
        widget.user.employeeId == null ? '' : widget.user.employeeId.toString();

    Uri urlAddtoCart = Uri.parse(Constants.apiGateway +
        "/Product/AddToCart?ProductId=" +
        products[index].id.toString() +
        "&Quantity=" +
        products[index].quantity.toString() +
        "&BookingDate=" +
        _bookingDate +
        "&EmployeeId=" +
        empId);

    var response = await WebClient(User(token: _token)).post(urlAddtoCart, {});
    var responseJson = json.decode(response.toString());
    if (responseJson["returnStatus"] == true) {
      var dataset = responseJson["entity"];
      addproduct = (dataset)
          .map((dataset) => new AddProductListData.fromJson(dataset))
          .toList();
      for (int i = 0; i < addproduct.length; i++) {
        qty = addproduct.first.quantity;
        sumItems = sumItems + addproduct[i].quantity as int;

        int amount = addproduct[i].price * addproduct[i].quantity;
        total = total + amount;
        addproduct[i].price = addproduct[i].promoName != ""
            ? 0
            : num.parse(products[index].price.replaceAll('.', '')).toInt();
        addproduct[i].imageUrl = products[index].imageUrl;
        // checkout.add(addproduct[i]);
      }
      productList[index].quantity = qty;
      items[index] = sumItems;
      amount[index] = total;
    }
    if (qty > 0) {
      String dateFilter =
          " Description like '" + products[index].id.toString() + "|%' AND ";
      Uri adminfeeURL = Uri.parse(Constants.apiGateway +
          "/Product/InquiryProductAndPriceByDateParams" +
          BaseUrlParams.baseUrlParams(widget.user.userId.toString()) +
          "&OtherClause=" +
          nowDate +
          "&WhereClause=" +
          dateFilter +
          "projectId=" +
          widget.project.id.toString() +
          " AND productCategoryId = 4" +
          "&PageSize=1&CurrentPageNumber=1&SortDirection=ASC&SortExpression=Name");
      var responseAf = await WebClient(User(token: _token)).get(adminfeeURL);
      if (responseAf["returnStatus"] == true &&
          responseAf["entity"].length > 0) {
        var datasetAf = responseAf["entity"];
        adminFeeBegining[index] =
            num.parse(datasetAf.first["currentPrice"].replaceAll('.', ''))
                .toInt();
      }
      if (adminFeeBegining.length > 0) {
        adminFee = List.from(adminFeeBegining);
        adminFee.sort((a, b) => a.compareTo(b));
        // checkout.add(adminFee.last);
      }
    } else {
      adminFeeBegining[index] = 0;
      adminFee = List.from(adminFeeBegining);
      adminFee.sort((a, b) => a.compareTo(b));
    }
    setState(() {
      sumCounter = 0;
      summary = 0;
      counter[index] = qty;
      items.forEach((num e) {
        sumCounter += e;
      });
      amount.forEach((num e) {
        summary += e;
      });
      if (adminFee.length > 0) {
        summary = summary + adminFee.last;
      }
    });
  }

  checkPromolog() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _orderId = _prefs.getString("orderId") ?? "";
      print(_orderId);
      if (_orderId != "") {
        Uri urlOrder = Uri.parse(Constants.apiGateway +
            "/Payment/InquiryOrderOfGuest?WhereClause=id= '" +
            _orderId +
            "' AND status='Draft'");
        var _token = widget.user.token;
        var response = await WebClient(User(token: _token)).get(urlOrder);
        if (response["returnStatus"] == true) {
          List dataset = response["entity"];
          if (dataset.length > 0) {
            Uri urlDelete = Uri.parse(
                Constants.apiGateway + "/Product/PromotionLog/" + _orderId);
            WebClient(User(token: _token)).delete(urlDelete);
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> getData() async {
    // _fetchData();
    return true;
  }

  /// Returns the difference (in full days) between the provided date and today.
  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  void _searchTextChanged(String text) {
    isShowSearchButton = text.isNotEmpty;
    searchResults = productList.where((i) {
      return i.name.toLowerCase().contains(text.toLowerCase());
    }).toList();
    setState(() {});
  }

  _scrollListener() {
    if (_controllerScroll.offset < 0) {
      _factor = 1 + _controllerScroll.offset.abs() * _transformSpeed;
      _factor = _factor.clamp(1, _maxSizeFactor);
      expandedToolbarHeight =
          _initialToolbarHeight + _controllerScroll.offset.abs(); //
    } else {
      _factor = 1;
      expandedToolbarHeight = _initialToolbarHeight; //
    }
    setState(() {});
  }

  Future<List<viewVoucherHeaderData>> getVoucher() async {
    var tenantsData = await LoyaltyService().fetchTenantsData(widget.project);
    var voucherData = await LoyaltyService().fetchVoucherData(
      widget.project,
      tenantsData,
    );
    var voucherList = await LoyaltyService()
        .fetchListVoucher(tenantsData[0].tenantId, widget.project);
    assignedVouchers = await LoyaltyService()
        .fetchReedemVoucher(widget.user, voucherData, voucherList);
    return assignedVouchers;
  }

  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _controller = TextEditingController(
        text: DateFormat("dd MMM yyyy").format(DateTime.now()).toString());
    _controllerScroll = ScrollController();
    _controllerScroll.addListener(_scrollListener);
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
    return Scaffold(
      backgroundColor: AppColors.white,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      child: Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          controller: _controllerScroll,
          slivers: [
            SliverPersistentHeader(
              floating: false,
              pinned: true,
              delegate: _SliverAppBarDelegate(
                minHeight: 100,
                maxHeight: 220,
                child: getAppBarUI(),
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          getSearchBarUI(),
                          getBookingDate(),
                        ],
                      ),
                    ),
                  ),
                  getListProduct(),
                  EmembersButton(
                      key: UniqueKey(),
                      width: 300,
                      height: 50,
                      title: '$sumCounter Items | Total : ' +
                          NumberFormat("#,##0", "id_ID").format(summary),
                      icon: Icons.shopping_basket,
                      iconSize: 20.0,
                      onPressed: () async {
                        if (summary > 0) {
                          DateTime now = new DateTime.now();
                          // String nowTime = new DateFormat("Hms").format(now);
                          // DateTime onbooking;
                          // if (valueChanged == "") {
                          //   onbooking = new DateTime.now();
                          // } else {
                          //   onbooking = DateTime.parse(
                          //       valueChanged.replaceAll("-", "") +
                          //           "T" +
                          //           nowTime);
                          // }
                          Uri uriClosedDate = Uri.parse(Constants.apiGateway +
                              "/WorkingCalendar/Inquiry?WhereClause=ProjectId=" +
                              widget.project.id.toString() +
                              "AND dayOff='" +
                              bookingDateSelected.toString() +
                              "'&PageSize=999&CurrentPageNumber=1");
                          var _token = widget.user.token;
                          var response = await WebClient(User(token: _token))
                              .get(uriClosedDate);
                          if (response["returnStatus"] == true) {
                            var dataset = response["entity"];
                            if (dataset.length == 0) {
                              DateTime close = DateTime.parse(
                                  DateFormat('yyyyMMdd').format(now) +
                                      "T" +
                                      widget.project.ticketClosedTime);
                              if (calculateDifference(bookingDateSelected) ==
                                      0 &&
                                  bookingDateSelected.compareTo(close) > 0) {
                                _alertMsg(
                                    context,
                                    "booking for today has closed at " +
                                        widget.project.ticketClosedTime);
                              } else {
                                // Navigator.push(context, CheckoutRoute(widget.project,productList,widget.user,_controller.text));
                                var vouchersList = await getVoucher();
                                Navigator.push(
                                  context,
                                  CheckoutRoute(
                                    widget.project,
                                    productList,
                                    widget.user,
                                    bookingDateSelected,
                                    summary, // Pass the summary as the total
                                    vouchersList,
                                    0,
                                  ),
                                );
                              }
                            } else {
                              _alertMsg(context, dataset.first["name"]);
                            }
                          }
                        } else {
                          _alertMsg(context, "Please add the product.");
                        }
                      }),
                  // EmembersButton(
                  //   key: UniqueKey(),
                  //   width: 200,
                  //   height: 50,
                  //     title: '$sumCounter Items | Total : ' +
                  //         NumberFormat("#,##0", "id_ID").format(summary),
                  //     icon: Icons.shopping_basket,
                  //     iconSize: 20.0,
                  //     onPressed: () async {
                  //       if (summary > 0) {
                  //         DateTime now = new DateTime.now();
                  //         String nowTime = new DateFormat("Hms").format(now);
                  //         DateTime onbooking;
                  //         if (valueChanged == "") {
                  //           onbooking = new DateTime.now();
                  //         } else {
                  //           onbooking = DateTime.parse(
                  //               valueChanged.replaceAll("-", "") +
                  //                   "T" +
                  //                   nowTime);
                  //         }
                  //         Uri uriClosedDate = Uri.parse(Constants.apiGateway +
                  //             "/WorkingCalendar/Inquiry?WhereClause=ProjectId=" +
                  //             widget.project.id.toString() +
                  //             "AND dayOff='" +
                  //             onbooking.toString() +
                  //             "'&PageSize=999&CurrentPageNumber=1");
                  //         var _token = widget.user.token;
                  //         var response = await WebClient(User(token: _token))
                  //             .get(uriClosedDate);
                  //         if (response["returnStatus"] == true) {
                  //           var dataset = response["entity"];
                  //           if (dataset.length == 0) {
                  //             DateTime close = DateTime.parse(
                  //                 DateFormat('yyyyMMdd').format(now) +
                  //                     "T" +
                  //                     widget.project.ticketClosedTime);
                  //             if (calculateDifference(onbooking) == 0 &&
                  //                 onbooking.compareTo(close) > 0) {
                  //               _alertMsg(
                  //                   context,
                  //                   "booking for today has closed at " +
                  //                       widget.project.ticketClosedTime);
                  //             } else {
                  //               //  Navigator.push(
                  //               //           context,
                  //               //           TermConditionRoute(
                  //               //             project: widget.project,
                  //               //             user: widget.user,
                  //               //             img: _controller.text,
                  //               //           )
                  //               //  );
                  //               Navigator.push(
                  //                   context,
                  //                   CheckoutRoute(widget.project, productList,
                  //                       widget.user, _controller.text));
                  //             }
                  //           } else {
                  //             _alertMsg(context, dataset.first["name"]);
                  //           }
                  //         }
                  //       } else {
                  //         _alertMsg(context, "Please add the product.");
                  //       }
                  //     }),
                ],
              );
            }, childCount: 1)),
          ],
        ),
      ),
    );
  }

  Widget getInfoProject() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.nearlyWhite,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey[100]!.withOpacity(0.2),
              offset: const Offset(0, -2),
              blurRadius: 8.0),
        ],
      ),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 40.0,
            width: MediaQuery.of(context).size.width - 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.project.name,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                      color: AppColors.nearlyBlack),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getBookingDate() {
    DateTime now = DateTime.now();
    final format = DateFormat("dd MMM yyyy");
    return SizedBox(
        height: 70.0,
        width: MediaQuery.of(context).size.width - 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: DateTimeField(
                  format: format,
                  controller: _controller,
                  decoration: InputDecoration(
                      icon: Icon(Icons.event),
                      labelText: 'Tanggal Kedatangan',
                      labelStyle: bodyText),
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                      context: context,
                      firstDate: now,
                      initialDate: currentValue ?? now,
                      lastDate: bookingLastDate,
                    );
                  },
                  onChanged: (val) => setState(() {
                        valueChanged = DateFormat("yyyy-MM-dd").format(val!);
                        bookingDateSelected = val!;
                        sumCounter = 0;
                        summary = 0;
                        addproduct.clear();
                        checkout.clear();
                        adminFee.clear();
                        _fetchData();
                      })),
            ),
          ],
        ));
  }

  Widget getListProduct() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey[100]!.withOpacity(0.2),
              offset: const Offset(0, -2),
              blurRadius: 8.0),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 456,
            child: FutureBuilder<bool>(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: searchController.text.isEmpty
                          ? productList.length
                          : searchResults.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        final List productData = searchController.text.isEmpty
                            ? productList
                            : searchResults;
                        final int count =
                            productList.length > 10 ? 10 : productList.length;
                        final Animation<double> animation =
                            Tween<double>(begin: 0.0, end: 1.0).animate(
                                CurvedAnimation(
                                    parent: animationController,
                                    curve: Interval((1 / count) * index, 1.0,
                                        curve: Curves.fastOutSlowIn)));
                        animationController.forward();
                        return AnimatedBuilder(
                            animation: animationController,
                            builder: (BuildContext context, Widget? child) {
                              return FadeTransition(
                                opacity: animation,
                                child: Transform(
                                  transform: Matrix4.translationValues(
                                      100 * (1.0 - animation.value), 0.0, 0.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          bottom: 8.0, left: 16.0, right: 16.0),
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 16.0),
                                                child: Image.network(
                                                  Constants.apiImage +
                                                      "/Product/" +
                                                      productList[index]
                                                          .imageUrl,
                                                  height: 80.0,
                                                  width: 80.0,
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text(
                                                        productData[index].name,
                                                        style: productname,
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                      Text(
                                                          productData[index]
                                                              .description,
                                                          style: bodyText),
                                                      Container(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Text(
                                                              productData[index]
                                                                  .price,
                                                              style: AppTittle,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: <Widget>[
                                                                  Container(
                                                                    padding:
                                                                        new EdgeInsets
                                                                            .all(
                                                                            4.0),
                                                                    child:
                                                                        new Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        new SizedBox(
                                                                          width:
                                                                              30,
                                                                          height:
                                                                              30,
                                                                          child:
                                                                              FloatingActionButton(
                                                                            heroTag:
                                                                                'Decrement$index',
                                                                            onPressed:
                                                                                () {
                                                                              if (counter[index] - 0 >= 1) {
                                                                                sumCounter = sumCounter;
                                                                                setState(() {
                                                                                  counter[index]--;
                                                                                  // total[index] = (num.parse(productList[index].price.toString().replaceAll('.', '')).toInt() * counter[index]);
                                                                                  productData[index].quantity = counter[index];
                                                                                  // summary = 0;
                                                                                  // total.forEach((num e) {
                                                                                  //   summary += e;
                                                                                  // });
                                                                                  // sumCounter = 0;
                                                                                  // counter.forEach((num e) {
                                                                                  //   sumCounter += e;
                                                                                  // });
                                                                                });
                                                                                addToCart(productData, index, "remove");
                                                                              }
                                                                            },
                                                                            elevation:
                                                                                2,
                                                                            tooltip:
                                                                                'Decrement$index',
                                                                            child:
                                                                                Icon(Icons.remove),
                                                                            backgroundColor:
                                                                                AppColors.nearlyWhite,
                                                                          ),
                                                                        ),
                                                                        new Container(
                                                                          padding:
                                                                              EdgeInsets.all(4.0),
                                                                          child:
                                                                              new Text(
                                                                            counter[index].toString(),
                                                                            style:
                                                                                TextStyle(fontSize: 20.0),
                                                                          ),
                                                                        ),
                                                                        new SizedBox(
                                                                          width:
                                                                              30,
                                                                          height:
                                                                              30,
                                                                          child:
                                                                              FloatingActionButton(
                                                                            heroTag:
                                                                                'Increment$index',
                                                                            onPressed:
                                                                                () {
                                                                              sumCounter = sumCounter;
                                                                              setState(() {
                                                                                counter[index]++;
                                                                                // total[index] = num.parse(productList[index].price.toString().replaceAll('.', '')).toInt() * counter[index];
                                                                                productData[index].quantity = counter[index];
                                                                                // summary = 0;
                                                                                // total.forEach((num e) {
                                                                                //   summary += e;
                                                                                // });
                                                                                // sumCounter = 0;
                                                                                // counter.forEach((num e) {
                                                                                //   sumCounter += e;
                                                                                // });
                                                                              });
                                                                              addToCart(productData, index, "add");
                                                                            },
                                                                            elevation:
                                                                                2,
                                                                            tooltip:
                                                                                'Increment$index',
                                                                            child:
                                                                                Icon(Icons.add),
                                                                            backgroundColor:
                                                                                AppColors.nearlyWhite,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      });
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget getSearchBarUI() {
    return SizedBox(
      height: 72.0,
      width: MediaQuery.of(context).size.width - 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: 64,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffF8FAFB),
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(13.0),
                            bottomLeft: Radius.circular(13.0),
                            topLeft: Radius.circular(13.0),
                            topRight: Radius.circular(13.0),
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                child: TextField(
                                  style: AppTittle,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: 'Search for product',
                                    hintStyle: bodyText,
                                    border: InputBorder.none,
                                    helperStyle: searchText,
                                    labelStyle: searchText,
                                  ),
                                  controller: searchController,
                                  onChanged: _searchTextChanged,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 60,
                              height: 60,
                              child:
                                  Icon(Icons.search, color: Color(0xffB9BABC)),
                            )
                          ],
                        )),
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> _alertMsg(BuildContext context, String message) {
    return showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Info'),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.primaryColor),
                  ),
                  child: Text(
                    'Ok',
                    textScaleFactor: AppColors.textScaleFactor,
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            );
          },
        ) ??
        Future.value(false);
  }

  Widget getAppBarUI() {
    String eImage = widget.img;
    String eTitle = widget.project.name;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      decoration: new BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        image: DecorationImage(image: NetworkImage(eImage), fit: BoxFit.cover),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 30, left: 20),
        child: Column(children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: AppColors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              SizedBox(width: 60),
              // Spacer(),
              Text(
                '$eTitle',
                style: ListTittleProfile,
              ),
            ],
          )
        ]),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
