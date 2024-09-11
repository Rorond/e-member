import 'package:emembers/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
// import 'package:native_widgets/native_widgets.dart';
import 'package:emembers/data/models/user.dart';
import 'package:emembers/data/web_client.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ticket_widget/ticket_widget.dart';
import '../../../constants.dart';
//import '../../../utils/popUp.dart';

class TransactionDetailRoute extends PageRouteBuilder {
  TransactionDetailRoute(User user, String projectid, String paymentid)
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return TransactionDetail(
                user: user, projectid: projectid, paymentid: paymentid);
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

// class TransactionDetail extends StatefulWidget {
//   final User? user;
//   final String? projectid;
//   final String? paymentid;
//   TransactionDetail({required this.user, required this.projectid, required this.paymentid});

//   @override
//   TransactionDetailState createState() => TransactionDetailState();
// }

class TransactionDetail extends StatefulWidget {
  final User? user;
  final String projectid;
  final String paymentid;

  TransactionDetail({
    required this.user,
    required this.projectid,
    required this.paymentid,
  });
  @override
  TransactionDetailState createState() => TransactionDetailState();
}

class TransactionDetailState extends State<TransactionDetail>
    with TickerProviderStateMixin {
  static final memberURL = Constants.apiGateway + "/Gate/";
  var isLoading = false;
  int selectedCardIndex = 0;
  late String inputErrorText;
  late AnimationController animationController;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final List transactionItems = [];

  _fetchData() async {
    Uri url = Uri.parse(memberURL +
        widget.projectid +
        "/GetPassCode" +
        BaseUrlParams.baseUrlParams(widget.user!.userId.toString()) +
        "&order_id=" +
        widget.paymentid);
    var _token = widget.user!.token;
    var response = await WebClient(User(token: _token)).get(url);
    bool responseData = response == null ? false : true;
    if (response["returnStatus"] == true && responseData == true) {
      var dataset = response["entity"];

      for (var i = 0; i < dataset.length; i++) {
        transactionItems.add(dataset[i]);
      }
      setState(() {});
    }
  }

  static List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
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
    // final bodyHeight = MediaQuery.of(context).size.height -
    //     MediaQuery.of(context).viewInsets.bottom;
    // double height = MediaQuery.of(context).size.height;
    // todo: implement build
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
              "My Ticket",
              style: ListTittleProfile,
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
      key: _scaffoldKey,
      backgroundColor: Color(0xFFF4F4F4),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            transactionItems.length > 0
                ? new Expanded(
                    child: new Swiper(
                      autoplay: false,
                      itemCount: transactionItems.length,
                      pagination: new SwiperPagination(
                          margin: new EdgeInsets.all(5.0),
                          builder: new SwiperCustomPagination(builder:
                              (BuildContext context,
                                  SwiperPluginConfig config) {
                            return new ConstrainedBox(
                              child: new Column(
                                children: <Widget>[
                                  new Expanded(
                                    child: new Align(
                                      alignment: Alignment.center,
                                      child: new DotSwiperPaginationBuilder(
                                              color: AppColors.darkGray,
                                              activeColor:
                                                  AppColors.primaryColor,
                                              size: 10.0,
                                              activeSize: 20.0)
                                          .build(context, config),
                                    ),
                                  )
                                ],
                              ),
                              constraints:
                                  new BoxConstraints.expand(height: 50.0),
                            );
                          })),
                      control: new SwiperControl(color: AppColors.primaryColor),
                      itemBuilder: (BuildContext context, int index) {
                        return transactionItem(transactionItems[index], index);
                      },
                    ),
                  )

                // new CarouselSlider(
                //     items: map<Widget>(
                //       transactionItems,
                //       (index, e) {
                //         return transactionItem(e, index);
                //       },
                //     ).toList(),
                //     height: bodyHeight - 88.0,
                //     viewportFraction: 0.9,
                //     aspectRatio: 2.0,
                //     reverse: false,
                //     autoPlay: false,
                //     enlargeCenterPage: true,
                //     enableInfiniteScroll: false,
                //     initialPage: 0,
                //   )
                : new Container(),
          ],
        ),
      ),
    );
  }

  Widget transactionItem(Map transactionList, int index) {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String name = transactionList["item_name"];
    bool isused = transactionList["is_used"];
    int idx = index + 1;
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
            width: MediaQuery.of(context).size.width * 0.8,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(right: 113.0),
                            child: Text(
                              '#$idx',
                              style: clubname,
                            )),
                        Container(
                          width: 120.0,
                          height: 25.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            border: Border.all(
                                width: 1.0,
                                color: isused == false
                                    ? Colors.green
                                    : Colors.red),
                          ),
                          child: Center(
                            child: isused == false
                                ? Text('Not Used',
                                    style: TextStyle(color: Colors.green))
                                : Text('Already Used',
                                    style: TextStyle(color: Colors.red)),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        name,
                        style: clubname,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Column(
                        children: <Widget>[
                          ticketDetailsWidget(
                              'Purchased by',
                              widget.user!.firstName +
                                  ' ' +
                                  widget.user!.lastName,
                              'Tgl. Kedatangan',
                              transactionList["booking_date"]),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 40.0,
                      ),
                      child: Center(
                        child: Container(
                          width: screenWidth * 0.5,
                          height: screenHeight * 0.5,
                          child: QrImageView(
                            data: transactionList["id"] +
                                '|' +
                                transactionList["payment_method_name"],
                            size: 0.5 * bodyHeight,
                            // onError: (ex) {
                            //   print("[QR] ERROR - $ex");
                            //   setState(() {
                            //     inputErrorText =
                            //         "Error! Maybe your input value is too long?";
                            //   });
                            // },
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        transactionList["id"],
                        style: bodyText1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget ticketDetailsWidget(String firstTitle, String firstDesc,
      String secondTitle, String secondDesc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                firstTitle,
                style: AppTittle1,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  firstDesc,
                  style: AppTittle,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                secondTitle,
                style: AppTittle1,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  secondDesc,
                  style: AppTittle,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
