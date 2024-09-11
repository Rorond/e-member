import 'package:emembers/constants.dart';
import 'package:emembers/data/models/membershipModel.dart';
import 'package:emembers/data/web_client.dart';
import 'package:emembers/flutter_flow/flutter_flow_theme.dart';
import 'package:emembers/ui/ticket/termcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/models/user.dart';

class SuccessScreen extends StatefulWidget {
  final MembershipList membership;
  final User user;

  const SuccessScreen({Key? key, required this.user, required this.membership})
      : super(key: key);

  @override
  PaymentSuccessPage createState() => PaymentSuccessPage();
}

class PaymentSuccessPage extends State<SuccessScreen> {
  final List transferTo = [];
  final int currentProjectIndex = 0;
  String memberURLBank = Constants.apiGateway + "/BankAccount/InquiryByProject";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    Uri uri = Uri.parse(memberURLBank +
        BaseUrlParams.baseUrlParams(widget.user.userId.toString()) +
        "&ProjectId=" +
        widget.membership.projectId.toString());
    var _token = widget.user.token;
    var response = await WebClient(User(token: _token)).get(uri);
    bool responseData = response == null ? false : true;
    if (response["returnStatus"] == true && responseData == true) {
      var dataset = response["entity"];
      setState(() {
        for (var i = 0; i < dataset.length; i++) {
          transferTo.add(dataset[i]);
        }
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String accountNo = transferTo.isNotEmpty
        ? transferTo[currentProjectIndex]["accountNo"]
        : "";
    String accountName = transferTo.isNotEmpty
        ? transferTo[currentProjectIndex]["accountName"]
        : "";
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Image.asset(
              "assets/images/info.png",
              width: 80,
            ),
            const SizedBox(height: 16),
            isLoading
                ? CircularProgressIndicator()
                : Column(
                    children: [
                      Text(
                        "Submit Member Success \nLanjut pembayaran ke:",
                        style: AppTittle1,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Num: $accountNo", style: AmountText),
                          IconButton(
                            icon: Icon(
                              Icons.copy,
                              color: primaryColor,
                            ),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: accountNo));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        "Account number copied to clipboard")),
                              );
                            },
                          ),
                        ],
                      ),
                      Text("Name: $accountName", style: PointText),
                    ],
                  ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/homepage');
                },
                child: const Text("Back to home"),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
