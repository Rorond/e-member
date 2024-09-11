import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:emembers/constants.dart';
import 'package:emembers/data/models/addproductModels.dart';
import 'package:emembers/data/models/membershipModel.dart';
import 'package:emembers/data/models/paymentModel.dart';
import 'package:emembers/data/models/user.dart';
import 'package:emembers/data/models/viewVoucherHeader.dart';
import 'package:emembers/data/web_client.dart';
import 'package:emembers/flutter_flow/flutter_flow_theme.dart';
import 'package:emembers/flutter_flow/flutter_flow_util.dart';
import 'package:emembers/helpers/shared_preferences.dart';
import 'package:emembers/ui/ticket/webviews.dart';
import 'package:emembers/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutMidtransRoute extends PageRouteBuilder {
  CheckoutMidtransRoute(
    ProjectList project,
    List product,
    User user,
    DateTime bookingDate,
    viewVoucherHeaderData? voucher,
    int totalPoint,
  ) : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return Checkout(
              total: 0,
              checkout: [],
              project: project,
              product: product,
              user: user,
              bookingDate: bookingDate,
              voucher: voucher,
              totalPoint: totalPoint,
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

class Checkout extends StatefulWidget {
  final ProjectList project;
  final List product;
  final List checkout;
  final User user;
  final num total;
  final DateTime bookingDate;
  final viewVoucherHeaderData? voucher;
  final int totalPoint;

  Checkout({
    required this.project,
    required this.product,
    required this.checkout,
    required this.total,
    required this.user,
    required this.bookingDate,
    this.voucher,
    required this.totalPoint,
  });

  @override
  CheckoutState createState() => CheckoutState();
}

class CheckoutState extends State<Checkout> {
  Uri memberURL = Uri.parse(Constants.apiGateway + "/Guest/GetMembership");
  var isLoading = false;
  int selectedCardIndex = 0;
  late String idCardType, idCardNum;
  TextEditingController _textCardNumController = TextEditingController();
  TextEditingController _textCardExpController = TextEditingController();
  TextEditingController _textCVVController = TextEditingController();

  var maskFormatterCardNum = new MaskTextInputFormatter(
      mask: '####-####-####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  var maskFormatterCVV = new MaskTextInputFormatter(
      mask: '###',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  var maskFormatterCardExp = new MaskTextInputFormatter(
      mask: '##/##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  final GlobalKey<ScaffoldState> _scaffoldKeyPayment =
      new GlobalKey<ScaffoldState>();

  final List transferTo = [];
  List productList = [];
  List promoList = [];
  List productCheckout = [];
  List addproduct = [];
  List checkout = [];
  List adminFee = [];
  List searchResults = [];
  DateTime initDate = DateTime.now();
  num defaultValue = 0;
  List<num> counter = [];
  int total = 0;
  num summary = 0;
  num sumCounter = 0;
  late String bookingDate;
  String mobilePhone = "";
  late int idMobilePhone;
  late bool _isButtonDisabled;
  String buttonText = "Payment";

  _getData() async {
    int sumItems = 0;
    total = 0;
    sumCounter = 0;
    summary = 0;
    addproduct.clear();
    checkout.clear();
    adminFee.clear();

    // String _bookingDate = DateFormat('dd.MM.yyyy').format(widget.bookingDate);
    // DateTime.parse(widget.bookingDate.replaceAll("-", "") + "T000000");

    bookingDate = DateFormat('dd.MM.yyyy').format(widget.bookingDate);
    var _token = widget.user.token;
    var order =
        widget.product.where((product) => product.quantity > 0).toList();
    for (var x = 0; x < order.length; x++) {
      Uri urlAddtoCart = Uri.parse(Constants.apiGateway +
          "/Product/AddToCart?ProductId=" +
          order[x].id.toString() +
          "&Quantity=" +
          order[x].quantity.toString() +
          "&BookingDate=" +
          bookingDate);
      var response =
          await WebClient(User(token: _token)).post(urlAddtoCart, {});
      var responseJson = json.decode(response.toString());
      if (responseJson["returnStatus"] == true) {
        var dataset = responseJson["entity"];
        addproduct = (dataset)
            .map((dataset) => new AddProductListData.fromJson(dataset))
            .toList();

        for (int i = 0; i < addproduct.length; i++) {
          sumItems = sumItems + addproduct[i].quantity as int;
          int amount = addproduct[i].price * addproduct[i].quantity;
          total = total + amount;
          // addproduct[i].price = addproduct[i].promoName != ""
          //     ? 0
          //     : num.parse(order[x].price.replaceAll('.', '')).toInt();
          addproduct[i].imageUrl = order[x].imageUrl;
          checkout.add(addproduct[i]);
        }
      }
      String bookingDateforAdminFee =
          DateFormat("yyyy-MM-dd").format(widget.bookingDate);
      String dateFilter =
          " Description like '" + order[x].id.toString() + "|%' AND ";
      Uri adminfeeURL = Uri.parse(Constants.apiGateway +
          "/Product/InquiryProductAndPriceByDateParams?OtherClause=" +
          bookingDateforAdminFee +
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
        adminFee.add(new AddProductListData.fromJson({
          "productId": datasetAf.first["id"],
          "price":
              num.parse(datasetAf.first["currentPrice"].replaceAll('.', ''))
                  .toInt(),
          "quantity": 1,
          "productCode": "Admin Fee",
          "productName": datasetAf.first["name"],
          "promoName": "",
          "bookingDate": widget.bookingDate,
          "imageUrl": datasetAf.first["imageUrl"]
        }));
      }
    }

    setState(() {
      if (adminFee.length > 0) {
        adminFee.sort((a, b) => a.price.compareTo(b.price));
        checkout.add(adminFee.last);
        total = total + adminFee.last.price as int;
      }
    });
  }

  @override
  initState() {
    _getData();
    _isButtonDisabled = false;
    _textCardNumController = TextEditingController();
    _textCardExpController = TextEditingController();
    _textCVVController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // todo: implement build
    return Scaffold(
      key: _scaffoldKeyPayment,
      backgroundColor: Color(0xFFF4F4F4),
      appBar: AppBar(
        title: Text(
          "Checkout",
          style: ListTittleProfile,
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFF4F4F4),
      ),
      body: new Center(
        child: Container(
          child: ListView(
            children: <Widget>[
              checkoutItem(widget.product, checkout),
              _getEnterAmountSection(total),
              _getPaymentMethodeSection(),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 4.0, right: 16.0),
                child: Text(
                  "Pastikan saldo/balance pulsa Nomor Handphone e-banking anda tersedia.",
                  style:
                      TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
              ),
              EmembersButton(
                key: UniqueKey(),
                width: 200,
                height: 50,
                title: '$buttonText',
                icon: Icons.credit_card,
                iconSize: 20.0,
                onPressed: () {
                  if (_textCardNumController.text.isNotEmpty &&
                      _textCVVController.text.isNotEmpty &&
                      _textCardExpController.text.isNotEmpty) {
                    if (_isButtonDisabled == false) {
                      setState(() {
                        _isButtonDisabled = true;
                        buttonText = 'Payment Processing...';
                      });
                      _createOrder(widget.project, checkout, total, widget.user,
                          bookingDate);
                    }
                  } else {
                    _alertMsg(context, "Please fill all card form.");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget checkoutItem(List productList, List checkoutList) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(11.0))),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Colors.grey.shade200)),
          padding: EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return checkoutListItem(checkoutList[index]);
            },
            itemCount: checkoutList.length,
            shrinkWrap: true,
            primary: false,
            scrollDirection: Axis.vertical,
          ),
        ),
      ),
    );
  }

  Widget checkoutListItem(AddProductListData checkout) {
    num subtotal = checkout.price * checkout.quantity;
    // String bookDate = widget.bookingDate;
    if (checkout.quantity > 0) {
      return Card(
          child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: <Widget>[
            Container(
              child: Image(
                image: NetworkImage(
                    Constants.apiImage + "/Product/" + checkout.imageUrl),
                width: 35,
                height: 45,
                fit: BoxFit.fitHeight,
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1)),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 8, top: 4),
                      child: Text(
                        checkout.promoName == ""
                            ? checkout.productName
                            : checkout.productName + " " + checkout.promoName,
                        maxLines: 2,
                        softWrap: true,
                        style:
                            AppTexts.textFormFieldMedium.copyWith(fontSize: 12),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        'Tanggal Kedatangan : ' +
                            DateFormat('dd-MM-yyyy').format(widget.bookingDate),
                        maxLines: 2,
                        softWrap: true,
                        style:
                            AppTexts.textFormFieldMedium.copyWith(fontSize: 12),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      '${NumberFormat("#,##0", "id_ID").format(checkout.price)} x ${checkout.quantity} = ' +
                          NumberFormat("#,##0", "id_ID").format(subtotal),
                      style: AppTexts.textFormFieldMedium
                          .copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ]),
            ),
          ],
        ),
      ));
    } else {
      return SizedBox();
    }
  }

  Widget _getEnterAmountSection(num total) {
    int points = (total / 200000).floor();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(11.0))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                child: Text(
                  'Amount',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '\IDR',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30.0),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          NumberFormat("#,##0", "id_ID").format(total),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30.0),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text('Points $points',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getPaymentMethodeSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(11.0))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                child: Text('Payment Method', style: LogOutText),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 4, bottom: 10),
                      child: Text(
                          'Payment using credit / debit cards from all banks with the VISA / MasterCard / JCB / Amex logo.',
                          maxLines: 2,
                          softWrap: true,
                          style: bodyText),
                    ),
                    Container(
                      child: Image(
                        image: AssetImage('assets/images/cardpayment.png'),
                        height: 45,
                        fit: BoxFit.fitHeight,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1)),
                    ),
                    const Divider(
                      color: Colors.black,
                      height: 20,
                      thickness: 2,
                      indent: 0,
                      endIndent: 0,
                    ),
                    new TextFormField(
                        controller: _textCardNumController,
                        inputFormatters: [maskFormatterCardNum],
                        autocorrect: false,
                        keyboardType: TextInputType.number,
                        validator: (val) => val.toString().length < 1
                            ? 'Card Number Required'
                            : null,
                        decoration: InputDecoration(
                            hintText: "XXXX-XXXX-XXXX-XXXX",
                            labelText: "Card Number",
                            hintStyle: const TextStyle(color: Colors.grey),
                            fillColor: Colors.white,
                            filled: true,
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green)),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                            errorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            border: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green)),
                            errorMaxLines: 1)),
                    new Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: new TextFormField(
                                controller: _textCVVController,
                                inputFormatters: [maskFormatterCVV],
                                autocorrect: false,
                                keyboardType: TextInputType.number,
                                validator: (val) => val.toString().length < 1
                                    ? 'Card Number Required'
                                    : null,
                                decoration: InputDecoration(
                                    hintText: "XXX",
                                    labelText: "CVV",
                                    suffixIcon: Icon(Icons.credit_card),
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    fillColor: Colors.white,
                                    filled: true,
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.green)),
                                    enabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue)),
                                    errorBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    border: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.green)),
                                    errorMaxLines: 1)),
                          ),
                          flex: 2,
                        ),
                        Flexible(
                          child: new TextFormField(
                              controller: _textCardExpController,
                              inputFormatters: [maskFormatterCardExp],
                              autocorrect: false,
                              keyboardType: TextInputType.number,
                              validator: (val) => val.toString().length < 1
                                  ? 'Card Number Required'
                                  : null,
                              decoration: InputDecoration(
                                  hintText: "MM/YY",
                                  labelText: "Card Expired",
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green)),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue)),
                                  errorBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.red)),
                                  border: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green)),
                                  errorMaxLines: 1)),
                          flex: 2,
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

  _createOrder(ProjectList project, List product, num total, User user,
      String bookingDate) async {
    var _token = user.token;
    Uri uriComm = Uri.parse(Constants.apiGateway +
        "/GuestCommunication/InquiryByGuestId" +
        "?GuestId=" +
        widget.user.userId.toString());
    var responseComm = await WebClient(User(token: _token)).get(uriComm);
    bool responseDataComm = responseComm == null ? false : true;
    if (responseComm["returnStatus"] == true && responseDataComm == true) {
      var datasetComm = responseComm["entity"];
      for (var i = 0; i < datasetComm.length; i++) {
        if (datasetComm[i]["type"] == "Handphone") {
          idMobilePhone = datasetComm[i]["id"];
          mobilePhone = datasetComm[i]["contactNo"];
        }
      }
    }

    if (mobilePhone.isNotEmpty) {
      try {
        SharedPreferences _prefs = await SharedPreferences.getInstance();
        var _orderId = _prefs.getString("orderId") ?? "";

        if (_orderId != "") {
          Uri urlDelete = Uri.parse(
              Constants.apiGateway + "/Product/PromotionLog/" + _orderId);
          WebClient(User(token: _token)).delete(urlDelete);
        }
      } catch (e) {
        print(e);
      }

      Uri urlCreateOrder = Uri.parse(Constants.apiGateway +
          "/Payment/CreateOrder?UserId=" +
          user.userId.toString());

      List dataItem = [];

      for (var i = 0; i < product.length; i++) {
        if (product[i].quantity > 0) {
          dataItem.add({
            "order_id": 0,
            "item_id": product[i].productId,
            "name": product[i].productName,
            "quantity":
                product[i].productCode == "Admin Fee" ? 0 : product[i].quantity,
            "price": num.parse(product[i].price.toString().replaceAll('.', ''))
                .toInt(),
            "amount": num.parse(product[i].price.toString().replaceAll('.', ''))
                .toInt(),
            "currency_id": "1",
            "currency_name": "IDR"
          });
        }
      }
      // cek
      DateTime now = new DateTime.now().toUtc();
      String processDate = DateFormat('dd.MM.yyyy hh:mm:ss').format(now);
      Map data = {
        "id": "",
        "name": "",
        "email": user.emailAddress,
        "first_name": user.firstName,
        "last_name": user.lastName,
        "phone": mobilePhone,
        "description": "",
        "total_amount": total,
        "currency_id": 1,
        "currency_name": "IDR",
        "company_id": 1,
        "company_name": "PT.BSD",
        "project_id": 1,
        "project_name": project.name,
        "process_date": processDate,
        "booking_date": bookingDate,
        "status": "",
        "payment_type": "CreditCard",
        "order_items": dataItem
      };

      var response =
          await WebClient(User(token: _token)).post(urlCreateOrder, data);
      var responseJson = json.decode(response.toString());
      if (responseJson["returnStatus"] == true) {
        String orderId = responseJson["entity"]["id"];
        String orderName = responseJson["entity"]["name"];
        _checkQuota(
            project, product, total, user, bookingDate, orderId, orderName);
      } else {
        _alertMsg(context, responseJson["entity"]["status_message"].toString());
      }
    } else {
      _alertMsg(
          context, 'Masukan no. HP terlebih dahulu yg terdapat di menu profil');
      setState(() {
        _isButtonDisabled = false;
        buttonText = 'Payment';
      });
    }
  }

  _checkQuota(ProjectList project, List product, num total, User user,
      String bookingDate, String orderId, String orderName) async {
    var _token = user.token;

    Uri urlCheckOut = Uri.parse(Constants.apiGateway +
        "/Product/CheckOut?UserId=" +
        user.userId.toString());

    List dataItem = [];

    for (var i = 0; i < product.length; i++) {
      if (product[i].quantity > 0) {
        dataItem.add({
          "productId": product[i].productId,
          "price": num.parse(product[i].price.toString().replaceAll('.', ''))
              .toInt(),
          "quantity":
              product[i].productCode == "Admin Fee" ? 0 : product[i].quantity,
          "productCode": product[i].productCode,
          "productName": product[i].productName,
          "promoName": product[i].productName,
          "bookingDate": bookingDate
        });
      }
    }

    Map data = {
      "paymentCard": _textCardNumController.text.replaceAll('-', ''),
      "employeeId": user.employeeId,
      "orderId": orderId,
      "cartItemsResource": dataItem
    };

    var response = await WebClient(User(token: _token)).post(urlCheckOut, data);
    var responseJson = json.decode(response.toString());
    if (responseJson["returnStatus"] == true) {
      _createPayment(
          project, product, total, user, bookingDate, orderId, orderName);
    } else {
      _alertMsg(context, responseJson["returnMessage"].toString());
    }
    setState(() {
      _isButtonDisabled = false;
      buttonText = 'Payment';
    });
  }

  _createPayment(ProjectList project, List product, num total, User user,
      String bookingDate, String orderId, String orderName) async {
    var _token = user.token;
    Uri memberURL = Uri.parse(Constants.apiGateway + "/Payment/Charge");

    Map dataCostumer = {
      "email": user.emailAddress,
      "first_name": user.firstName,
      "last_name": user.lastName,
      "phone": mobilePhone
    };
    // String orderId = Uuid().v4().toString();
    Map dataTransaction = {"gross_amount": total, "order_id": orderId};

    List dataItem = [];

    for (var i = 0; i < product.length; i++) {
      if (product[i].quantity > 0) {
        dataItem.add({
          "id": product[i].productId,
          "price": num.parse(product[i].price.toString().replaceAll('.', ''))
              .toInt(),
          "quantity": product[i].quantity,
          "name": product[i].productName,
        });
      }
    }

    Map data = {
      "order_id": orderId,
      "currency_id": "1",
      "payment_type": "CreditCard",
      "transaction_details": dataTransaction,
      "customer_details": dataCostumer,
      "item_details": dataItem,
      "booking_date": bookingDate,
      "project_id": project.id,
      "project_name": project.name,
      "company_id": 1,
      "company_name": "BSD",
      "card_number": _textCardNumController.text.replaceAll('-', ' '),
      "card_exp_month": _textCardExpController.text.substring(0, 2),
      "card_exp_year": _textCardExpController.text.substring(3, 5),
      "card_cvv": _textCVVController.text,
    };

    var response = await WebClient(User(token: _token)).post(memberURL, data);
    var responseJson = json.decode(response.toString());
    if (responseJson["returnStatus"] == true) {
      var dataset = responseJson["entity"];
      PaymentModel payment = new PaymentModel.fromJson(dataset);
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString("orderId", orderId);
      });
      final snackbar = SnackBar(
        duration: Duration(seconds: 3),
        content: Row(
          children: <Widget>[
            CircularProgressIndicator.adaptive(),
            Text("  Submit Payment ...")
          ],
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      var key;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebViewPage(
            title: "Credit Card Validation",
            url: responseJson["entity"]["redirect_url"],
            user: user,
            orderId: orderId,
            orderName: orderName,
            key: key,
            totalPoint: widget.totalPoint,
          ),
        ),
      );

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    } else {
      _alertMsg(context, responseJson["returnMessage"].toString());
      var _token = widget.user.token;
      Uri urlDelete =
          Uri.parse(Constants.apiGateway + "/Product/PromotionLog/" + orderId);
      WebClient(User(token: _token)).delete(urlDelete);
      // }
    }

    if (widget.voucher != null) {
      _removeVoucherUsage(widget.voucher!);
    }

    setState(() {
      _isButtonDisabled = false;
      buttonText = 'Payment';
    });
  }

  _removeVoucherUsage(viewVoucherHeaderData voucher) async {
    // REMOVE VOUCHER USAGE FROM AVAILABLE VOUCHER REDEEM
    // LoyaltyService().removeRedeemVoucher(widget.user, selectedVoucher!);

    await DataSharedPreferences().removeUsedVoucher(voucher.voucherTypeID);
  }
}
