// import 'package:emembers/ui/card/bank_card.dart';
// import 'package:flutter/material.dart';
// // import 'package:native_widgets/native_widgets.dart';
// import 'package:emembers/data/models/user.dart';
// import 'package:emembers/data/models/member_detail.dart';
// import 'package:emembers/data/web_client.dart';
// import '../../../constants.dart';

// class MemberDetailPage extends StatefulWidget {
//   final User userData;
//   MemberDetailPage({required this.userData});

//   @override
//   MemberDetailPageState createState() => MemberDetailPageState();
// }

// class MemberDetailPageState extends State<MemberDetailPage> {
//   static final memberURL = Constants.apiGateway + "/Guest/GetMembership";

//   List cards = [];
//   var isLoading = false;
//   _fetchData() async {
//     setState(() {
//       isLoading = true;
//     });

//     Uri uri = Uri.parse(memberURL +
//         BaseUrlParams.baseUrlParams(widget.userData.userId.toString()) +
//         "&GuestId=" +
//         widget.userData.userId.toString());
//     var _token = widget.userData.token;
//     var response = await WebClient(User(token: _token)).get(uri);
//     //var responseJson = json.decode(response.toString());

//     // final response = await http.get(uri,
//     //   headers: {
//     //     HttpHeaders.contentTypeHeader: 'application/json',
//     //     HttpHeaders.authorizationHeader: "Bearer $_token",
//     //   }
//     // );
//     if (response["returnStatus"] == true) {
//       //var responseJson = json.decode(response.body);
//       var dataset = response["entity"];
//       cards = (dataset)
//           .map((dataset) => new MemberDetail.fromJson(dataset))
//           .toList();
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) => _fetchData());
//   }

//   //int _curIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Member Packege List"),
//         backgroundColor: AppColors.primaryColor,
//       ),
//       backgroundColor: Color(0xFFF4F4F4),
//       body: isLoading
//           ? Center(
//               child: CircularProgressIndicator.adaptive(),
//             )
//           : Container(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   Container(
//                     child: Expanded(
//                       child: ListView.builder(
//                           itemCount: 2,
//                           itemBuilder: (BuildContext context, int index) {
//                             if (index == 0) {
//                               return Container(
//                                 margin:
//                                     EdgeInsets.only(left: 16.0, right: 16.0),
//                                 child: ListBody(
//                                   children: <Widget>[
//                                     Container(
//                                       height: 10.0,
//                                     ),
//                                     ListTile(
//                                       leading: Icon(Icons.card_membership),
//                                       title: Text(
//                                         'Membership No.',
//                                         textScaleFactor:
//                                             AppColors.textScaleFactor,
//                                       ),
//                                       subtitle: Text(
//                                         widget.userData.memberNo,
//                                         textScaleFactor:
//                                             AppColors.textScaleFactor,
//                                       ),
//                                     ),
//                                     Divider(
//                                       height: 20.0,
//                                     ),
//                                     ListTile(
//                                       leading: Icon(Icons.card_membership),
//                                       title: Text(
//                                         'Status',
//                                         textScaleFactor:
//                                             AppColors.textScaleFactor,
//                                       ),
//                                       subtitle: Text(
//                                         widget.userData.status,
//                                         textScaleFactor:
//                                             AppColors.textScaleFactor,
//                                       ),
//                                     ),
//                                     Divider(
//                                       height: 20.0,
//                                     ),
//                                     ListTile(
//                                       leading: Icon(Icons.account_box),
//                                       title: Text(
//                                         'Name',
//                                         textScaleFactor:
//                                             AppColors.textScaleFactor,
//                                       ),
//                                       subtitle: Text(
//                                         widget.userData.firstName +
//                                             ' ' +
//                                             widget.userData.lastName,
//                                         textScaleFactor:
//                                             AppColors.textScaleFactor,
//                                       ),
//                                     ),

//                                     Divider(height: 20.0),
//                                   ],
//                                 ),
//                               );
//                             } else {
//                               return _userBankCardsWidget();
//                             }
//                           }),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }

//   Widget _userBankCardsWidget() {
//     //var size = MediaQuery.of(context).size;
//     return Container(
//       margin: EdgeInsets.only(left: 16.0, right: 16.0),
// //      height: 400.0,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
//               child: Row(
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.only(right: 8.0),
//                     child: Icon(Icons.account_balance),
//                   ),
//                   Text(
//                     'My Member Package',
//                     style: TextStyle(fontWeight: FontWeight.w700),
//                   )
//                 ],
//               )),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 8.0),
//             height: 176.0,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: cards.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return _getBankCard(index);
//               },
//             ),
//           ),
// //          GridView.builder(
// //            physics: ScrollPhysics(),
// //              shrinkWrap: true,
// //              itemCount: cards.length,
// //              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
// //                  crossAxisCount: 2),
// //              itemBuilder: (BuildContext context, int index) {
// //                return _getBankCard(index);
// //              }),
//           // GridView.count(crossAxisCount: size.width > 320 ? 2 : 1,
//           // physics: ScrollPhysics(),
//           // shrinkWrap: true,
//           // childAspectRatio: (152 / 92),
//           //   controller: new ScrollController(keepScrollOffset: false),
//           //   children: List.generate(cards.length, (index) {
//           //     return _getBankCard(index);
//           //   }),
//           // ),
//         ],
//       ),
//     );
//   }

//   Widget _getBankCard(int index) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       // child: MemberCards(card: cards[index]),
//     );
//   }
// }
