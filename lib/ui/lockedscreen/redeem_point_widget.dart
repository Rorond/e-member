// import 'package:emembers/ui/activity/history_page.dart';
// import 'package:emembers/ui/card/bank_card.dart';
// import 'package:emembers/ui/home/homepage_widget.dart';
// import 'package:emembers/ui/Transaction/transaction_widget.dart';
// import 'package:emembers/ui/menuLoyalty/voucher_point_widget.dart';
// import 'package:emembers/ui/scan/q_r_scan_widget.dart';

// import '/flutter_flow/flutter_flow_icon_button.dart';
// import '/flutter_flow/flutter_flow_theme.dart';
// import '/flutter_flow/flutter_flow_util.dart';
// import '/flutter_flow/flutter_flow_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// import 'redeem_point_model.dart';
// export 'redeem_point_model.dart';

// class RedeemPointWidget extends StatefulWidget {
//   const RedeemPointWidget({Key? key}) : super(key: key);

//   @override
//   _RedeemPointWidgetState createState() => _RedeemPointWidgetState();
// }

// class _RedeemPointWidgetState extends State<RedeemPointWidget> {
//   late RedeemPointModel _model;

//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//     _model = createModel(context, () => RedeemPointModel());
//   }

//   @override
//   void dispose() {
//     _model.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => _model.unfocusNode.canRequestFocus
//           ? FocusScope.of(context).requestFocus(_model.unfocusNode)
//           : FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(50),
//           child: AppBar(
//             backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
//             automaticallyImplyLeading: false,
//             title: Container(
//               width: MediaQuery.of(context).size.width * 0.85,
//               height: 50,
//               decoration: BoxDecoration(),
//               child: Row(
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Container(
//                     width: MediaQuery.of(context).size.width * 0.425,
//                     height: 50,
//                     decoration: BoxDecoration(),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         FlutterFlowIconButton(
//                           borderColor: Colors.transparent,
//                           borderRadius: 20,
//                           borderWidth: 1,
//                           buttonSize: 40,
//                           icon: FaIcon(
//                             FontAwesomeIcons.bars,
//                             color: FlutterFlowTheme.of(context).primaryText,
//                             size: 24,
//                           ),
//                           onPressed: () {
//                             print('IconButton pressed ...');
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: MediaQuery.of(context).size.width * 0.425,
//                     height: 50,
//                     decoration: BoxDecoration(),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         FlutterFlowIconButton(
//                           borderColor: Colors.transparent,
//                           borderRadius: 20,
//                           borderWidth: 1,
//                           buttonSize: 40,
//                           icon: Icon(
//                                   Icons.notifications_outlined,
//                             color: FlutterFlowTheme.of(context).primaryText,
//                             size: 32,
//                           ),
//                           onPressed: () {
//                             print('IconButton pressed ...');
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             actions: [],
//             centerTitle: true,
//             toolbarHeight: 50,
//             elevation: 0,
//           ),
//         ),
//         body: SafeArea(
//           top: true,
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height * 0.8,
//                 decoration: BoxDecoration(),
//                 child: ListView(
//                   padding: EdgeInsets.zero,
//                   scrollDirection: Axis.vertical,
//                   children: [
//                     Column(
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         Padding(
//                           padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
//                           child: Container(
//                             width: MediaQuery.of(context).size.width * 0.85,
//                             height: 175,
//                             decoration: BoxDecoration(),
//                             child: ListView(
//                               padding: EdgeInsets.fromLTRB(
//                                 0,
//                                 0,
//                                 0,
//                                 0,
//                               ),
//                               scrollDirection: Axis.horizontal,
//                               children: [
//                                 Container(
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.85,
//                                   height: 100,
//                                   decoration: BoxDecoration(
//                                     image: DecorationImage(
//                                       fit: BoxFit.cover,
//                                       image: Image.asset(
//                                         'assets/images/bgkartu.png',
//                                       ).image,
//                                     ),
//                                     shape: BoxShape.rectangle,
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.max,
//                                     children: [
//                                       Row(
//                                         mainAxisSize: MainAxisSize.max,
//                                         children: [
//                                           Padding(
//                                             padding:
//                                                 EdgeInsetsDirectional.fromSTEB(
//                                                     10, 10, 0, 0),
//                                             child: Row(
//                                               mainAxisSize: MainAxisSize.max,
//                                               children: [
//                                                 Icon(
//                                                   Icons.stars_outlined,
//                                                   color: Colors.white,
//                                                   size: 42,
//                                                 ),
//                                                 Padding(
//                                                   padding: EdgeInsetsDirectional
//                                                       .fromSTEB(15, 0, 0, 0),
//                                                   child: Text(
//                                                     '[nama_produk]',
//                                                     style: FlutterFlowTheme.of(
//                                                             context)
//                                                         .bodyLarge
//                                                         .override(
//                                                           fontFamily: 'Quicksand',
//                                                           color: Colors.white,
//                                                           fontWeight:
//                                                               FontWeight.w600,
//                                                         ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         mainAxisSize: MainAxisSize.max,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         children: [
//                                           Container(
//                                             width: 300,
//                                             height: 110,
//                                             decoration: BoxDecoration(),
//                                             alignment: AlignmentDirectional(
//                                                 0.00, 1.00),
//                                             child: Row(
//                                               mainAxisSize: MainAxisSize.max,
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.end,
//                                               children: [
//                                                 Padding(
//                                                   padding: EdgeInsetsDirectional
//                                                       .fromSTEB(10, 0, 0, 0),
//                                                   child: Column(
//                                                     mainAxisSize:
//                                                         MainAxisSize.max,
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .center,
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Text(
//                                                         'Discount',
//                                                         style: FlutterFlowTheme
//                                                                 .of(context)
//                                                             .bodyMedium
//                                                             .override(
//                                                               fontFamily:
//                                                                   'Quicksand',
//                                                               color:
//                                                                   Colors.white,
//                                                               fontSize: 18,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w600,
//                                                             ),
//                                                       ),
//                                                       Text(
//                                                         '15rb / ticket',
//                                                         style:
//                                                             FlutterFlowTheme.of(
//                                                                     context)
//                                                                 .titleSmall
//                                                                 .override(
//                                                                   fontFamily:
//                                                                       'Quicksand',
//                                                                   fontSize: 14,
//                                                                 ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 Column(
//                                                   mainAxisSize:
//                                                       MainAxisSize.max,
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.end,
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.center,
//                                                   children: [
//                                                     FFButtonWidget(
//                                                       onPressed: () {
//                                                         print(
//                                                             'Button pressed ...');
//                                                       },
//                                                       text: '+100Point',
//                                                       options: FFButtonOptions(
//                                                         height: 40,
//                                                         padding:
//                                                             EdgeInsetsDirectional
//                                                                 .fromSTEB(24, 0,
//                                                                     24, 0),
//                                                         iconPadding:
//                                                             EdgeInsetsDirectional
//                                                                 .fromSTEB(
//                                                                     0, 0, 0, 0),
//                                                         color: Colors.white,
//                                                         textStyle:
//                                                             FlutterFlowTheme.of(
//                                                                     context)
//                                                                 .titleSmall
//                                                                 .override(
//                                                                   fontFamily:
//                                                                       'Quicksand',
//                                                                   color: Color(
//                                                                       0xFFE20613),
//                                                                 ),
//                                                         elevation: 3,
//                                                         borderSide: BorderSide(
//                                                           color: Colors
//                                                               .transparent,
//                                                           width: 1,
//                                                         ),
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(8),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ].divide(SizedBox(width: 10)),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
//                           child: Container(
//                             width: MediaQuery.of(context).size.width * 0.85,
//                             height: MediaQuery.of(context).size.height * 0.4,
//                             decoration: BoxDecoration(
//                               color: FlutterFlowTheme.of(context)
//                                   .secondaryBackground,
//                             ),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.max,
//                               children: [
//                                 Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: [
//                                     Column(
//                                       mainAxisSize: MainAxisSize.max,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           'Overview',
//                                           style: FlutterFlowTheme.of(context)
//                                               .bodyMedium
//                                               .override(
//                                                 fontFamily: 'Quicksand',
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w500,
//                                               ),
//                                         ),
//                                         Text(
//                                           'Nikmati penawaran diskon disemua lokasi untuk \nsetiap penukaran point anda.',
//                                           style: FlutterFlowTheme.of(context)
//                                               .bodyMedium,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: [
//                                     Column(
//                                       mainAxisSize: MainAxisSize.max,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           'Cara Pemakaian',
//                                           style: FlutterFlowTheme.of(context)
//                                               .bodyMedium
//                                               .override(
//                                                 fontFamily: 'Quicksand',
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w500,
//                                               ),
//                                         ),
//                                         Text(
//                                           'Akses aplikasi e-members untuk menukarkan \npoint anda dengan potongan harga sampai \ndengan 15 ribu rupiah.',
//                                           style: FlutterFlowTheme.of(context)
//                                               .bodyMedium,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: [
//                                     Column(
//                                       mainAxisSize: MainAxisSize.max,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           'Cara Pemakaian',
//                                           style: FlutterFlowTheme.of(context)
//                                               .bodyMedium
//                                               .override(
//                                                 fontFamily: 'Quicksand',
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w500,
//                                               ),
//                                         ),
//                                         Text(
//                                           'Akses aplikasi e-members untuk menukarkan \npoint anda dengan potongan harga sampai \ndengan 15 ribu rupiah.',
//                                           style: FlutterFlowTheme.of(context)
//                                               .bodyMedium,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ].divide(SizedBox(height: 15)),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
//                           child: Container(
//                             width: MediaQuery.of(context).size.width * 0.85,
//                             height: 50,
//                             decoration: BoxDecoration(
//                               color: FlutterFlowTheme.of(context)
//                                   .secondaryBackground,
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.max,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Column(
//                                   mainAxisSize: MainAxisSize.max,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.keyboard_arrow_left,
//                                       color: FlutterFlowTheme.of(context)
//                                           .secondaryText,
//                                       size: 42,
//                                     ),
//                                   ],
//                                 ),
//                                 Column(
//                                   mainAxisSize: MainAxisSize.max,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     InkWell(
//                                       onTap: ()async {
//                                         await Navigator.push(context,
//                                         MaterialPageRoute(builder: (context) => new VoucherPointWidget()
//                                         ),
//                                         );
//                                       },
//                                       child: Text(
//                                       'Kembali',
//                                       textAlign: TextAlign.center,
//                                       style: FlutterFlowTheme.of(context)
//                                           .bodyMedium
//                                           .override(
//                                             fontFamily: 'Quicksand',
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                     ),
//                                     ),

//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width * 1.0,
//                 height: 80.0,
//                 decoration: BoxDecoration(
//                   color: FlutterFlowTheme.of(context).primaryBackground,
//                   boxShadow: [
//                     BoxShadow(
//                       blurRadius: 4.0,
//                       color: Color(0x33000000),
//                       offset: Offset(0.0, -4.0),
//                     )
//                   ],
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(0.0),
//                     bottomRight: Radius.circular(0.0),
//                     topLeft: Radius.circular(10.0),
//                     topRight: Radius.circular(10.0),
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: MediaQuery.of(context).size.width * 0.2,
//                       height: double.infinity,
//                       decoration: BoxDecoration(),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.home_filled,
//                             color: FlutterFlowTheme.of(context).secondaryText,
//                             size: 26.0,
//                           ),
//                           InkWell(
//                             onTap: ()async {
//                               await Navigator.push(context,
//                               MaterialPageRoute(builder: (context) => new HomepageWidget()
//                               ),
//                               );
//                             },
//                             child: Text(
//                             'Home',
//                             style: FlutterFlowTheme.of(context)
//                                 .bodyMedium
//                                 .override(
//                                   fontFamily: 'Quicksand',
//                                   color: FlutterFlowTheme.of(context).secondaryText,
//                                   fontSize: 15.0,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                           ),
//                           ),

//                         ],
//                       ),
//                     ),
//                     Container(
//                       width: MediaQuery.of(context).size.width * 0.2,
//                       height: double.infinity,
//                       decoration: BoxDecoration(),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.credit_card_rounded,
//                             color: FlutterFlowTheme.of(context).secondaryText,
//                             size: 26.0,
//                           ),
//                           InkWell(
//                             onTap: ()async {
//                               await Navigator.push(context,
//                               MaterialPageRoute(builder: (context) => new TransactionWidget()
//                               ),
//                               );
//                             },
//                             child: Text(
//                             'Transac',
//                             style: FlutterFlowTheme.of(context)
//                                 .bodyMedium
//                                 .override(
//                                   fontFamily: 'Quicksand',
//                                   color: FlutterFlowTheme.of(context)
//                                       .secondaryText,
//                                   fontSize: 15.0,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                           ),
//                           )

//                         ],
//                       ),
//                     ),
//                     Container(
//                       width: MediaQuery.of(context).size.width * 0.2,
//                       height: double.infinity,
//                       decoration: BoxDecoration(),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           FlutterFlowIconButton(
//                             borderRadius: 20.0,
//                             borderWidth: 1.0,
//                             buttonSize: 42.0,
//                             fillColor: Color(0xFF0644E2),
//                             icon: Icon(
//                               Icons.qr_code_scanner_rounded,
//                               color: FlutterFlowTheme.of(context)
//                                   .primaryBackground,
//                               size: 26.0,
//                             ),
//                             onPressed: () async {
//                                     await Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) =>
//                                             new QRScanWidget(),
//                                       ),
//                                     );
//                             },
//                           ),
//                           Text(
//                             'Check In',
//                             style: FlutterFlowTheme.of(context)
//                                 .bodyMedium
//                                 .override(
//                                   fontFamily: 'Quicksand',
//                                   color: FlutterFlowTheme.of(context)
//                                       .secondaryText,
//                                   fontSize: 18.0,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       width: MediaQuery.of(context).size.width * 0.2,
//                       height: double.infinity,
//                       decoration: BoxDecoration(),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.wallet_rounded,
//                             color: FlutterFlowTheme.of(context).secondaryText,
//                             size: 26.0,
//                           ),
//                           InkWell(
//                             // onTap: () async {
//                             //   await Navigator.push(context,
//                             //   MaterialPageRoute(builder: (context) => new BankCard(card: myCard,)
//                             //   ),
//                             //    );
//                             // },
//                             child: Text(
//                             'Cards',
//                             style: FlutterFlowTheme.of(context)
//                                 .bodyMedium
//                                 .override(
//                                   fontFamily: 'Quicksand',
//                                   color: FlutterFlowTheme.of(context)
//                                       .secondaryText,
//                                   fontSize: 15.0,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                           ),
//                           ),

//                         ],
//                       ),
//                     ),
//                     Container(
//                       width: MediaQuery.of(context).size.width * 0.2,
//                       height: double.infinity,
//                       decoration: BoxDecoration(),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           FaIcon(
//                             FontAwesomeIcons.chartLine,
//                             color: FlutterFlowTheme.of(context).secondaryText,
//                             size: 24.0,
//                           ),
//                           InkWell(
//                             onTap: () async{
//                               // await Navigator.push(context,
//                               // MaterialPageRoute(builder: (context) => new HistoryPage(key: UniqueKey(), user: widget.user,)
//                               // ),
//                               // );
//                             },
//                             child: Text(
//                             'Activity',
//                             style: FlutterFlowTheme.of(context)
//                                 .bodyMedium
//                                 .override(
//                                   fontFamily: 'Quicksand',
//                                   color: FlutterFlowTheme.of(context)
//                                       .secondaryText,
//                                   fontSize: 14.0,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                           ),
//                             ),

//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
