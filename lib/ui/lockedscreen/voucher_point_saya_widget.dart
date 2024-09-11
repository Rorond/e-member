// import 'package:emembers/index.dart';
// import 'package:emembers/ui/home/homepage_widget.dart';
// import 'package:emembers/ui/lockedscreen/history_point_widget.dart';
// import 'package:emembers/ui/menuLoyalty/point_voucher.dart';

// import '/flutter_flow/flutter_flow_icon_button.dart';
// import '/flutter_flow/flutter_flow_theme.dart';
// import '/flutter_flow/flutter_flow_util.dart';
// import '/flutter_flow/flutter_flow_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// import 'voucher_point_saya_model.dart';
// export 'voucher_point_saya_model.dart';

// class VoucherPointSayaWidget extends StatefulWidget {
//   const VoucherPointSayaWidget({Key? key}) : super(key: key);

//   @override
//   _VoucherPointSayaWidgetState createState() => _VoucherPointSayaWidgetState();
// }

// class _VoucherPointSayaWidgetState extends State<VoucherPointSayaWidget> {
//   late VoucherPointSayaModel _model;

//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//     _model = createModel(context, () => VoucherPointSayaModel());
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
//                                   borderRadius: BorderRadius.only(
//                                     bottomLeft: Radius.circular(10.0),
//                                     bottomRight: Radius.circular(10.0),
//                                   ),
//                                   child: Image.asset(
//                                     'assets/images/bgkartu.png',
//                                     width: 430,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                             Padding(
//                                 padding: EdgeInsetsDirectional.fromSTEB(
//                                     0, 0, 0, 0),
//                                 child: Container(
//                                   width: 363,
//                                   height: 50,
//                                   decoration: BoxDecoration(),
//                                   child: Stack(
//                                     alignment: AlignmentDirectional(0, 5),
//                                     children: [
//                                       Row(
//                                         mainAxisSize: MainAxisSize.max,
//                                         children: [
//                                           Container(
//                                             width: 350,
//                                             height: 50,
//                                             decoration: BoxDecoration(),
//                                             child: Row(
//                                               mainAxisSize: MainAxisSize.max,
//                                               children: [
//                                                 FlutterFlowIconButton(
//                                                   icon: Icon(
//                                                     Icons.arrow_back,
//                                                     color: FlutterFlowTheme.of(
//                                                             context)
//                                                         .primaryBackground,
//                                                     size: 22,
//                                                   ),
//                                                   onPressed: () async {
//                                                    await Navigator.push(
//                                                       context,
//                                                       MaterialPageRoute(
//                                                         builder: (context) =>
//                                                             new HomepageWidget(),
//                                                       ),
//                                                     );
//                                                   },
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
//                           padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 50),
//                           child: Container(
//                             width: 335,
//                             height: 100,
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
//                                             fontWeight: FontWeight.w600,
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
//                               ),
//                               InkWell(
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
//                           height: 60,
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
//                                 'Voucher Saya',
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
//                         SizedBox(
//                           height: 60,
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
//                                 Icons.history_edu_rounded,
//                                 color: Color(0xFFADACAC),
//                                 size: 32,
//                               ),
//                               InkWell(
//                                 onTap: () async {
//                                   await Navigator.push(context,
//                                   MaterialPageRoute(builder: (context) => new HistoryPointWidget()
//                                   ),
//                                   );
//                                 },
//                                 child: Text(
//                                 'History Point',
//                                 style: FlutterFlowTheme.of(context)
//                                     .bodyMedium
//                                     .override(
//                                       fontFamily: 'Quicksand',
//                                       color: Color(0xFFD9D9D9),
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                               ),
//                               )

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
//                           height: 220,
//                           decoration: BoxDecoration(
//                             color: FlutterFlowTheme.of(context)
//                                 .secondaryBackground,
//                             boxShadow: [
//                               BoxShadow(
//                                 blurRadius: 4,
//                                 color: Color(0x1A000000),
//                                 offset: Offset(0, 2),
//                               )
//                             ],
//                             borderRadius: BorderRadius.circular(6),
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Flexible(
//                                 child: Align(
//                                   alignment: AlignmentDirectional(0.00, 0.00),
//                                   child: Padding(
//                                     padding: EdgeInsetsDirectional.fromSTEB(
//                                         10, 0, 10, 0),
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.max,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceAround,
//                                       children: [
//                                         Row(
//                                           mainAxisSize: MainAxisSize.max,
//                                           children: [
//                                             Flexible(
//                                               child: Align(
//                                                 alignment: AlignmentDirectional(
//                                                     0.00, 0.00),
//                                                 child: ClipRRect(
//                                                   borderRadius:
//                                                       BorderRadius.circular(8),
//                                                   child: Image.network(
//                                                     'https://images.unsplash.com/photo-1532795986-dbef1643a596?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxN3x8ZGlzY291bnR8ZW58MHx8fHwxNjk1MTQ5NDYwfDA&ixlib=rb-4.0.3&q=80&w=400',
//                                                     width: 300,
//                                                     height: 150,
//                                                     fit: BoxFit.cover,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         Row(
//                                           mainAxisSize: MainAxisSize.max,
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Column(
//                                               mainAxisSize: MainAxisSize.max,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   'Ocean Park Ticket',
//                                                   style: FlutterFlowTheme.of(
//                                                           context)
//                                                       .bodyMedium
//                                                       .override(
//                                                         fontFamily: 'Quicksand',
//                                                         fontSize: 16,
//                                                         fontWeight:
//                                                             FontWeight.w500,
//                                                       ),
//                                                 ),
//                                                 Text(
//                                                   'Point',
//                                                   style: FlutterFlowTheme.of(
//                                                           context)
//                                                       .bodyMedium
//                                                       .override(
//                                                         fontFamily: 'Quicksand',
//                                                         fontSize: 12,
//                                                       ),
//                                                 ),
//                                               ],
//                                             ),
//                                             Column(
//                                               mainAxisSize: MainAxisSize.max,
//                                               children: [
//                                                 FFButtonWidget(
//                                                   onPressed: () {
//                                                     showDialog(
//                                                       context: context,
//                                                       builder: (BuildContext context) {
//                                                         return AlertDialog(
//                                                           title: Text('Selamat Voucher Anda Sudah Digunakan'),
//                                                           titleTextStyle: TextStyle(
//                                                             fontSize: 15,
//                                                             color: Colors.black,
//                                                           ),
//                                                           actions: <Widget>[
//                                                             TextButton(
//                                                               child: Text('OK',
//                                                               style: TextStyle(
//                                                                 color: Colors.redAccent
//                                                               ),),
//                                                               onPressed: () {
//                                                                 Navigator.of(context).pop();
//                                                               },
//                                                             ),
//                                                           ],
//                                                         );
//                                                       },
//                                                     );
//                                                   },
//                                                   text: 'Gunakan',
//                                                   options: FFButtonOptions(
//                                                     height: 40,
//                                                     padding:
//                                                         EdgeInsetsDirectional
//                                                             .fromSTEB(
//                                                                 20, 0, 20, 0),
//                                                     iconPadding:
//                                                         EdgeInsetsDirectional
//                                                             .fromSTEB(
//                                                                 0, 0, 0, 0),
//                                                     color: Color(0xE1FFFFFF),
//                                                     textStyle: FlutterFlowTheme
//                                                             .of(context)
//                                                         .titleSmall
//                                                         .override(
//                                                           fontFamily: 'Quicksand',
//                                                           color: FlutterFlowTheme
//                                                                   .of(context)
//                                                               .primary,
//                                                         ),
//                                                     elevation: 3,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             8),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ].divide(SizedBox(height: 8)),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: 80,
//                   decoration: BoxDecoration(
//                     color: FlutterFlowTheme.of(context).primaryBackground,
//                     boxShadow: [
//                       BoxShadow(
//                         blurRadius: 4,
//                         color: Color(0x33000000),
//                         offset: Offset(0, -4),
//                       )
//                     ],
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(0),
//                       bottomRight: Radius.circular(0),
//                       topLeft: Radius.circular(10),
//                       topRight: Radius.circular(10),
//                     ),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         width: MediaQuery.of(context).size.width * 0.2,
//                         height: double.infinity,
//                         decoration: BoxDecoration(),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.home_filled,
//                               color: FlutterFlowTheme.of(context).primary,
//                               size: 26,
//                             ),
//                             Text(
//                               'Home',
//                               style: FlutterFlowTheme.of(context)
//                                   .bodyMedium
//                                   .override(
//                                     fontFamily: 'Quicksand',
//                                     color: FlutterFlowTheme.of(context).primary,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         width: MediaQuery.of(context).size.width * 0.2,
//                         height: double.infinity,
//                         decoration: BoxDecoration(),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.credit_card_rounded,
//                               color: FlutterFlowTheme.of(context).secondaryText,
//                               size: 26,
//                             ),
//                             Text(
//                               'Transaction',
//                               style: FlutterFlowTheme.of(context)
//                                   .bodyMedium
//                                   .override(
//                                     fontFamily: 'Quicksand',
//                                     color: FlutterFlowTheme.of(context)
//                                         .secondaryText,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         width: MediaQuery.of(context).size.width * 0.2,
//                         height: double.infinity,
//                         decoration: BoxDecoration(),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             FlutterFlowIconButton(
//                               borderColor: Colors.transparent,
//                               borderRadius: 20,
//                               borderWidth: 1,
//                               buttonSize: 42,
//                               fillColor: Color(0xFF0644E2),
//                               icon: Icon(
//                                 Icons.qr_code_scanner_rounded,
//                                 color: FlutterFlowTheme.of(context)
//                                     .primaryBackground,
//                                 size: 26,
//                               ),
//                               onPressed: () {
//                                 print('IconButton pressed ...');
//                               },
//                             ),
//                             Text(
//                               'Check In',
//                               style: FlutterFlowTheme.of(context)
//                                   .bodyMedium
//                                   .override(
//                                     fontFamily: 'Quicksand',
//                                     color: FlutterFlowTheme.of(context)
//                                         .secondaryText,
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         width: MediaQuery.of(context).size.width * 0.2,
//                         height: double.infinity,
//                         decoration: BoxDecoration(),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.wallet_rounded,
//                               color: FlutterFlowTheme.of(context).secondaryText,
//                               size: 26,
//                             ),
//                             Text(
//                               'Cards',
//                               style: FlutterFlowTheme.of(context)
//                                   .bodyMedium
//                                   .override(
//                                     fontFamily: 'Quicksand',
//                                     color: FlutterFlowTheme.of(context)
//                                         .secondaryText,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         width: MediaQuery.of(context).size.width * 0.2,
//                         height: double.infinity,
//                         decoration: BoxDecoration(),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             FaIcon(
//                               FontAwesomeIcons.chartLine,
//                               color: FlutterFlowTheme.of(context).secondaryText,
//                               size: 24,
//                             ),
//                             Text(
//                               'Activity',
//                               style: FlutterFlowTheme.of(context)
//                                   .bodyMedium
//                                   .override(
//                                     fontFamily: 'Quicksand',
//                                     color: FlutterFlowTheme.of(context)
//                                         .secondaryText,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                             ),
//                           ],
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
