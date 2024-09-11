// import 'package:emembers/constants.dart';
// import 'package:emembers/flutter_flow/flutter_flow_theme.dart';
// import 'package:emembers/ui/golf%20old/buyproduct.dart';
// import 'package:emembers/ui/golf%20old/teetimebooking.dart';
// import 'package:flutter/material.dart';

// import '../../data/models/user.dart';

// class ClubGolfList extends StatefulWidget {
//   final User? user;
//   const ClubGolfList({Key? key, this.user}) : super(key: key);

//   @override
//   State<ClubGolfList> createState() => _ClubGolfListState();
// }

// class _ClubGolfListState extends State<ClubGolfList> {
//   List<GolfProjectList> projectclub = [
//     GolfProjectList(
//       Id: '1',
//       name: 'Nuvasa Golf',
//       companyId: '',
//       imageUrl: 'https://img.gogolf.co.id/provider/333-0zo52r1qzn.jpg',
//       ticketClosedTime: '123',
//       city: 'Karawang',
//       currentPrice: 'Rp.700.000',
//     ),
//     GolfProjectList(
//       Id: '2',
//       name: 'Golf Nuvasa',
//       companyId: '',
//       imageUrl: 'https://img.gogolf.co.id/provider/212-gj7aedv0t8.jpg',
//       ticketClosedTime: '123',
//       city: 'Batam',
//       currentPrice: 'Rp.700.000',
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.primaryBackground,
//       appBar: AppBar(
//         title: Text(
//           "Club Golf List",
//           style: AppTittle,
//         ),
//         centerTitle: true,
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(12),
//         itemCount: projectclub.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Padding(
//             padding: const EdgeInsets.only(bottom: 16),
//             child: InkWell(
//               splashColor: Colors.transparent,
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => BuyProduct(
//                       user: widget.user!,
//                       imageUrl: projectclub[index].imageUrl,
//                       projectName: projectclub[index].name,
//                     ),
//                   ),
//                 );
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: FlutterFlowTheme.of(context).primaryBackground,
//                   borderRadius: const BorderRadius.all(Radius.circular(16.0)),
//                   boxShadow: <BoxShadow>[
//                     BoxShadow(
//                       color: FlutterFlowTheme.of(context).primaryBackground,
//                       offset: const Offset(4, 4),
//                       blurRadius: 8,
//                     ),
//                   ],
//                 ),
//                 child: ClipRRect(
//                   borderRadius: const BorderRadius.all(Radius.circular(8.0)),
//                   child: Stack(
//                     children: <Widget>[
//                       Column(
//                         children: <Widget>[
//                           AspectRatio(
//                             aspectRatio: 2,
//                             child: Image.network(
//                               projectclub[index].imageUrl,
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                           Container(
//                             color: AppColors.chipBackground,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 Expanded(
//                                   child: Container(
//                                     color: FlutterFlowTheme.of(context)
//                                         .primaryBackground,
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(
//                                           left: 16, top: 8, bottom: 8),
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: <Widget>[
//                                           Text(
//                                             projectclub[index].name,
//                                             textAlign: TextAlign.left,
//                                             style: clubname,
//                                           ),
//                                           Row(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.start,
//                                             children: <Widget>[
//                                               Row(
//                                                 mainAxisSize: MainAxisSize.max,
//                                                 children: [
//                                                   Icon(
//                                                     Icons.location_on_rounded,
//                                                     color: FlutterFlowTheme.of(
//                                                             context)
//                                                         .secondaryText,
//                                                     size: 16,
//                                                   ),
//                                                   Text(
//                                                     projectclub[index].city,
//                                                     style: FlutterFlowTheme.of(
//                                                             context)
//                                                         .bodySmall,
//                                                   ),
//                                                 ],
//                                               ),
//                                               const SizedBox(width: 4),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class GolfProjectList {
//   String Id;
//   String name;
//   String companyId;
//   String imageUrl;
//   String ticketClosedTime;
//   String city;
//   String currentPrice;

//   GolfProjectList({
//     required this.Id,
//     required this.name,
//     required this.companyId,
//     required this.imageUrl,
//     required this.ticketClosedTime,
//     required this.city,
//     required this.currentPrice,
//   });
// }
