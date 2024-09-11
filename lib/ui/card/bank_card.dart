// import 'package:emembers/ui/card/member_detail.dart';
// import 'package:emembers/ui/member/member_detail.dart';
// import 'package:flutter/material.dart';
// import 'package:emembers/constants.dart';
// import 'package:emembers/data/classes/auth.dart';
// import 'package:scoped_model/scoped_model.dart';

// import 'package:emembers/data/models/member_detail.dart';

// class BankCard extends StatelessWidget {
//   final BankCardModel card;
//   BankCard({required this.card});

//   @override
//   Widget build(BuildContext context) {
//     final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Member Packege List"),
//         backgroundColor: AppColors.primaryColor,
//       ),
//       backgroundColor: Colors.white,
//       body: Align(
//         alignment: Alignment.topCenter,
//         child: Padding(
//           padding: const EdgeInsets.only(top: 40.0),
//           child: Container(
//             height: 175.0,
//             width: 297.0,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.all(Radius.circular(10.0)),
//               image: DecorationImage(
//                 image: AssetImage(card.bgAsset),
//                 fit: BoxFit.contain,
//                 alignment: Alignment.center,
//               ),
//             ),
//             child: Column(
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: <Widget>[
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Padding(
//                           padding: const EdgeInsets.only(top: 10.0, right: 16.0),
//                           child: TextButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         MemberDetailPage(userData: _auth.user)),
//                               );
//                             },
//                             child: Row(children: <Widget>[
//                               Padding(
//                                 padding: const EdgeInsets.all(5.0),
//                                 child: Icon(
//                                   Icons.card_membership,
//                                   color: AppColors.white,
//                                   size: 24,
//                                 ),
//                               ),
//                               Text(
//                                 'My Cards',
//                                 textAlign: TextAlign.left,
//                                 style: AppTexts.textFormFieldRegular
//                                     .copyWith(color: AppColors.white),
//                               ),
//                             ]),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.only(left: 16.0),
//                         child: Text(
//                           _auth.user.memberNo.toString() == "" ||
//                                   _auth.user.memberNo.toString() == "null"
//                               ? 'Non Member'
//                               : _auth.user.memberNo.toString(),
//                           textAlign: TextAlign.left,
//                           style: AppTexts.textFormFieldRegular
//                               .copyWith(color: AppColors.white),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 16.0, top: 4.0),
//                         child: Text(
//                           'Valid Until: ${card.validDate}',
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                               color: AppColors.white,
//                               fontSize: 14.0,
//                               fontWeight: FontWeight.normal),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 16.0, top: 4.0),
//                         child: Text(
//                           _auth.user.firstName + " " + _auth.user.lastName,
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                               color: card.bgAsset == 'assets/images/bgatas.png' ||
//                                       card.bgAsset == 'assets/images/bgkartu.png'
//                                   ? Colors.white
//                                   : AppColors.nearlyWhite,
//                               fontSize: 16.0,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MemberCards extends StatelessWidget {
//   final MemberDetail card;
//   MemberCards({required this.card});

//   @override
//   Widget build(BuildContext context) {
//     final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
//     return Container(
//       height: 150.0,
//       width: 252.0,
//       decoration: BoxDecoration(
//         image:
//             DecorationImage(image: AssetImage(card.bgAsset), fit: BoxFit.cover),
//       ),
//       child: Column(
//         children: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: <Widget>[
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.only(top: 20.0, right: 16.0),
//                     child: Text(
//                       card.status,
//                       textAlign: TextAlign.right,
//                       style: TextStyle(
//                           color: AppColors.primaryColor,
//                           fontSize: 16.0,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.only(left: 16.0),
//                         child: Text(
//                           _auth.user.memberNo.toString() == "" ||
//                                   _auth.user.memberNo.toString() == "null"
//                               ? 'Non Member'
//                               : _auth.user.memberNo.toString(),
//                           textAlign: TextAlign.left,
//                           style: AppTexts.textFormFieldRegular
//                               .copyWith(color: AppColors.white),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 16.0, top: 4.0),
//                         child: Text(
//                           'Valid Until: ${card.validDate}',
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                               color: AppColors.white,
//                               fontSize: 14.0,
//                               fontWeight: FontWeight.normal),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 16.0, top: 4.0),
//                         child: Text(
//                           _auth.user.firstName + " " + _auth.user.lastName,
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                               color: card.bgAsset == 'assets/images/bgatas.png' ||
//                                       card.bgAsset == 'assets/images/bgkartu.png'
//                                   ? Colors.white
//                                   : AppColors.nearlyWhite,
//                               fontSize: 16.0,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//         ],
//       ),
//     );
//   }
// }
// class SmallBankCard extends StatelessWidget {
//   final MemberDetail card;
//   final double screenWidth;
//   SmallBankCard({required this.card, required this.screenWidth});
//   @override
//   Widget build(BuildContext context) {
//     // todo: implement build
//     final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
//     final bool isLargeScreen = screenWidth > 320;
//     final double topPadding = isLargeScreen ? 14.0 : 24.0;
//     final EdgeInsets inset = EdgeInsets.only(left: 16.0, top: topPadding);
//     return Container(
// //      height: 88.0,
// //      width: 150.0,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage(card.bgAsset), fit: BoxFit.cover),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: <Widget>[
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.only(top: 20.0, right: 16.0),
//                     child: Text(
//                       card.status,
//                       textAlign: TextAlign.right,
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12.0,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Expanded(
//                       child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: <Widget>[
//                       Padding(
//                         padding: inset,
//                         child: Text(
//                           _auth.user.memberNo.toString() == "" ||
//                                   _auth.user.memberNo.toString() == "null"
//                               ? 'Non Member'
//                               : _auth.user.memberNo.toString(),
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: isLargeScreen ? 8.0 : 16.0,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       // Padding(
//                       //   padding: const EdgeInsets.only(left: 16.0, top: 2.0),
//                       //   child: Row(
//                       //     crossAxisAlignment: CrossAxisAlignment.center,
//                       //     children: <Widget>[
//                       //       Text(
//                       //         'VALID\nTHRU',
//                       //         textAlign: TextAlign.left,
//                       //         style: TextStyle(
//                       //             color: card.bgAsset == 'assets/images/bgatas.png' ||
//                       //           card.bgAsset == 'assets/images/bgkartu.png'
//                       //                 ? Colors.grey
//                       //                 : Colors.black,
//                       //             fontSize: isLargeScreen ? 6.0 : 12.0,
//                       //             fontWeight: FontWeight.bold),
//                       //       ),
//                       //       Padding(
//                       //         padding:
//                       //             const EdgeInsets.symmetric(horizontal: 8.0),
//                       //         child: Text(
//                       //           card.validDate,
//                       //           textAlign: TextAlign.left,
//                       //           style: TextStyle(
//                       //               color: Colors.white,
//                       //               fontSize: isLargeScreen ? 10.0 : 20.0,
//                       //               fontWeight: FontWeight.bold),
//                       //         ),
//                       //       )
//                       //     ],
//                       //   ),
//                       // ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 16.0, top: 2.0),
//                         child: Text(
//                           card.membershipName,
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                               color: card.bgAsset == 'assets/images/bgatas.png' ||
//                                 card.bgAsset == 'assets/images/bgkartu.png'
//                                   ? Colors.grey
//                                   : Color(0xFF253C70),
//                               fontSize: isLargeScreen ? 9.0 : 13.0,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ],
//                   )),
//                 ],
//               ),
//             ),
//             // GestureDetector(
//             //   child: Container(
//             //     child: Image.asset('assets/images/ico_delete_card.png'),
//             //   ),
//             // ),
//           ],
//         ));
//   }
// }

// class BankCardModel {
//   final String token;
//   final int userId;
//   final String bgAsset;
//   final int balance;
//   final String name;
//   final String validDate;
//   final String accountNumber;

//   BankCardModel(this.token, this.userId, this.bgAsset, this.name,
//       this.accountNumber, this.validDate, this.balance);
// }

// BankCardModel myCard = BankCardModel(
//   "",
//   123,
//   "assets/images/bgkartu.png",
//   "Card Holder Name",
//   "1234 5678 9012 3456",
//   "12/26",
//   2,
// );
