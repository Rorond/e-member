// import 'package:emembers/index.dart';
// import 'package:emembers/ui/home/homepage_widget.dart';
// import 'package:emembers/ui/lockedscreen/voucher_point_saya_widget.dart';
// import 'package:emembers/ui/menuLoyalty/point_voucher.dart';

// import '/flutter_flow/flutter_flow_icon_button.dart';
// import '/flutter_flow/flutter_flow_theme.dart';
// import '/flutter_flow/flutter_flow_util.dart';
// import '/flutter_flow/flutter_flow_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// import 'history_point_model.dart';
// export 'history_point_model.dart';

// class HistoryPointWidget extends StatefulWidget {
//   const HistoryPointWidget({Key? key}) : super(key: key);

//   @override
//   _HistoryPointWidgetState createState() => _HistoryPointWidgetState();
// }

// class _HistoryPointWidgetState extends State<HistoryPointWidget> {
//   late HistoryPointModel _model;

//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//     _model = createModel(context, () => HistoryPointModel());
//   }

//   @override
//   void dispose() {
//     _model.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
//         body: SafeArea(
//           top: true,
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Align(
//                   alignment: AlignmentDirectional(0.00, 0.00),
//                   child: Container(
//                     height: 210,
//                     child: Stack(
//                       alignment: AlignmentDirectional(0, 1),
//                       children: [
//                         Container(
//                           height: 230,
//                           child: Stack(
//                             alignment: AlignmentDirectional(0, -1),
//                             children: [
//                               Align(
//                                 alignment: AlignmentDirectional(0.00, 0.00),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(8),
//                                   child: Image.asset(
//                                     'assets/images/bgkartu.png',
//                                     width: 430,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsetsDirectional.fromSTEB(
//                                     0, 15, 0, 0),
//                                 child: Container(
//                                   width: 363,
//                                   height: 40,
//                                   decoration: BoxDecoration(),
//                                   child: Stack(
//                                     alignment: AlignmentDirectional(0, 5),
//                                     children: [
//                                       Row(
//                                         mainAxisSize: MainAxisSize.max,
//                                         children: [
//                                           Container(
//                                             width: 353,
//                                             height: 50,
//                                             decoration: BoxDecoration(),
//                                             child: Row(
//                                               mainAxisSize: MainAxisSize.max,
//                                               children: [
//                                                 Align(
//                                                   alignment:
//                                                       AlignmentDirectional(
//                                                           0.00, 0.00),
//                                                   child: FlutterFlowIconButton(
//                                                     // borderColor:
//                                                     //     FlutterFlowTheme.of(
//                                                     //             context)
//                                                     //         .secondaryBackground,
//                                                     // borderRadius: 20,
//                                                     // borderWidth: 1,
//                                                     // buttonSize: 20,
//                                                     // fillColor: Colors.white,
//                                                     icon: Icon(
//                                                       Icons.arrow_back,
//                                                       color:
//                                                           FlutterFlowTheme.of(
//                                                                   context)
//                                                               .primaryBackground,
//                                                       size: 24,
//                                                     ),
//                                                     onPressed: () async{
//                                                       await Navigator.push(context,
//                                                       MaterialPageRoute(builder: (context) => new HomepageWidget()
//                                                       ),
//                                                       );
//                                                     },
//                                                   ),
//                                                 ),
//                                                 Align(
//                                                   alignment:
//                                                       AlignmentDirectional(
//                                                           0.00, 0.00),
//                                                   child: Padding(
//                                                     padding:
//                                                         EdgeInsetsDirectional
//                                                             .fromSTEB(
//                                                                 100, 0, 0, 0),

//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
//                           child: Container(
//                             width: 335,
//                             height: 150,
//                             decoration: BoxDecoration(),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.max,
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Column(
//                                   mainAxisSize: MainAxisSize.max,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Align(
//                                           alignment:
//                                               AlignmentDirectional(0.00, 0.00),
//                                           child: Icon(
//                                             Icons.stars_outlined,
//                                             color: Colors.white,
//                                             size: 80,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 Column(
//                                   mainAxisSize: MainAxisSize.max,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       'Point Tersedia',
//                                       style: FlutterFlowTheme.of(context)
//                                           .bodyMedium
//                                           .override(
//                                             fontFamily: 'Quicksand',
//                                             color: Colors.white,
//                                             fontSize: 18,
//                                           ),
//                                     ),
//                                     Text(
//                                       '1.680',
//                                       style: FlutterFlowTheme.of(context)
//                                           .bodyMedium
//                                           .override(
//                                             fontFamily: 'Quicksand',
//                                             color: Colors.white,
//                                             fontSize: 40,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
//                   child: Container(
//                     width: MediaQuery.of(context).size.width * 0.95,
//                     height: 100,
//                     decoration: BoxDecoration(),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Container(
//                           width: 100,
//                           height: 100,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 Icons.stars_rounded,
//                                 color: Color(0xFFD9D9D9),
//                                 size: 32,
//                               ),InkWell(
//                                 onTap: () async {
//                                   // await Navigator.push(context,
//                                   // MaterialPageRoute(builder: (context) => new VoucherPointWidget()
//                                   // ),
//                                   // );
//                                 },
//                                 child: Text(
//                                 'Tukar Point',
//                                 style: FlutterFlowTheme.of(context)
//                                     .bodyMedium
//                                     .override(
//                                       fontFamily: 'Quicksand',
//                                       color: Color(0xFFADACAC),
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                               ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 80,
//                           child: VerticalDivider(
//                             thickness: 2,
//                             color: FlutterFlowTheme.of(context).alternate,
//                           ),
//                         ),
//                         Container(
//                           width: 100,
//                           height: 100,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 Icons.stars_rounded,
//                                 color: Color(0xFFD9D9D9),
//                                 size: 32,
//                               ),
//                               InkWell(
//                                 onTap: () async {
//                                   await Navigator.push(context,
//                                   MaterialPageRoute(builder: (context) => new VoucherPointSayaWidget()
//                                   ),
//                                   );
//                                 },
//                                 child: Text(
//                                 'Voucher Saya',
//                                 style: FlutterFlowTheme.of(context)
//                                     .bodyMedium
//                                     .override(
//                                       fontFamily: 'Quicksand',
//                                       color: Color(0xFFADACAC),
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                               ),
//                               ),

//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 80,
//                           child: VerticalDivider(
//                             thickness: 2,
//                             color: FlutterFlowTheme.of(context).alternate,
//                           ),
//                         ),
//                         Container(
//                           width: 100,
//                           height: 100,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 Icons.card_giftcard,
//                                 color: Color(0xFF2050AD),
//                                 size: 32,
//                               ),
//                               Text(
//                                 'History Point',
//                                 textAlign: TextAlign.center,
//                                 style: FlutterFlowTheme.of(context)
//                                     .bodyMedium
//                                     .override(
//                                       fontFamily: 'Quicksand',
//                                       color: Color(0xFF2050AD),
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Align(
//                   alignment: AlignmentDirectional(0.00, 0.00),
//                   child: Container(
//                     width: MediaQuery.of(context).size.width * 0.85,
//                     height: MediaQuery.of(context).size.height * 0.7,
//                     decoration: BoxDecoration(),
//                     child: ListView(
//                       padding: EdgeInsets.zero,
//                       scrollDirection: Axis.vertical,
//                       children: [
//                         Container(
//                           width: 100,
//                           height: 80,
//                           decoration: BoxDecoration(
//                             color: FlutterFlowTheme.of(context)
//                                 .secondaryBackground,
//                             boxShadow: [
//                               BoxShadow(
//                                 blurRadius: 4,
//                                 color: Color(0x4DE4E4E4),
//                                 offset: Offset(0, 2),
//                               )
//                             ],
//                             borderRadius: BorderRadius.circular(3),
//                           ),
//                           child: Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.max,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Column(
//                                       mainAxisSize: MainAxisSize.max,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           'Payment Ticket OP',
//                                           style: FlutterFlowTheme.of(context)
//                                               .bodyMedium
//                                               .override(
//                                                 fontFamily: 'Quicksand',
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w600,
//                                               ),
//                                         ),
//                                         Text(
//                                           'Tanggal Transaksi',
//                                           style: FlutterFlowTheme.of(context)
//                                               .bodyMedium,
//                                         ),
//                                       ],
//                                     ),
//                                     Column(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: [
//                                         Text(
//                                           '+ 5 poin',
//                                           style: FlutterFlowTheme.of(context)
//                                               .bodyMedium
//                                               .override(
//                                                 fontFamily: 'Quicksand',
//                                                 color:
//                                                     FlutterFlowTheme.of(context)
//                                                         .secondary,
//                                               ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Container(
//                           width: 100,
//                           height: 80,
//                           decoration: BoxDecoration(
//                             color: FlutterFlowTheme.of(context)
//                                 .secondaryBackground,
//                             boxShadow: [
//                               BoxShadow(
//                                 blurRadius: 4,
//                                 color: Color(0x4DE4E4E4),
//                                 offset: Offset(0, 2),
//                               )
//                             ],
//                             borderRadius: BorderRadius.circular(3),
//                           ),
//                           child: Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.max,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Column(
//                                       mainAxisSize: MainAxisSize.max,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           'Check-In Ticketing',
//                                           style: FlutterFlowTheme.of(context)
//                                               .bodyMedium
//                                               .override(
//                                                 fontFamily: 'Quicksand',
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w600,
//                                               ),
//                                         ),
//                                         Text(
//                                           'Tanggal Transaksi',
//                                           style: FlutterFlowTheme.of(context)
//                                               .bodyMedium,
//                                         ),
//                                       ],
//                                     ),
//                                     Column(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: [
//                                         Text(
//                                           '+ 5 poin',
//                                           style: FlutterFlowTheme.of(context)
//                                               .bodyMedium
//                                               .override(
//                                                 fontFamily: 'Quicksand',
//                                                 color:
//                                                     FlutterFlowTheme.of(context)
//                                                         .secondary,
//                                               ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Container(
//                           width: 100,
//                           height: 80,
//                           decoration: BoxDecoration(
//                             color: FlutterFlowTheme.of(context)
//                                 .secondaryBackground,
//                             boxShadow: [
//                               BoxShadow(
//                                 blurRadius: 4,
//                                 color: Color(0x4DE4E4E4),
//                                 offset: Offset(0, 2),
//                               )
//                             ],
//                             borderRadius: BorderRadius.circular(3),
//                           ),
//                           child: Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.max,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Column(
//                                       mainAxisSize: MainAxisSize.max,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           'Join Members Quantis',
//                                           style: FlutterFlowTheme.of(context)
//                                               .bodyMedium
//                                               .override(
//                                                 fontFamily: 'Quicksand',
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w600,
//                                               ),
//                                         ),
//                                         Text(
//                                           'Tanggal Transaksi',
//                                           style: FlutterFlowTheme.of(context)
//                                               .bodyMedium,
//                                         ),
//                                       ],
//                                     ),
//                                     Column(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: [
//                                         Text(
//                                           '+ 10 poin',
//                                           style: FlutterFlowTheme.of(context)
//                                               .bodyMedium
//                                               .override(
//                                                 fontFamily: 'Quicksand',
//                                                 color:
//                                                     FlutterFlowTheme.of(context)
//                                                         .secondary,
//                                               ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ].divide(SizedBox(height: 13)),
//                     ),
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
