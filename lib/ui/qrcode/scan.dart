// import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:barcode_scan2/model/scan_result.dart';
import 'package:emembers/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
import 'package:emembers/data/models/user.dart';
import 'package:emembers/data/models/member_detail.dart';
import 'package:emembers/data/web_client.dart';
import '../../../constants.dart';

class ScanScreen extends StatefulWidget {
  final User userData;
  ScanScreen({required this.userData});

  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> {
  String barcode = "0#Please scan barcode to check in/out !";
  late ScanResult scanResult;
  int checkId = 0;

  static final memberURL = Constants.apiGateway + "/Guest/GetMembership";
  // static final checkinoutURL = Constants.apiGateway + "/Guest/CheckInOut";

  List cards = [];
  late String statusCheck;
  late String checkInOut;
  late String projectid;
  late String projectname;
  late String userCheck;

  var isLoading = false;
  _fetchData() async {
    setState(() {
      isLoading = true;
    });

    Uri uri =
        Uri.parse(memberURL + "?GuestId=" + widget.userData.userId.toString());
    var _token = widget.userData.token;
    // final response = await http.get(uri,
    //   headers: {
    //     HttpHeaders.contentTypeHeader: 'application/json',
    //     HttpHeaders.authorizationHeader: "Bearer $_token",
    //   }
    // );
    var response = await WebClient(User(token: _token)).get(uri);
    //if (response.statusCode == 200) {
    //var responseJson = json.decode(response.body);
    var dataset = response["entity"];
    cards =
        (dataset).map((dataset) => new MemberDetail.fromJson(dataset)).toList();
    setState(() {
      isLoading = false;
    });
    //}
  }

  @override
  initState() {
    super.initState();
    scan();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      appBar: AppBar(
        title: Text("Scan for Check In/Out", style: AppTittle),
        centerTitle: true,
        backgroundColor: Color(0xFFF4F4F4),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _checkinInfoWidget(barcode),
            _checkButton(barcode)
          ],
        ),
      ),
    );
  }

  Widget _checkinInfoWidget(String d) {
    var result = d.split("#");
    if (result[0] == "0") {
      return new Expanded(
          child: Column(children: <Widget>[
        Center(
            child: CupertinoButton(
                child: Icon(
                  CupertinoIcons.clock_solid,
                  size: 200,
                  color: AppColors.primaryColor,
                ),
                onPressed: () {})),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 30, right: 30),
          child: new Center(
              child: Text(
            result[1],
            style: TextStyle(color: AppColors.primaryColor, fontSize: 18.0),
          )),
        )
      ]));
    } else if (result[0] == "2") {
      return new Expanded(
          child: Column(children: <Widget>[
        Center(
            child: CupertinoButton(
                child: Icon(
                  CupertinoIcons.check_mark_circled_solid,
                  size: 200,
                  color: AppColors.primaryColor,
                ),
                onPressed: () {})),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 30, right: 30),
          child: new Center(
              child: Text(
            result[1],
            style: TextStyle(color: AppColors.primaryColor),
          )),
        )
      ]));
    } else {
      return new Expanded(
          child: Column(children: <Widget>[
        Center(
            child: CupertinoButton(
                child: Icon(
                  CupertinoIcons.info,
                  size: 200,
                  color: AppColors.primaryColor,
                ),
                onPressed: () {})),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 30, right: 30),
          child: new Center(
              child: Text(
            result[1],
            style: TextStyle(color: AppColors.primaryColor),
          )),
        )
      ]));
    }
  }

  Widget _checkButton(String d) {
    var result = d.split("#");
    if (result[0] == "0") {
      return _getClubHouseListSection();
    } else if (result[0] == "2") {
      return _backButton();
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(AppColors.primaryColor)),
                child: Column(
                  // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                    const Text('Scan again',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ],
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              ScanScreen(userData: widget.userData)));
                }),
            TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.primaryColor)),
                child: Column(
                  // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.check_circle, color: Colors.white),
                    const Text('Confirm',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ],
                ),
                onPressed: () {
                  confirm();
                })
          ],
        ),
      );
    }
  }

  Widget _backButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.primaryColor)),
              child: Column(
                // Replace with a Row for horizontal icon + text
                children: <Widget>[
                  Icon(Icons.home, color: Colors.white),
                  const Text('Back To home',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ],
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }

  Widget _getClubHouseListSection() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Card(
                child: ListView.builder(
                    itemCount: cards.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _getReceiverSection(cards[index]);
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getReceiverSection(MemberDetail cards) {
    return GestureDetector(
      onTapUp: (tapDetail) {
        //Navigator.push(context, PriceListRoute(receiver, user));
        _checkInOut(cards.membershipId);
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                child: Text(cards.membershipName.substring(0, 1)),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    cards.membershipName,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.card_membership,
                            size: 13.0, color: Color(0xFF929091)),
                      ),
                      Text(
                        cards.membershipName,
                        style:
                            TextStyle(fontSize: 12.0, color: Color(0xFF929091)),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _checkStatus(barcodeResult) async {
    var uri = Uri.parse(barcodeResult[0]);
    projectid = barcodeResult[1];
    projectname = barcodeResult[2];
    userCheck = barcodeResult[3];
    var _token = widget.userData.token;
    // final response = await http.post(uri,
    //   headers: {
    //     HttpHeaders.contentTypeHeader: 'application/json',
    //     HttpHeaders.authorizationHeader: "Bearer $_token",
    //   },
    //   body : json.encode({ "GuestId" : widget.userData.userId,
    //         "ProjectId" : projectid,
    //         "ProjectName" : projectname,
    //         "LocationId" : userCheck
    //         })
    // );
    // if (response.statusCode == 200) {
    var response = await WebClient(User(token: _token)).post(uri, {
      "GuestId": widget.userData.userId,
      "ProjectId": projectid,
      "ProjectName": projectname,
      "LocationId": userCheck
    });
    var responseJson = json.decode(response.toString());
    statusCheck = responseJson["entity"]["status"];
    return statusCheck;
    // }
  }

  Future scan() async {
    try {
      final barcode = await BarcodeScanner.scan();
      var barcodestring = barcode.rawContent.split("|");
      await _checkStatus(barcodestring);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          this.barcode = '3#The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = '3#Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          '3#User returned using the "back"-button before scanning anything.');
    } catch (e) {
      setState(() => this.barcode = '3#Unknown error: $e');
    }
  }

  Future _checkInOut(int membershipId) async {
    var _token = widget.userData.token;
    Uri uri;
    Map data;
    if (statusCheck.toString() == "CheckIn") {
      uri = Uri.parse(Constants.apiGateway + "/Guest/CheckIn");
      data = {
        "GuestId": widget.userData.userId,
        "ProjectId": projectid,
        "ProjectName": projectname,
        "MembershipId": membershipId,
        "LocationId": userCheck
      };
    } else {
      uri = Uri.parse(Constants.apiGateway + "/Guest/CheckOut");
      data = {
        "GuestId": widget.userData.userId,
        "ProjectId": projectid,
        "ProjectName": projectname,
        "MembershipId": membershipId,
        "LocationId": userCheck
      };
    }

    //   final response = await http.post(uri,
    //   headers: {
    //     HttpHeaders.contentTypeHeader: 'application/json',
    //     HttpHeaders.authorizationHeader: "Bearer $_token",
    //   },
    //   body :  data
    // );
    //if (response.statusCode == 200) {
    var response = await WebClient(User(token: _token)).post(uri, data);
    var responseJson = json.decode(response.toString());

    //var responseJson = json.decode(response.body);
    var dataResponse = responseJson["entity"];

    if (responseJson["returnStatus"] == true) {
      if (dataResponse["status"] == "Draft") {
        barcode = "1#Please wait until admin confirm your checkin/out";
        checkId = dataResponse["id"];
      } else if (dataResponse["status"] == "Confirmed") {
        if (statusCheck.toString() == "CheckIn") {
          barcode = "2#Success to checkIn";
          checkId = dataResponse["id"];
        } else {
          barcode = "2#Success to checkOut";
          checkId = dataResponse["id"];
        }
      } else {
        barcode = "3#Failed";
      }
    } else {
      barcode = "3#" + responseJson["returnMessage"].toString();
    }
    // } else {
    //   barcode = "3#Failed to load data ";
    // }

    setState(() {
      _checkButton(barcode);
      this.barcode = barcode;
    });
  }

  Future confirm() async {
    var _token = widget.userData.token;
    try {
      String confirm = "";

      Uri uri = Uri.parse(Constants.apiGateway +
          "/Guest/GetCheckInStatus?id=" +
          checkId.toString());
      //   final response = await http.get(uri,
      //   headers: {
      //     HttpHeaders.contentTypeHeader: 'application/json',
      //     HttpHeaders.authorizationHeader: "Bearer $_token",
      //   }
      // );
      var response = await WebClient(User(token: _token)).get(uri);
      //if (response.statusCode == 200) {
      //var responseJson = json.decode(response.body);
      var dataResponse = response["entity"];
      if (dataResponse["status"] == "Draft") {
        confirm = "1#Waiting admin confirm checkin.";
        checkId = dataResponse["id"];
      } else if (dataResponse["status"] == "Confirmed") {
        if (statusCheck.toString() == "CheckIn") {
          confirm = "2#Success to checkIn";
          checkId = dataResponse["id"];
        } else {
          confirm = "2#Success to checkOut";
          checkId = dataResponse["id"];
        }
      } else {
        confirm = "3#Failed";
        checkId = 0;
      }
      // } else {
      //   confirm = "3#Failed to load data ";
      //   //throw Exception('Failed to load data 1');
      // }

      setState(() => this.barcode = confirm);
    } on PlatformException catch (e) {
      setState(() => this.barcode = '3#Unknown error: $e');
    } on FormatException {
      setState(() => this.barcode =
          '3#User returned using the "back"-button before scanning anything.');
    } catch (e) {
      setState(() => this.barcode = '3#Unknown error: $e');
    }
  }
}
