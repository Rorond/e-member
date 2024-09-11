import 'package:emembers/data/models/user.dart';
import 'package:emembers/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ticket_widget/ticket_widget.dart';
import '../../../constants.dart';

class QrisRoute extends PageRouteBuilder {
  QrisRoute(
      {required User user,
      required String qrCode,
      required String bookingDate,
      required String orderId,
      required String orderName,
      required String amount})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return Qris(
                user: user,
                qrCode: qrCode,
                bookingDate: bookingDate,
                orderId: orderId,
                orderName: orderName,
                amount: amount);
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

class Qris extends StatefulWidget {
  final User user;
  final String qrCode;
  final String bookingDate;
  final String orderId;
  final String orderName;
  final String amount;
  Qris(
      {required this.user,
      required this.qrCode,
      required this.bookingDate,
      required this.orderId,
      required this.orderName,
      required this.amount});

  @override
  QrisState createState() => QrisState();
}

class QrisState extends State<Qris> with TickerProviderStateMixin {
  static final memberURL =
      Constants.apiGateway + "/Payment/InquiryOrderOfGuest";
  bool isLoading = false;
  int selectedCardIndex = 0;
  // TransactionModel transactionList;

  late AnimationController animationController;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Future<bool> _willPopCallback() async {
    Navigator.pop(context);
    // Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => MyHomePage(user: widget.user)));
    return Future.value(true);
  }

  @override
  initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
    // _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // todo: implement build
    return WillPopScope(
        child: new Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text("My Transaction", style: ListTittleProfile),
            centerTitle: true,
          ),
          body: isLoading
              ? Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        height: bodyHeight * 0.8,
                        child: TicketWidget(
                          width: 300.0,
                          height: bodyHeight * 0.8,
                          isCornerRounded: true,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    widget.orderName,
                                    style: clubname,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Column(
                                    children: <Widget>[
                                      transactionTextWidget(
                                          'Total: ', widget.amount),
                                      transactionTextWidget(
                                          'Tgl. Kedatangan : ',
                                          widget.bookingDate),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 40.0,
                                      left: 10.0,
                                      right: 10.0,
                                      bottom: 10.0),
                                  child: Center(
                                    child: Container(
                                      width: screenWidth * 0.5,
                                      height: screenHeight * 0.5,
                                      // child: QrImage(
                                      //   data: widget.qrCode,
                                      //   size: 0.5 * bodyHeight,
                                      //   // onError: (ex) {
                                      //   //   print("[QR] ERROR - $ex");
                                      //   //   setState(() {
                                      //   //     inputErrorText =
                                      //   //         "Error! Maybe your input value is too long?";
                                      //   //   });
                                      //   // },
                                      // ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        ),
        onWillPop: _willPopCallback);
  }

  Widget transactionTextWidget(String firstTitle, String firstDesc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          firstTitle,
          style: AppTittle1,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            firstDesc,
            style: AppTittle1,
          ),
        )
      ],
    );
  }
}
