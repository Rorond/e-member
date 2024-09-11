// import 'package:emembers/data/classes/auth.dart';
// import 'package:emembers/flutter_flow/flutter_flow_icon_button.dart';
// import 'package:emembers/flutter_flow/flutter_flow_theme.dart';
// import 'package:emembers/flutter_flow/flutter_flow_util.dart';
// import 'package:emembers/flutter_flow/flutter_flow_widgets.dart';
// import 'package:emembers/ui/signin/login_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:scoped_model/scoped_model.dart';

// Widget Appbar(BuildContext context) {
//   @override
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   return AppBar(
//     backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
//     automaticallyImplyLeading: false,
//     title: Container(
//       width: MediaQuery.of(context).size.width * 0.85,
//       height: 50.0,
//       decoration: BoxDecoration(),
//       child: Row(
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           Container(
//             width: MediaQuery.of(context).size.width * 0.425,
//             height: 50.0,
//             decoration: BoxDecoration(),
//             child: Row(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 FlutterFlowIconButton(
//                   borderRadius: 20.0,
//                   borderWidth: 1.0,
//                   buttonSize: 40.0,
//                   icon: FaIcon(
//                     FontAwesomeIcons.bars,
//                     color: FlutterFlowTheme.of(context).primaryText,
//                     size: 24.0,
//                   ),
//                   onPressed: () async {
//                     scaffoldKey.currentState!.openDrawer();
//                   },
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             width: MediaQuery.of(context).size.width * 0.425,
//             height: 50.0,
//             decoration: BoxDecoration(),
//             child: Row(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 FlutterFlowIconButton(
//                   borderRadius: 20.0,
//                   borderWidth: 1.0,
//                   buttonSize: 40.0,
//                   icon: FaIcon(
//                     FontAwesomeIcons.search,
//                     color: FlutterFlowTheme.of(context).primaryText,
//                     size: 24.0,
//                   ),
//                   onPressed: () {
//                     print('IconButton pressed ...');
//                   },
//                 ),
//                 FlutterFlowIconButton(
//                   borderRadius: 20.0,
//                   borderWidth: 1.0,
//                   buttonSize: 40.0,
//                   icon: FaIcon(
//                     FontAwesomeIcons.solidBell,
//                     color: FlutterFlowTheme.of(context).primaryText,
//                     size: 24.0,
//                   ),
//                   onPressed: () {
//                     print('IconButton pressed ...');
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//     actions: [],
//     centerTitle: true,
//     toolbarHeight: 50.0,
//     elevation: 0.0,
//   );
// }

// Widget drawer(BuildContext context) {
//   final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
//   return Drawer(
//     elevation: 16,
//     child: Column(
//       mainAxisSize: MainAxisSize.max,
//       children: [
//         Container(
//           width: double.infinity,
//           height: MediaQuery.of(context).size.height * 0.3,
//           decoration: BoxDecoration(
//             color: FlutterFlowTheme.of(context).bGatas,
//             image: DecorationImage(
//               fit: BoxFit.fill,
//               image: Image.asset(
//                 'assets/images/bgatas.png',
//               ).image,
//             ),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: 265,
//                 height: 155,
//                 decoration: BoxDecoration(
//                   color: FlutterFlowTheme.of(context).secondaryBackground,
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: Image.asset(
//                       'assets/images/bgkartu.png',
//                     ).image,
//                   ),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: 245,
//                       height: 75,
//                       decoration: BoxDecoration(),
//                       alignment: AlignmentDirectional(-1, 0),
//                       child: Container(
//                         width: 60,
//                         height: 60,
//                         clipBehavior: Clip.antiAlias,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                         ),
//                         child: Image.network(
//                           'https://picsum.photos/seed/543/600',
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       width: 245,
//                       height: 50,
//                       decoration: BoxDecoration(),
//                       alignment: AlignmentDirectional(-1, 0),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.max,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             '[nama]',
//                             style:
//                                 FlutterFlowTheme.of(context).bodyText1.override(
//                                       fontFamily: 'Open Sans',
//                                       color: FlutterFlowTheme.of(context)
//                                           .primaryBackground,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                           ),
//                           Text(
//                             '[id]',
//                             style:
//                                 FlutterFlowTheme.of(context).bodyText1.override(
//                                       fontFamily: 'Quicksand',
//                                       color: FlutterFlowTheme.of(context)
//                                           .primaryBackground,
//                                       fontSize: 11,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Container(
//           width: double.infinity,
//           height: MediaQuery.of(context).size.height * 0.7,
//           decoration: BoxDecoration(
//             color: FlutterFlowTheme.of(context).primaryBackground,
//           ),
//           child: ListView(
//             padding: EdgeInsets.zero,
//             shrinkWrap: true,
//             scrollDirection: Axis.vertical,
//             children: [
//               InkWell(
//                 onTap: () async {
//                   // await Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(
//                   //     builder: (context) => new ProfileWidget(),
//                   //   ),
//                   // );
//                 },
//                 child: Container(
//                   width: 100,
//                   height: 50,
//                   decoration: BoxDecoration(),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Padding(
//                         padding: EdgeInsetsDirectional.fromSTEB(30, 0, 25, 0),
//                         child: Container(
//                           width: MediaQuery.of(context).size.width * 0.11,
//                           height: MediaQuery.of(context).size.width * 0.11,
//                           decoration: BoxDecoration(
//                             color: FlutterFlowTheme.of(context).bGatas,
//                             shape: BoxShape.circle,
//                           ),
//                           alignment: AlignmentDirectional(0, 0),
//                           child: FaIcon(
//                             FontAwesomeIcons.addressCard,
//                             color: FlutterFlowTheme.of(context).primaryColor,
//                             size: 20,
//                           ),
//                         ),
//                       ),
//                       Text(
//                         'Profile',
//                         style: FlutterFlowTheme.of(context).bodyText1,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: () async {
//                   // await Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(
//                   //     builder: (context) => new PaidConfirmationWidget(),
//                   //   ),
//                   // );
//                 },
//                 child: Container(
//                   width: 100,
//                   height: 50,
//                   decoration: BoxDecoration(),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Padding(
//                         padding: EdgeInsetsDirectional.fromSTEB(30, 0, 25, 0),
//                         child: Container(
//                           width: MediaQuery.of(context).size.width * 0.11,
//                           height: MediaQuery.of(context).size.width * 0.11,
//                           decoration: BoxDecoration(
//                             color: FlutterFlowTheme.of(context).bGatas,
//                             shape: BoxShape.circle,
//                           ),
//                           alignment: AlignmentDirectional(0, 0),
//                           child: Icon(
//                             Icons.credit_card_rounded,
//                             color: FlutterFlowTheme.of(context).primaryColor,
//                             size: 20,
//                           ),
//                         ),
//                       ),
//                       Text(
//                         'Paid Confirmation',
//                         style: FlutterFlowTheme.of(context).bodyText1,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: () async {
//                   // await Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(
//                   //     builder: (context) => new ChangePasswordWidget(),
//                   //   ),
//                   // );
//                 },
//                 child: Container(
//                   width: 100,
//                   height: 50,
//                   decoration: BoxDecoration(),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Padding(
//                         padding: EdgeInsetsDirectional.fromSTEB(30, 0, 20, 0),
//                         child: Container(
//                           width: MediaQuery.of(context).size.width * 0.11,
//                           height: MediaQuery.of(context).size.width * 0.11,
//                           decoration: BoxDecoration(
//                             color: FlutterFlowTheme.of(context).bGatas,
//                             shape: BoxShape.circle,
//                           ),
//                           alignment: AlignmentDirectional(0, 0),
//                           child: Icon(
//                             Icons.lock_rounded,
//                             color: FlutterFlowTheme.of(context).primaryColor,
//                             size: 20,
//                           ),
//                         ),
//                       ),
//                       Text(
//                         'Change Password',
//                         style: FlutterFlowTheme.of(context).bodyText1,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: () async {
//                   // await Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(
//                   //     builder: (context) => new VerifySMLEmployeeWidget(),
//                   //   ),
//                   // );
//                 },
//                 child: Container(
//                   width: 100,
//                   height: 50,
//                   decoration: BoxDecoration(),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Padding(
//                         padding: EdgeInsetsDirectional.fromSTEB(30, 0, 20, 0),
//                         child: Container(
//                           width: MediaQuery.of(context).size.width * 0.11,
//                           height: MediaQuery.of(context).size.width * 0.11,
//                           decoration: BoxDecoration(
//                             color: FlutterFlowTheme.of(context).bGatas,
//                             shape: BoxShape.circle,
//                           ),
//                           alignment: AlignmentDirectional(0, 0),
//                           child: Icon(
//                             Icons.people_rounded,
//                             color: FlutterFlowTheme.of(context).primaryColor,
//                             size: 20,
//                           ),
//                         ),
//                       ),
//                       Text(
//                         'Verify SML Employee',
//                         style: FlutterFlowTheme.of(context).bodyText1,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: () async {
//                   // await Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(
//                   //     builder: (context) => new SettingsWidget(),
//                   //   ),
//                   // );
//                 },
//                 child: Container(
//                   width: 100,
//                   height: 50,
//                   decoration: BoxDecoration(),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Padding(
//                         padding: EdgeInsetsDirectional.fromSTEB(30, 0, 20, 0),
//                         child: Container(
//                           width: MediaQuery.of(context).size.width * 0.11,
//                           height: MediaQuery.of(context).size.width * 0.11,
//                           decoration: BoxDecoration(
//                             color: FlutterFlowTheme.of(context).bGatas,
//                             shape: BoxShape.circle,
//                           ),
//                           alignment: AlignmentDirectional(0, 0),
//                           child: Icon(
//                             Icons.settings_outlined,
//                             color: FlutterFlowTheme.of(context).primaryColor,
//                             size: 20,
//                           ),
//                         ),
//                       ),
//                       Text(
//                         'Setting',
//                         style: FlutterFlowTheme.of(context).bodyText1,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: () async {
//                   _auth.logout();
//                   //setState(() {});
//                   await Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => new LoginWidget(
//                         username: '',
//                       ),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   width: 100,
//                   height: 50,
//                   decoration: BoxDecoration(),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Padding(
//                         padding: EdgeInsetsDirectional.fromSTEB(30, 0, 20, 0),
//                         child: Container(
//                           width: MediaQuery.of(context).size.width * 0.11,
//                           height: MediaQuery.of(context).size.width * 0.11,
//                           decoration: BoxDecoration(
//                             color: FlutterFlowTheme.of(context).bGatas,
//                             shape: BoxShape.circle,
//                           ),
//                           alignment: AlignmentDirectional(0, 0),
//                           child: Icon(
//                             Icons.logout,
//                             color: FlutterFlowTheme.of(context).primaryColor,
//                             size: 20,
//                           ),
//                         ),
//                       ),
//                       Text(
//                         'Sign Out',
//                         style: FlutterFlowTheme.of(context).bodyText1,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }
