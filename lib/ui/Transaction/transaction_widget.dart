import 'package:emembers/data/models/membershipModel.dart';
import 'package:emembers/index.dart';
import 'package:emembers/ui/home/homepage_widget.dart';
import 'package:emembers/ui/ticket/ticketing_widget.dart';
import 'package:emembers/ui/transaction/transcationdetail.dart';
// import 'custom_bottom_navigation_bar.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:emembers/constants.dart';
import 'package:emembers/data/web_client.dart';
import 'package:emembers/data/models/user.dart';
import 'package:emembers/data/models/transactionModel.dart';

// import 'transaction_model.dart';
// export 'transaction_model.dart';

class TransactionWidget extends StatefulWidget {
  final User? user;
  const TransactionWidget({Key? key, this.user}) : super(key: key);

  @override
  _TransactionWidgetState createState() => _TransactionWidgetState();
}

class _TransactionWidgetState extends State<TransactionWidget> {
  // late TransactionModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 1;
  TextEditingController searchtext = TextEditingController();
  static final memberURL =
      Constants.apiGateway + "/Payment/InquiryOrderOfGuest";
  bool isLoading = false;
  int selectedCardIndex = 0;
  TransactionModel transactionList = TransactionModel();
  TransactionModel paidList = TransactionModel();

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    DateTime initDate = new DateTime.now();
    String bookingDate =
        DateFormat('yyyy-MM-dd').format(initDate.subtract(Duration(days: 7)));

    var user;
    Uri uri = Uri.parse(memberURL +
        BaseUrlParams.baseUrlParams(widget.user!.userId.toString()) +
        "&WhereClause=status='Paid' AND email='" +
        widget.user!.emailAddress +
        "' Order By booking_date DESC");
    var _token = widget.user!.token;
    var response = await WebClient(User(token: _token)).get(uri);
    transactionList = TransactionModel.fromJson(response) as TransactionModel;

    if (transactionList.returnStatus = true) {
      for (var i = 0; i < transactionList.entity!.length; i++) {
        Uri urlPassCode = Uri.parse(Constants.apiGateway +
            "/Gate/" +
            transactionList.entity![i].projectId.toString() +
            "/GetPassCode" +
            BaseUrlParams.baseUrlParams(widget.user!.userId.toString()) +
            "&order_id=" +
            transactionList.entity![i].id);

        var _token = widget.user!.token;
        var responsePassCode =
            await WebClient(User(token: _token)).get(urlPassCode);
        bool responseDataPassCode = responsePassCode == null ? false : true;
        if (responsePassCode["returnStatus"] == true &&
            responseDataPassCode == true) {
          //var dataset = responsePassCode["entity"];
          Uri urlUpdateStatusOrder =
              Uri.parse(Constants.apiGateway + "/Payment/UpdateOrderStatus");

          Map orderUpdate = {
            "id": transactionList.entity![i].id,
            "name": transactionList.entity![i].firstName,
            "status": "Paid"
          };
          WebClient(User(token: _token))
              .post(urlUpdateStatusOrder, orderUpdate);
          // transactionList.entity[i].status = "Paid";

          // if (transactionList.entity[i].status == "Paid") {
          //   Entity entity = transactionList.entity[i];
          //   paidList.add(entity);
          // }
        }
      }
      // paidList.entity = transactionList.entity.where((i) {
      //   return i.status.toLowerCase().contains('Paid');
      // }).toList();
      Uri uri = Uri.parse(memberURL +
          BaseUrlParams.baseUrlParams(widget.user!.userId.toString()) +
          "&WhereClause= status='Paid' AND email='" +
          widget.user!.emailAddress +
          "' Order By booking_date DESC");
      var _token = widget.user!.token;
      var response = await WebClient(User(token: _token)).get(uri);
      paidList = TransactionModel.fromJson(response);
      if (paidList.returnStatus = true) {}
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void initState() {
    super.initState();
    // _model = createModel(context, () => TransactionModel());
    _fetchData();
    // _model.textController ??= TextEditingController();
  }

  @override
  void dispose() {
    // _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: AppColors.primaryBackground,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.black,
          ),
          onPressed: () {
            Navigator.pushNamed(context, "/homepage");
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Text(
              "Transaction List",
              style: ListTittleProfile,
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
      backgroundColor: AppColors.primaryBackground,
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.90,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: paidList.entity == null
                    ? SizedBox()
                    : transactionItem(paidList.entity!),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget transactionItem(List<Entity> transactionList) {
    return Column(
      children: <Widget>[
        Container(
          child: FutureBuilder<bool>(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              } else {
                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  shrinkWrap: true,
                  itemCount: transactionList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1,
                              color: Color(0x33000000),
                              offset: Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(transactionList[index].projectName!,
                                  style: AppTittle),
                              Divider(thickness: 2),
                              Text(transactionList[index].bookingDate!,
                                  style: bodyText1),
                              Text(transactionList[index].name!,
                                  style: AppTittle1),
                              Divider(thickness: 2),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Booking by: ${transactionList[index].firstName!}',
                                          style: AppTittle),
                                      Text(
                                          'Tanggal Kedatangan: ${transactionList[index].bookingDate!}',
                                          style: bodyText1),
                                      Text(
                                          'Total Amount: Rp. ${transactionList[index].totalAmount!}',
                                          style: AppTittle),
                                      Text(
                                          'Payment Status: ${transactionList[index].status!}',
                                          style: AppTittle),
                                    ],
                                  ),
                                  FFButtonWidget(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          TransactionDetailRoute(
                                              widget.user!,
                                              transactionList[index]
                                                  .projectId!
                                                  .toString(),
                                              transactionList[index]
                                                  .id!
                                                  .toString()));
                                    },
                                    text: 'Details',
                                    options: FFButtonOptions(
                                      height: 32,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 12),
                                      color: Colors.white,
                                      textStyle: ButtonTextColor,
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        )
      ],
    );
  }
}
