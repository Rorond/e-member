import 'package:flutter/material.dart';
// import 'dart:convert';

// import 'package:native_widgets/native_widgets.dart';
import 'package:emembers/data/models/user.dart';
import 'package:emembers/data/web_client.dart';
import '../home/homepage_widget.dart';
import '../../data/models/orderInquiryModel.dart';
import '../transaction/transcationdetail.dart';

import '../../../constants.dart';
import '../../../flutter_flow/flutter_flow_util.dart';

class TransactionRoute extends PageRouteBuilder {
  TransactionRoute(User user)
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return Transaction(user: user);
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

class Transaction extends StatefulWidget {
  final User? user;
  Transaction({this.user});

  @override
  TransactionState createState() => TransactionState();
}

class TransactionState extends State<Transaction>
    with TickerProviderStateMixin {
  static final memberURL =
      Constants.apiGateway + "/Payment/InquiryOrderOfGuest";
  bool isLoading = false;
  int selectedCardIndex = 0;
  TransactionModel? transactionList;

  AnimationController? animationController;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    var _token = widget.user!.token == "null" ? "" : widget.user!.token;
    DateTime initDate = new DateTime.now();
    String bookingDate =
        DateFormat('yyyy-MM-dd').format(initDate.subtract(Duration(days: 7)));

    Uri uri = Uri.parse(memberURL +
        BaseUrlParams.baseUrlParams(widget.user!.userId.toString()) +
        "&WhereClause= booking_date >= '" +
        bookingDate +
        "' AND email='" +
        widget.user!.emailAddress +
        "' AND status='Draft' Order By booking_date DESC");

    var response = await WebClient(User(token: _token)).get(uri);
    transactionList = TransactionModel.fromJson(response);

    if (transactionList!.returnStatus = true) {
      for (var i = 0; i < transactionList!.entity!.length; i++) {
        Uri paymentUrl = Uri.parse(Constants.apiGateway +
            "/Payment/Inquiry" +
            BaseUrlParams.baseUrlParams("4") +
            "&WhereClause=Payment.order_id='" +
            transactionList!.entity![i].id +
            "' AND Payment.status IN ('settlement', 'capture')&PageSize=10&CurrentPageNumber=1&SortDirection=DESC&SortExpression=process_date");

        var response = await WebClient(User(token: _token)).get(paymentUrl);
        bool responseData = response == null ? false : true;
        if (response["returnStatus"] == true && responseData == true) {
          var dataset = response["entity"];
          if (dataset.length > 0) {
            Uri urlUpdateStatusOrder =
                Uri.parse(Constants.apiGateway + "/Payment/UpdateOrderStatus");

            Map orderUpdate = {
              "id": transactionList!.entity![i].id,
              "name": transactionList!.entity![i].name,
              "status": "Paid"
            };
            WebClient(User(token: _token))
                .post(urlUpdateStatusOrder, orderUpdate);
          }
          // transactionList.entity[i].status = "Paid";

          // if (transactionList.entity[i].status == "Paid") {
          //   Entity entity = transactionList.entity[i];
          //   paidList.add(entity);
          // }
        }
      }
    }

    Uri uriOrderPaid = Uri.parse(memberURL +
        BaseUrlParams.baseUrlParams(widget.user!.userId.toString()) +
        "&WhereClause=status='Paid' AND email='" +
        widget.user!.emailAddress +
        "' Order By booking_date DESC");
    var responseOrderPaid =
        await WebClient(User(token: _token)).get(uriOrderPaid);
    transactionList = TransactionModel.fromJson(responseOrderPaid);

    if (transactionList!.returnStatus = true) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Future<bool> _willPopCallback() async {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomepageWidget(user: widget.user)));
    return true;
  }

  @override
  initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    // todo: implement build
    return WillPopScope(
        child: new Scaffold(
          key: _scaffoldKey,
          backgroundColor: Color(0xFFF4F4F4),
          appBar: AppBar(
            title: Text("My Transaction"),
            backgroundColor: AppColors.primaryColor,
          ),
          body: isLoading
              ? Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: ListView(
                            children: <Widget>[
                              transactionItem(transactionList!.entity!)
                            ],
                          ),
                        ),
                        flex: 90,
                      ),
                    ],
                  ),
                ),
        ),
        onWillPop: _willPopCallback);
  }

  Widget transactionItem(List<Entity> transactionList) {
    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height - 106,
          child: FutureBuilder<bool>(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              } else {
                return transactionList.length > 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: transactionList.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          final int count = transactionList.length;
                          var animation = Tween(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: animationController!,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn)));
                          animationController!.forward();
                          return AnimatedBuilder(
                            animation: animationController!,
                            builder: (BuildContext? context, Widget? child) {
                              return FadeTransition(
                                opacity: animation,
                                child: new Transform(
                                  transform: new Matrix4.translationValues(
                                      0.0, 50 * (1.0 - animation.value), 0.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 32.0,
                                              right: 32.0,
                                              top: 16.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 8,
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: AppColors.white,
                                            ),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  ListTile(
                                                    title: Text(
                                                      transactionList[index]
                                                          .projectName!,
                                                      style: AppTexts
                                                          .textFormFieldH_3,
                                                    ),
                                                  ),
                                                  const Divider(
                                                    color: Colors.grey,
                                                    height: 10,
                                                    thickness: 1,
                                                    indent: 0,
                                                    endIndent: 0,
                                                  ),
                                                  transactionTextWidget(
                                                      transactionList[index]
                                                          .processDate!,
                                                      transactionList[index]
                                                          .name!),
                                                  const Divider(
                                                    color: Colors.grey,
                                                    height: 10,
                                                    thickness: 1,
                                                    indent: 0,
                                                    endIndent: 0,
                                                  ),
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                      vertical: 15,
                                                      horizontal: 15,
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              Text(
                                                                'Booking By : ',
                                                                style: AppTexts
                                                                    .textFormFieldRegular
                                                                    .copyWith(
                                                                        fontSize:
                                                                            14),
                                                              ),
                                                              Text(
                                                                transactionList[
                                                                            index]
                                                                        .firstName! +
                                                                    " " +
                                                                    transactionList[
                                                                            index]
                                                                        .lastName!,
                                                                style: AppTexts
                                                                    .textFormFieldRegular
                                                                    .copyWith(
                                                                        fontSize:
                                                                            14),
                                                              ),
                                                            ]),
                                                        SizedBox(
                                                          height: 6,
                                                        ),
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              Text(
                                                                'Tanggal Kedatangan : ',
                                                                style: AppTexts
                                                                    .textFormFieldRegular
                                                                    .copyWith(
                                                                        fontSize:
                                                                            14),
                                                              ),
                                                              Text(
                                                                transactionList[
                                                                        index]
                                                                    .bookingDate!,
                                                                style: AppTexts
                                                                    .textFormFieldRegular
                                                                    .copyWith(
                                                                        fontSize:
                                                                            14),
                                                              ),
                                                            ]),
                                                        SizedBox(
                                                          height: 6,
                                                        ),
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              Text(
                                                                'Total Amount: ',
                                                                style: AppTexts
                                                                    .textFormFieldRegular
                                                                    .copyWith(
                                                                        fontSize:
                                                                            14),
                                                              ),
                                                              Text(
                                                                transactionList[
                                                                        index]
                                                                    .totalAmount!,
                                                                style: AppTexts
                                                                    .textFormFieldRegular
                                                                    .copyWith(
                                                                        fontSize:
                                                                            14),
                                                              ),
                                                            ]),
                                                        SizedBox(
                                                          height: 6,
                                                        ),
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              Text(
                                                                'Payment Status : ',
                                                                style: AppTexts
                                                                    .textFormFieldRegular
                                                                    .copyWith(
                                                                        fontSize:
                                                                            14),
                                                              ),
                                                              Text(
                                                                transactionList[
                                                                        index]
                                                                    .status!,
                                                                style: AppTexts
                                                                    .textFormFieldRegular
                                                                    .copyWith(
                                                                        fontSize:
                                                                            14),
                                                              ),
                                                            ]),
                                                      ],
                                                    ),
                                                  ),
                                                  const Divider(
                                                    color: Colors.grey,
                                                    height: 10,
                                                    thickness: 1,
                                                    indent: 0,
                                                    endIndent: 0,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 5.0,
                                                                bottom: 5.0),
                                                        child: new TextButton(
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty
                                                                      .all(AppColors
                                                                          .primaryColor)),
                                                          child: Text(
                                                            'Details',
                                                            textScaleFactor:
                                                                AppColors
                                                                    .textScaleFactor,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context!,
                                                                TransactionDetailRoute(
                                                                    widget
                                                                        .user!,
                                                                    transactionList[
                                                                            index]
                                                                        .projectId!
                                                                        .toString(),
                                                                    transactionList[
                                                                            index]
                                                                        .id!));
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      )
                    : new Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Please try refreshing to display the transaction list.',
                              textScaleFactor: AppColors.textScaleFactor,
                              style: TextStyle(color: Colors.black),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 5.0, bottom: 5.0),
                              child: new TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              AppColors.primaryColor)),
                                  child: Text(
                                    'Refresh',
                                    textScaleFactor: AppColors.textScaleFactor,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    _fetchData();
                                  }),
                            ),
                          ],
                        ),
                      );
              }
            },
          ),
        )
      ],
    );
  }

  Widget transactionTextWidget(String firstTitle, String firstDesc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                firstTitle,
                style: AppTexts.textFormFieldRegular.copyWith(fontSize: 14),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  firstDesc,
                  style: AppTexts.textFormFieldRegular.copyWith(fontSize: 14),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
