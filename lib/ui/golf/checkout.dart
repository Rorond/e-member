import 'package:emembers/constants.dart';
import 'package:emembers/data/models/user.dart';
import 'package:emembers/data/web_client.dart';
import 'package:emembers/flutter_flow/flutter_flow_theme.dart';
import 'package:emembers/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CheckoutScreen extends StatefulWidget {
  final User user;
  final String selectedDate;
  final String selectedTeeTime;
  final int numberOfPlayers;
  final double pricePerPlayer;
  final String golfCourse;
  final String location;

  CheckoutScreen({
    required this.user,
    required this.selectedDate,
    required this.selectedTeeTime,
    required this.numberOfPlayers,
    required this.pricePerPlayer,
    required this.golfCourse,
    required this.location,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final List transferTo = [];
  int selectedCardIndex = 0;
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

  String mobilePhone = "";
  late int idMobilePhone;
  late bool _isButtonDisabled;

  bool _isHasBin = false;
  String _binCode = "";
  String buttonText = "Payment";
  String valPaymentVA = "Mandiri";
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

  @override
  Widget build(BuildContext context) {
    double totalPrice = widget.numberOfPlayers * widget.pricePerPlayer;
    NumberFormat currencyFormat =
        NumberFormat.currency(locale: 'id', symbol: 'IDR ', decimalDigits: 0);

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        title: Text(
          'Price of ' + widget.golfCourse,
          style: ListTittleProfile,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.purple,
                child: Text(
                  "N",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              title: Text(
                widget.golfCourse,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
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
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 8.0),
                        child: Text(
                          'Amount',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 0.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              currencyFormat.format(totalPrice),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 0.0),
                        child: Text(
                          "Player Number: ${widget.numberOfPlayers}",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 0.0),
                        child: Text(
                          "Booking Date: ${widget.selectedDate}",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            _getPaymentMethodeSection(),
            SizedBox(height: 16),
            EmembersButton(
              key: UniqueKey(),
              width: 200,
              height: 50,
              title: '$buttonText',
              icon: Icons.credit_card,
              iconSize: 20.0,
              onPressed: () {
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
                                        padding: const EdgeInsets.only(
                                            top: 5.0, left: 20.0),
                                        child: Text(
                                          'Choose Bank ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0),
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
                                    // _createOrder(widget.project, checkout,
                                    //     total, widget.user, bookingDate);
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
          // _createOrder(
          //     widget.project, checkout, total, widget.user, bookingDate);
        }
      } else {
        if (responseJson["entity"]["payment_type"] == "CreditCard") {
          // Navigator.push(
          //     context,
          //     CheckoutMidtransRoute(widget.project, widget.product, widget.user,
          //         widget.bookingDate));
        }
      }
    } else {
      _alertMsg(context, responseJson["returnMessage"].toString());
    }
    setState(() {
      _isButtonDisabled = false;
      buttonText = 'Payment';
    });
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
                        WidgetStatePropertyAll(AppColors.primaryColor),
                  ),
                  child: Text(
                    'Ok',
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

  Widget _getBankCard(int index) {
    String _accountNo = transferTo[index]["accountNo"];
    String _accountName = transferTo[index]["accountName"];
    String _account = transferTo[index]["name"];
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Image.asset(index % 2 == 0
              ? 'assets/images/ico_logo_red.png'
              : 'assets/images/ico_logo_blue.png'),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                ' $_account\n Num. : $_accountNo \n Name :$_accountName',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
          )),
          Radio(
            activeColor: AppColors.primaryColor,
            value: transferTo[index]["id"],
            groupValue: selectedCardIndex,
            onChanged: (value) {
              selectedCardIndex = value;
              setState(() {});
            },
          )
        ],
      ),
    );
  }
}
