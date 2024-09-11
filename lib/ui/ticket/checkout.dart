import 'dart:convert';

import 'package:emembers/constants.dart';
import 'package:emembers/data/models/addproductModels.dart';
import 'package:emembers/data/models/customer_point.dart';
import 'package:emembers/data/models/membershipModel.dart';
import 'package:emembers/data/models/redeemVoucher.dart';
import 'package:emembers/data/models/user.dart';
import 'package:emembers/data/models/viewVoucherHeader.dart';
import 'package:emembers/data/web_client.dart';
import 'package:emembers/flutter_flow/flutter_flow_theme.dart';
import 'package:emembers/flutter_flow/flutter_flow_util.dart';
import 'package:emembers/services/customer_point_service.dart';
import 'package:emembers/services/loyalty_service.dart';
import 'package:emembers/ui/menuLoyalty/point_voucher.dart';
import 'package:emembers/ui/ticket/checkout_midtrans.dart';
import 'package:emembers/ui/ticket/qris.dart';
import 'package:emembers/ui/ticket/webviews.dart';
import 'package:emembers/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutRoute extends PageRouteBuilder {
  final ProjectList project;
  final List product;
  final User user;
  final DateTime bookingDate;
  final num total;
  final List<viewVoucherHeaderData>? assignedVouchers;
  final num? configPoint;

  CheckoutRoute(
    this.project,
    this.product,
    this.user,
    this.bookingDate,
    this.total,
    this.assignedVouchers,
    this.configPoint,
  ) : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return Checkout(
              project: project,
              product: product,
              user: user,
              total: total,
              checkout: [],
              bookingDate: bookingDate,
              assignedVouchers: assignedVouchers!,
              configPoint: configPoint,
            );
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: SlideTransition(
                position: Tween<Offset>(
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
  final List<viewVoucherHeaderData> assignedVouchers;
  final ProjectList project;
  final List product;
  final List checkout;
  final User user;
  final num total;
  final DateTime bookingDate;
  final num? configPoint;

  Checkout({
    required this.project,
    required this.product,
    required this.checkout,
    required this.total,
    required this.user,
    required this.bookingDate,
    required this.assignedVouchers,
    this.configPoint,
  });

  @override
  CheckoutState createState() => CheckoutState();
}

class CheckoutState extends State<Checkout> {
  Uri memberURL = Uri.parse(Constants.apiGateway + "/Guest/GetMembership");
  var isLoading = false;
  String selectedPaymentMethode = "CreditCard";
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
  bool _isHasBin = false;
  String _binCode = "";
  String buttonText = "Payment";
  String valPaymentVA = "Mandiri";
  viewVoucherHeaderData? selectedVoucher;
  int customerPoint = 0;

  // List<viewVoucherHeaderData> assignedVouchers = [];
  // viewVoucherHeaderData? selectedVoucher;
  List<DropdownMenuItem> getPaymentVA() {
    final months = [
      DropdownMenuItem(value: "Mandiri", child: Text("Mandiri")),
      DropdownMenuItem(value: "BCA", child: Text("BCA")),
      DropdownMenuItem(value: "BNI", child: Text("BNI")),
      DropdownMenuItem(value: "Permata", child: Text("Permata")),
      DropdownMenuItem(value: "BSI", child: Text("BSI")),
      DropdownMenuItem(value: "CIMB", child: Text("CIMB")),
    ];
    return months;
  }

  _getData() async {
    int sumItems = 0;
    total = 0;
    sumCounter = 0;
    summary = 0;
    addproduct.clear();
    checkout.clear();
    adminFee.clear();
    _binCode = "";
    // String _bookingDate = DateFormat('dd.MM.yyyy').format(widget.bookingDate);
    // DateTime.parse(widget.bookingDate.replaceAll("-", "") + "T000000");

    bookingDate = DateFormat('dd.MM.yyyy').format(widget.bookingDate);
    var _token = widget.user.token;
    List order =
        widget.product.where((product) => product.quantity > 0).toList();
    for (var x = 0; x < order.length; x++) {
      if (order[x].bankIdentificationNumber.toString().isNotEmpty) {
        _isHasBin = true;
        _binCode = order[x].bankIdentificationNumber.toString();
      } else {
        _isHasBin = false;
        _binCode = "";
      }
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
      // String bookingDateforAdminFee = formatDate(
      //     DateTime.parse(widget.bookingDate), [yyyy, '-', mm, '-', dd]);
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
          "bookingDate": bookingDate,
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
    // selectedVoucher = widget.selectedVoucher;

    super.initState();
    // assignedVouchers = [];
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
              _getEnterAmountSection(total, widget.configPoint!),
              _getPaymentMethodeSection(),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 4.0, right: 16.0),
                child: Text(
                  "Pastikan saldo/balance pulsa Nomor Handphone e-banking anda tersedia.",
                  style: bodyText,
                  textAlign: TextAlign.center,
                ),
              ),
              //
              if (widget.assignedVouchers.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10.0),
                  child: DropdownButton<viewVoucherHeaderData>(
                    hint: Text("Pilih Voucher"),
                    value: selectedVoucher,
                    onChanged: (viewVoucherHeaderData? newValue) {
                      setState(() {
                        selectedVoucher = newValue;
                      });
                    },
                    items: widget.assignedVouchers
                        .map<DropdownMenuItem<viewVoucherHeaderData>>(
                            (viewVoucherHeaderData voucher) {
                      return DropdownMenuItem<viewVoucherHeaderData>(
                        value: voucher,
                        child: Text(voucher.voucherTypeName),
                      );
                    }).toList(),
                    isExpanded: true,
                  ),
                )
              else
                // Tombol Add Voucher
                //   GestureDetector(
                //   onTap: () async {
                //     final result = await Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => VoucherPointWidget(initialMenuIndex: 1)),
                //     );
                //     if (result != null) {
                //       setState(() {
                //         selectedVoucher = result;
                //       });
                //     }
                //   },
                //   child: Container(
                //     margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(8.0),
                //       border: Border.all(color: Colors.grey[300]!),
                //     ),
                //   child: Padding(
                //     padding: EdgeInsets.all(16.0),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text(
                //           selectedVoucher != null
                //   ? "${selectedVoucher?.voucherTypeName} - ${selectedVoucher?.requiredPoint} Point"
                //   : "ADD VOUCHER",
                //           style: productname
                //         ),
                //         Icon(Icons.arrow_forward_ios, size: 18.0),
                //       ],
                //     ),
                //   ),
                //   ),
                // ),

                //pake ini untuk add voucher
                GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VoucherPointWidget(
                          initialMenuIndex: 1,
                          user: widget.user,
                          project: widget.project,
                        ), // 1 untuk menu "Voucher"
                      ),
                    );
                    if (result != null) {
                      setState(() {
                        selectedVoucher = result;
                      });
                    }
                  },
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedVoucher != null
                                ? "${selectedVoucher?.voucherTypeName} - ${selectedVoucher?.requiredPoint} Point"
                                : "ADD VOUCHER",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, size: 18.0),
                        ],
                      ),
                    ),
                  ),
                ),
              EmembersButton(
                key: UniqueKey(),
                width: 200,
                height: 50,
                title: '$buttonText',
                icon: Icons.credit_card,
                iconSize: 20.0,
                onPressed: () async {
                  if ((_textCardNumController.text.isNotEmpty &&
                          _textCVVController.text.isNotEmpty &&
                          _textCardExpController.text.isNotEmpty) ||
                      selectedPaymentMethode.isNotEmpty) {
                    if (_isButtonDisabled == false) {
                      setState(() {
                        _isButtonDisabled = true;
                        buttonText = 'Payment Processing...';
                      });
                      _checkPaymentMethode();
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
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        child: Row(
          children: <Widget>[
            Container(
              child: Image(
                image: NetworkImage(
                    Constants.apiImage + "/Product/" + checkout.imageUrl),
                width: 50,
                height: 65,
                fit: BoxFit.fitHeight,
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(4)),
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
                        style: MenuApps,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                          'Tanggal Kedatangan : ' +
                              DateFormat('dd-MM-yyyy')
                                  .format(widget.bookingDate),
                          maxLines: 2,
                          softWrap: true,
                          style: bodyText),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                        '${NumberFormat("#,##0", "id_ID").format(checkout.price)} x ${checkout.quantity} = ' +
                            NumberFormat("#,##0", "id_ID").format(subtotal),
                        style: MenuApps),
                  ]),
            ),
          ],
        ),
      ));
    } else {
      return SizedBox();
    }
  }

  Widget _getEnterAmountSection(num total, num configPoint) {
    int points = (total / configPoint).floor();
    customerPoint = points;
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
                  style: ListTittleProfile,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '\IDR',
                      style: AmountText,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          NumberFormat("#,##0", "id_ID").format(total),
                          style: AmountText,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text('Points $points', style: PointText),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getPaymentMethodeSectionCC() {
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
                  'Payment Method',
                  style: LogOutText,
                ),
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
                        style: bodyText,
                      ),
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
                child: Text(
                  'Payment Method',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                child: Column(
                  children: <Widget>[
                    const Divider(
                      color: Colors.black,
                      height: 20,
                      thickness: 2,
                      indent: 0,
                      endIndent: 0,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: <Widget>[
                          Image.asset('assets/images/ico_logo_red.png'),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Credit Card / Debit Card',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0),
                            ),
                          )),
                          Radio(
                            activeColor: AppColors.primaryColor,
                            value: "CreditCard",
                            groupValue: selectedPaymentMethode,
                            onChanged: (value) {
                              selectedPaymentMethode = value!;
                              setState(() {});
                            },
                          )
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            Row(
                              children: <Widget>[
                                Image.asset('assets/images/ico_logo_red.png'),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Virtual Account',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0),
                                  ),
                                )),
                                Radio(
                                  activeColor: AppColors.primaryColor,
                                  value: "VirtualAccount",
                                  groupValue: selectedPaymentMethode,
                                  onChanged: (value) {
                                    selectedPaymentMethode = value!;
                                    setState(() {});
                                  },
                                )
                              ],
                            ),
                            selectedPaymentMethode == "VirtualAccount"
                                ? Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(25.0),
                                        child: Text(
                                          'Choose Bank ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20.0),
                                        child: DropdownButton(
                                          items: getPaymentVA(),
                                          hint: Text(valPaymentVA),
                                          onChanged: (newValue) {
                                            setState(
                                                () => valPaymentVA = newValue);
                                          },
                                          value: valPaymentVA,
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox()
                          ],
                        )),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: <Widget>[
                          Image.asset('assets/images/ico_logo_red.png'),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'QRIS',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0),
                            ),
                          )),
                          Radio(
                            activeColor: AppColors.primaryColor,
                            value: "QRIS",
                            groupValue: selectedPaymentMethode,
                            onChanged: (value) {
                              selectedPaymentMethode = value!;
                              setState(() {});
                            },
                          )
                        ],
                      ),
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

  _checkPaymentMethode() async {
    var _token = widget.user.token;

    Uri urlCheckPaymentMethode = Uri.parse(Constants.apiGateway +
        "/Payment/Gateway?payment_type=" +
        selectedPaymentMethode);
    // Map data = {"payment_type": "CreditCard"};

    var responseJson =
        await WebClient(User(token: _token)).get(urlCheckPaymentMethode);
    // var responseJson = json.decode(response.toString());
    if (responseJson["returnStatus"] == true) {
      if (responseJson["entity"]["gateway_name"] == "doku") {
        if (_isHasBin) {
          if (responseJson["entity"]["payment_type"] == "CreditCard") {
            await showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        _getPaymentMethodeSectionCC(),
                        Center(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              child: const Text(
                                'Submit',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                if (_textCardNumController.text.isNotEmpty) {
                                  String binFromCardNo = _textCardNumController
                                      .text
                                      .replaceAll("-", "")
                                      .substring(0, 6);
                                  if (_binCode.contains(binFromCardNo)) {
                                    _createOrder(widget.project, checkout,
                                        total, widget.user, bookingDate);
                                  } else {
                                    _alertMsg(context,
                                        "Your card number not allow to pay this product");
                                  }
                                  Navigator.pop(context);
                                } else {
                                  _alertMsg(context, "Please fill card number");
                                }
                              }),
                        ),
                      ],
                    ),
                  );
                });
          } else {
            _alertMsg(context, "The product only use credit card payment");
          }
          // _createOrder(
          // widget.project, checkout, total, widget.user, bookingDate);
        } else {
          _createOrder(
              widget.project, checkout, total, widget.user, bookingDate);
        }
      } else {
        if (responseJson["entity"]["payment_type"] == "CreditCard") {
          await Navigator.push(
              context,
              CheckoutMidtransRoute(
                widget.project,
                widget.product,
                widget.user,
                widget.bookingDate,
                selectedVoucher,
                customerPoint,
              ));
        }
      }
    }
    setState(() {
      _isButtonDisabled = false;
      buttonText = 'Payment';
      // _updateCustomerPoint();
    });
    // _updateCustomerPoint(customerPoint);
    if (responseJson["returnCode"] == "00") {
      _alertMsg(context, "Transaction successful!");

      if (selectedVoucher != null) {
        _removeVoucherUsage(selectedVoucher!);
      }

      setState(() {
        _isButtonDisabled = false;
        buttonText = 'Payment';
      });
    } else {
      _alertMsg(context, responseJson["returnMessage"].toString());
    }

    // else {
    //   _alertMsg(context, responseJson["returnMessage"].toString());
    // }

    // _removeVoucherUsage(selectedVoucher!);

    // setState(() {
    //   _isButtonDisabled = false;
    //   buttonText = 'Payment';
    // });
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
        "payment_type": selectedPaymentMethode,
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
    List expCard = _textCardExpController.text.isNotEmpty
        ? _textCardExpController.text.split("/")
        : ["00", "00"];

    Map data = {
      "order_id": orderId,
      "order_name": orderName,
      "currency_id": "1",
      "payment_type": selectedPaymentMethode,
      "transaction_details": dataTransaction,
      "customer_details": dataCostumer,
      "item_details": dataItem,
      "booking_date": bookingDate,
      "project_id": project.id,
      "project_name": project.name,
      "company_id": 1,
      "company_name": "BSD",
      "card_number": _textCardNumController.text,
      "card_exp_month": expCard[0],
      "card_exp_year": expCard[1],
      "card_cvv": _textCVVController.text,
      "bank_transfer": {"bank": valPaymentVA}
    };

    var response = await WebClient(User(token: _token)).post(memberURL, data);
    var responseJson = json.decode(response.toString());
    if (responseJson["returnStatus"] == true) {
      var dataset = responseJson["entity"];
      // PaymentModel payment = new PaymentModel.fromJson(dataset);
      String url = "";
      String title = "";
      if (selectedPaymentMethode == "VirtualAccount") {
        title = "Virtual Account";
        url = dataset["virtual_account_info"]["how_to_pay_page"];
      } else if (selectedPaymentMethode == "QRIS") {
        title = "QRIS";
        url = "";
      } else {
        title = "Credit Card";
        url = dataset["credit_card_payment_page"]["url"];
      }
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
      if (selectedPaymentMethode == "QRIS") {
        Navigator.push(
            context,
            QrisRoute(
                user: user,
                qrCode: dataset["qrCode"],
                bookingDate: bookingDate,
                orderId: orderId,
                orderName: orderName,
                amount: NumberFormat("#,##0", "id_ID").format(total)));
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewPage(
              key: UniqueKey(),
              title: title + " Validation",
              url: url,
              user: user,
              orderId: orderId,
              orderName: orderName,
              totalPoint: customerPoint,
            ),
          ),
        );
      }
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    } else {
      // var msgFrom = responseJson["entity"]["validation_messages"] == null
      //     ? responseJson["entity"]["status_message"]
      //     : responseJson["returnMessage"];
      // var uri = Constants.apiContent +
      //     "/messages?category=OnPaymentCreditCard&messagefrom_contains=" +
      //     msgFrom;
      // final responseMsg = await http.get(uri, headers: {
      //   HttpHeaders.contentTypeHeader: 'application/json',
      // });
      // if (responseMsg.statusCode == 200) {
      //   List responseJsonMsg = json.decode(responseMsg.body);
      //   if (responseJsonMsg.length > 0) {
      //     _alertMsg(context, responseJsonMsg.first["messageto"]);
      //   } else {
      //     _alertMsg(context, msgFrom);
      //   }
      // } else {
      _alertMsg(context, responseJson["returnMessage"].toString());
      var _token = widget.user.token;
      Uri urlDelete =
          Uri.parse(Constants.apiGateway + "/Product/PromotionLog/" + orderId);
      WebClient(User(token: _token)).delete(urlDelete);
      // }
    }

    if (selectedVoucher != null) {
      _removeVoucherUsage(selectedVoucher!);
    }

    setState(() {
      _isButtonDisabled = false;
      buttonText = 'Payment';
    });
  }

// Widget _buildAssignedVouchersSection(List<viewVoucherHeaderData> vouchers) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//           child: Text(
//             "Vouchers Assigned:",
//             style: TextStyle(
//               fontSize: 18.0,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         if (vouchers.isNotEmpty)
//           ListView.builder(
//             shrinkWrap: true,
//             itemCount: vouchers.length,
//             itemBuilder: (context, index) {
//               final voucher = vouchers[index];
//               return ListTile(
//                 title: Text(voucher.voucherTypeName),
//                 subtitle: Text('Points: ${voucher.requiredPoint}'),
//               );
//             },
//           )
//         else
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text('Tidak ada voucher yang di-assign'),
//             ),
//           ),
//         // Add other checkout components here
//       ],
//     );
//   }

  _removeVoucherUsage(viewVoucherHeaderData voucher) async {
    var redeemVoucher = await LoyaltyService().getRedeemVoucher(widget.user);

    redeemVoucherData param = redeemVoucher
        .firstWhere((e) => e.voucherTypeID == voucher.voucherTypeID);

    LoyaltyService().setRedeemVoucherUsage(widget.user, param);
  }
}
