import 'package:emembers/flutter_flow/flutter_flow_theme.dart';
import 'package:emembers/index.dart';
import 'package:emembers/ui/transaction/transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:emembers/data/models/user.dart';
import 'package:emembers/data/models/TransactionModel.dart';
import 'package:emembers/data/web_client.dart';
import 'package:emembers/constants.dart';

class Success1View extends StatefulWidget {
  final User user;
  final String orderId;
  final String orderName;
  final List payment;
  final num? configPoint;
  const Success1View(
      {Key? key,
      required this.user,
      required this.orderId,
      required this.orderName,
      required this.payment,
      this.configPoint})
      : super(key: key);

  @override
  PaymentSuccessPage createState() => PaymentSuccessPage();
}

class PaymentSuccessPage extends State<Success1View> {
  final image = 'assets/images/success.png';
  final TextStyle subtitle = TextStyle(fontSize: 12.0, color: Colors.grey);
  final TextStyle label = TextStyle(fontSize: 14.0, color: Colors.grey);
  int customerPoint = 0;

  @override
  Widget build(BuildContext context) {
    final num? configPoint = widget.configPoint;
    final num? total = widget.configPoint;
    int points = (total! / configPoint!).floor();
    customerPoint = points;
    List transcationTime =
        widget.payment.first["transaction_time"].toString().split(" ");
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeader(),
            SizedBox(height: 40.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Text(
                    widget.payment.first["transaction_status"] == "capture"
                        ? "Transaction Succsesfull"
                        : "Transaction Failed",
                    style: TextStyle(
                        fontSize: 24.0,
                        color: widget.payment.first["transaction_status"] ==
                                "capture"
                            ? Colors.green
                            : Colors.red),
                  ),
                  widget.payment.first["transaction_status"] == "capture"
                      ? Text(
                          widget.payment.first["status_message"],
                          style: TextStyle(fontSize: 14.0, color: Colors.green),
                        )
                      : Text(
                          "",
                          style: TextStyle(fontSize: 14.0, color: Colors.red),
                        ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "DATE",
                        style: label,
                      ),
                      Text("TIME", style: label)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(transcationTime.first),
                      Text(transcationTime.last)
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Purchased by',
                            style: label,
                          ),
                          Text(widget.user.firstName +
                              ' ' +
                              widget.user.lastName),
                          Text(
                            widget.user.emailAddress,
                            style: subtitle,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "AMOUNT",
                            style: label,
                          ),
                          Text(widget.payment.first["gross_amount"]),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text('Points $points', style: PointText),
                          ),
                        ],
                      ),
                      Text(
                        widget.payment.first["transaction_status"] == "capture"
                            ? "COMPLETED"
                            : "FAILED",
                        style: label,
                      )
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.account_balance_wallet),
                        ),
                        SizedBox(width: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Credit/Debit Card"),
                            Text(
                              "Bank Card ending ***" +
                                  widget.payment.first["masked_card"]
                                      .toString()
                                      .substring(widget.payment
                                              .first["masked_card"].length -
                                          2),
                              style: subtitle,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            widget.payment.first["transaction_status"] == "expire"
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      child: new TextButton(
                        child: Text(
                          'Refresh',
                          style:
                              TextStyle(fontSize: 16, color: AppColors.white),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                AppColors.primaryColor)),
                        onPressed: () async {
                          var _token = widget.user.token;
                          Uri uri = Uri.parse(Constants.apiGateway +
                              "/Payment/InquiryOrder" +
                              BaseUrlParams.baseUrlParams(
                                  widget.user.userId.toString()) +
                              "&WhereClause=order_id='" +
                              widget.orderId +
                              "'");
                          var response =
                              await WebClient(User(token: _token)).get(uri);
                          TransactionModel transactionList =
                              TransactionModel.fromJson(response);

                          if (transactionList.returnStatus = true) {
                            if (transactionList.entity!.first.status ==
                                    'capture' ||
                                transactionList.entity!.first.status ==
                                    'settlement') {
                              Uri memberURL = Uri.parse(Constants.apiGateway +
                                  "/Payment/UpdateOrderStatus");

                              Map orderUpdate = {
                                "id": widget.orderId,
                                "name": widget.orderName,
                                "status": "Paid"
                              };
                              WebClient(User(token: _token))
                                  .post(memberURL, orderUpdate);
                            }
                          }
                        },
                      ),
                    ),
                  )
                : SizedBox(),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 72.0,
                    child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Image.asset("assets/images/logo.png")),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          height: 50,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 5.0),
                  child: Container(
                      child: new TextButton(
                    child: Text(
                      'Home',
                      style: TextStyle(fontSize: 16, color: AppColors.white),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.primaryColor)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  new HomepageWidget(user: widget.user)));
                    },
                  )),
                ),
                flex: 2,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Container(
                      child: new TextButton(
                    child: new Text("My Trax",
                        style: TextStyle(fontSize: 16, color: AppColors.white)),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.primaryColor)),
                    onPressed: () {
                      Navigator.push(
                          context, TransactionWidget() as Route<Object?>);
                    },
                  )),
                ),
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildHeader() {
    final Color colorOne =
        widget.payment.first["transaction_status"] == "capture"
            ? Color(0xff28C76F)
            : Color(0xffFA696C);
    final Color colorTwo =
        widget.payment.first["transaction_status"] == "capture"
            ? Color(0xff81FBB8)
            : Color(0xffFA8165);
    final Color colorTree =
        widget.payment.first["transaction_status"] == "capture"
            ? Color(0xff81FBB8)
            : Color(0xffFB8964);
    return Container(
      height: 250,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: -100,
            top: -150,
            child: Container(
              width: 350,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [colorOne, colorTwo]),
                  boxShadow: [
                    BoxShadow(
                        color: colorTwo,
                        offset: Offset(4.0, 4.0),
                        blurRadius: 10.0)
                  ]),
            ),
          ),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [colorTree, colorTwo]),
                boxShadow: [
                  BoxShadow(
                      color: colorTree,
                      offset: Offset(1.0, 1.0),
                      blurRadius: 4.0)
                ]),
          ),
          Positioned(
            top: 100,
            right: 200,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [colorTree, colorTwo]),
                  boxShadow: [
                    BoxShadow(
                        color: colorTree,
                        offset: Offset(1.0, 1.0),
                        blurRadius: 4.0)
                  ]),
            ),
          ),
          Positioned(
              bottom: 0,
              left: -50,
              top: -60,
              child: Container(
                margin: const EdgeInsets.only(top: 0, left: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      color: AppColors.notWhite,
                      icon: Icon(
                        widget.payment.first["transaction_status"] == "capture"
                            ? Icons.check_circle_outline_rounded
                            : Icons.highlight_off_rounded,
                        size: 250,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
