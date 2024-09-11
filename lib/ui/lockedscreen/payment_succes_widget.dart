// import 'package:emembers/index.dart';
// import 'package:emembers/ui/home/homepage_widget.dart';

// import '/flutter_flow/flutter_flow_theme.dart';
// import '/flutter_flow/flutter_flow_util.dart';
// import '/flutter_flow/flutter_flow_widgets.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// import 'payment_succes_model.dart';
// export 'payment_succes_model.dart';

// class PaymentSuccesWidget extends StatefulWidget {
//   const PaymentSuccesWidget({Key? key}) : super(key: key);

//   @override
//   _PaymentSuccesWidgetState createState() => _PaymentSuccesWidgetState();
// }

// class _PaymentSuccesWidgetState extends State<PaymentSuccesWidget> {
//   late PaymentSuccesModel _model;

//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//     _model = createModel(context, () => PaymentSuccesModel());
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
//           child: ListView(
//             padding: EdgeInsets.zero,
//             scrollDirection: Axis.vertical,
//             children: [
//               Column(
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Container(
//                     width: MediaQuery.of(context).size.width * 0.85,
//                     height: MediaQuery.of(context).size.height * 1,
//                     decoration: BoxDecoration(
//                       color: FlutterFlowTheme.of(context).secondaryBackground,
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Padding(
//                           padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(8),
//                             child: Image.asset(
//                               'assets/images/rafiki.png',
//                               width: 150,
//                               height: 150,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         Align(
//                           alignment: AlignmentDirectional(0.00, 0.00),
//                           child: Container(
//                             width: 200,
//                             height: 50,
//                             decoration: BoxDecoration(
//                               color: FlutterFlowTheme.of(context)
//                                   .secondaryBackground,
//                             ),
//                             alignment: AlignmentDirectional(0.00, 0.00),
//                             child: Align(
//                               alignment: AlignmentDirectional(0.00, 0.00),
//                               child: Text(
//                                 'Payment Success',
//                                 textAlign: TextAlign.center,
//                                 style: FlutterFlowTheme.of(context)
//                                     .bodyMedium
//                                     .override(
//                                       fontFamily: 'Quicksand',
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Container(
//                           width: MediaQuery.of(context).size.width * 0.85,
//                           height: MediaQuery.of(context).size.height * 0.4,
//                           decoration: BoxDecoration(
//                             color: FlutterFlowTheme.of(context)
//                                 .secondaryBackground,
//                             boxShadow: [
//                               BoxShadow(
//                                 blurRadius: 4,
//                                 color: Color(0x33000000),
//                                 offset: Offset(0, 2),
//                               )
//                             ],
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                           child: ListView(
//                             padding: EdgeInsets.zero,
//                             scrollDirection: Axis.vertical,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsetsDirectional.fromSTEB(
//                                     12, 12, 12, 12),
//                                 child: Container(
//                                   width: 100,
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.35,
//                                   decoration: BoxDecoration(
//                                     color: FlutterFlowTheme.of(context)
//                                         .secondaryBackground,
//                                   ),
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.max,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Row(
//                                         mainAxisSize: MainAxisSize.max,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Column(
//                                             mainAxisSize: MainAxisSize.max,
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 'Booking ID',
//                                                 style:
//                                                     FlutterFlowTheme.of(context)
//                                                         .bodyMedium,
//                                               ),
//                                               Text(
//                                                 '220202-004',
//                                                 style:
//                                                     FlutterFlowTheme.of(context)
//                                                         .bodyMedium
//                                                         .override(
//                                                           fontFamily: 'Quicksand',
//                                                           fontSize: 16,
//                                                           fontWeight:
//                                                               FontWeight.w600,
//                                                         ),
//                                               ),
//                                             ],
//                                           ),
//                                           Column(
//                                             mainAxisSize: MainAxisSize.max,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 'Payment Date',
//                                                 style:
//                                                     FlutterFlowTheme.of(context)
//                                                         .bodyMedium,
//                                               ),
//                                               Text(
//                                                 '17 April 2022, 09:41',
//                                                 style:
//                                                     FlutterFlowTheme.of(context)
//                                                         .bodyMedium
//                                                         .override(
//                                                           fontFamily: 'Quicksand',
//                                                           fontSize: 14,
//                                                           fontWeight:
//                                                               FontWeight.w500,
//                                                         ),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         mainAxisSize: MainAxisSize.max,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             'Status',
//                                             style: FlutterFlowTheme.of(context)
//                                                 .bodyMedium,
//                                           ),
//                                           Text(
//                                             'Paid',
//                                             style: FlutterFlowTheme.of(context)
//                                                 .bodyMedium
//                                                 .override(
//                                                   fontFamily: 'Quicksand',
//                                                   color: FlutterFlowTheme.of(
//                                                           context)
//                                                       .primary,
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.w600,
//                                                 ),
//                                           ),
//                                         ],
//                                       ),
//                                       Divider(
//                                         thickness: 2,
//                                         color: FlutterFlowTheme.of(context)
//                                             .alternate,
//                                       ),
//                                       Row(
//                                         mainAxisSize: MainAxisSize.max,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Column(
//                                             mainAxisSize: MainAxisSize.max,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 'Membership Couple',
//                                                 style:
//                                                     FlutterFlowTheme.of(context)
//                                                         .bodyMedium
//                                                         .override(
//                                                           fontFamily: 'Quicksand',
//                                                           fontSize: 15,
//                                                           fontWeight:
//                                                               FontWeight.w500,
//                                                         ),
//                                               ),
//                                               Text(
//                                                 '1 Month',
//                                                 style:
//                                                     FlutterFlowTheme.of(context)
//                                                         .bodyMedium
//                                                         .override(
//                                                           fontFamily: 'Quicksand',
//                                                           fontSize: 16,
//                                                           fontWeight:
//                                                               FontWeight.w600,
//                                                         ),
//                                               ),
//                                             ],
//                                           ),
//                                           Column(
//                                             mainAxisSize: MainAxisSize.max,
//                                             children: [
//                                               Text(
//                                                 'IDR 808.000',
//                                                 style:
//                                                     FlutterFlowTheme.of(context)
//                                                         .bodyMedium
//                                                         .override(
//                                                           fontFamily: 'Quicksand',
//                                                           color: FlutterFlowTheme
//                                                                   .of(context)
//                                                               .primary,
//                                                           fontSize: 18,
//                                                           fontWeight:
//                                                               FontWeight.w600,
//                                                         ),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                       Divider(
//                                         thickness: 2,
//                                         color: FlutterFlowTheme.of(context)
//                                             .alternate,
//                                       ),
//                                       Row(
//                                         mainAxisSize: MainAxisSize.max,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             'Total Payment',
//                                             style: FlutterFlowTheme.of(context)
//                                                 .bodyMedium
//                                                 .override(
//                                                   fontFamily: 'Quicksand',
//                                                   fontSize: 18,
//                                                   fontWeight: FontWeight.w600,
//                                                 ),
//                                           ),
//                                           Text(
//                                             'IDR 808.000',
//                                             style: FlutterFlowTheme.of(context)
//                                                 .bodyMedium
//                                                 .override(
//                                                   fontFamily: 'Quicksand',
//                                                   color: FlutterFlowTheme.of(
//                                                           context)
//                                                       .primary,
//                                                   fontSize: 22,
//                                                   fontWeight: FontWeight.w600,
//                                                 ),
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
//                           padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
//                           child: FFButtonWidget(
//                             onPressed: () async {
//                               await Navigator.push(context,
//                                     MaterialPageRoute(builder: (context) =>
//                                         new HomepageWidget(),
//                                         ),
//                               );
//                             },
//                             text: 'Back to Home',
//                             options: FFButtonOptions(
//                               height: 46,
//                               padding:
//                                   EdgeInsetsDirectional.fromSTEB(60, 0, 60, 0),
//                               iconPadding:
//                                   EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
//                               color: FlutterFlowTheme.of(context).primary,
//                               textStyle: FlutterFlowTheme.of(context)
//                                   .titleSmall
//                                   .override(
//                                     fontFamily: 'Quicksand',
//                                     fontSize: 16,
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                               elevation: 3,
//                               borderSide: BorderSide(
//                                 color: Colors.transparent,
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
