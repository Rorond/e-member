import 'package:emembers/data/classes/auth.dart';
import 'package:emembers/flutter_flow/flutter_flow_theme.dart';
import 'package:emembers/ui/card/bank_card.dart';
import 'package:flutter/material.dart';
// import 'package:native_widgets/native_widgets.dart';
import 'package:emembers/data/models/user.dart';
import 'package:emembers/data/models/member_detail.dart';
import 'package:emembers/data/web_client.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../../constants.dart';

class MemberDetailPage extends StatefulWidget {
  final User userData;
  MemberDetailPage({required this.userData});

  @override
  MemberDetailPageState createState() => MemberDetailPageState();
}

class MemberDetailPageState extends State<MemberDetailPage> {
  static final memberURL = Constants.apiGateway + "/Guest/GetMembership";

  List cards = [];
  var isLoading = false;

  _fetchData() async {
    setState(() {
      isLoading = true;
    });

    Uri uri = Uri.parse(memberURL +
        BaseUrlParams.baseUrlParams(widget.userData.userId.toString()) +
        "&GuestId=" +
        widget.userData.userId.toString());
    var _token = widget.userData.token;
    var response = await WebClient(User(token: _token)).get(uri);
    //var responseJson = json.decode(response.toString());

    // final response = await http.get(uri,
    //   headers: {
    //     HttpHeaders.contentTypeHeader: 'application/json',
    //     HttpHeaders.authorizationHeader: "Bearer $_token",
    //   }
    // );
    if (response["returnStatus"] == true && response["entity"].length > 0) {
      //var responseJson = json.decode(response.body);
      var dataset = response["entity"];
      cards = (dataset)
          .map((dataset) => new MemberDetail.fromJson(dataset))
          .toList();
      setState(() {
        isLoading = false;
      });
    }
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchData());
  }

  //int _curIndex = 0;
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
              "Member Package List",
              style: ListTittleProfile,
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
      backgroundColor: AppColors.primaryBackground,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: Expanded(
                      child: ListView.builder(
                          itemCount: 2,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == 0) {
                              return Container(
                                margin:
                                    EdgeInsets.only(left: 16.0, right: 16.0),
                                child: ListBody(
                                  children: <Widget>[
                                    Container(
                                      height: 10.0,
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.card_membership),
                                      title: Text(
                                        'Membership No.',
                                        textScaleFactor:
                                            AppColors.textScaleFactor,
                                      ),
                                      subtitle: Text(
                                        widget.userData.memberNo,
                                        textScaleFactor:
                                            AppColors.textScaleFactor,
                                      ),
                                    ),
                                    Divider(
                                      height: 20.0,
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.account_box),
                                      title: Text(
                                        'Name',
                                        textScaleFactor:
                                            AppColors.textScaleFactor,
                                      ),
                                      subtitle: Text(
                                        widget.userData.firstName +
                                            ' ' +
                                            widget.userData.lastName,
                                        textScaleFactor:
                                            AppColors.textScaleFactor,
                                      ),
                                    ),
                                    Divider(height: 20.0),
                                  ],
                                ),
                              );
                            } else {
                              return _userBankCardsWidget();
                            }
                          }),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _userBankCardsWidget() {
    return Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.account_balance),
                  ),
                  Text(
                    'My Member Package',
                    style: productname,
                  )
                ],
              )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 9.0),
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cards.length,
              itemBuilder: (BuildContext context, int index) {
                return _getBankCard(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getBankCard(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MemberCards(card: cards[index]),
    );
  }
}

class MemberCards extends StatelessWidget {
  final MemberDetail card;
  MemberCards({required this.card});

  @override
  Widget build(BuildContext context) {
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    return Container(
      // height: 150.0,
      width: 260,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        image:
            DecorationImage(image: AssetImage(card.bgAsset), fit: BoxFit.cover),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    _auth.user.memberNo.toString() == "" ||
                            _auth.user.memberNo.toString() == "null"
                        ? 'Non Member'
                        : _auth.user.memberNo.toString(),
                    textAlign: TextAlign.left,
                    style: memberText,
                  ),
                  Text(
                    'Valid Until: ${card.validDate}',
                    textAlign: TextAlign.left,
                    style: memberTextdate,
                  ),
                  Text(
                    _auth.user.firstName + " " + _auth.user.lastName,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: card.bgAsset == 'assets/images/bgatas.png' ||
                                card.bgAsset == 'assets/images/bgkartu.png'
                            ? Colors.white
                            : AppColors.nearlyWhite,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Product: ${card.membershipName}',
                    textAlign: TextAlign.left,
                    style: memberTextdate,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/images/logoputih.png',
                      width: 40,
                    ),
                    SizedBox(width: 100),
                    Text(card.status,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
