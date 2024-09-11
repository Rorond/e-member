// import 'package:emembers/flutter_flow/flutter_flow_widgets.dart';
// import 'package:emembers/ui/clublist/membership_list.dart';
// import 'package:emembers/ui/lockedscreen/transaction_detail_widget.dart';

// import '/flutter_flow/flutter_flow_icon_button.dart';
// import '/flutter_flow/flutter_flow_theme.dart';
// import '/flutter_flow/flutter_flow_util.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import '../lockedscreen/membership_package_list_model.dart';
// export '../lockedscreen/membership_package_list_model.dart';

// class MembershipPackageListWidget extends StatefulWidget {
//   const MembershipPackageListWidget({Key? key}) : super(key: key);

//   @override
//   _MembershipPackageListWidgetState createState() =>
//       _MembershipPackageListWidgetState();
// }

// class _MembershipPackageListWidgetState
//     extends State<MembershipPackageListWidget> {
//   late MembershipPackageListModel _model;

//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//     _model = createModel(context, () => MembershipPackageListModel());

//     _model.textController ??= TextEditingController();
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
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(50.0),
//           child: AppBar(
//             backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
//             automaticallyImplyLeading: false,
//             title: Container(
//               width: MediaQuery.of(context).size.width * 0.95,
//               height: 50.0,
//               decoration: BoxDecoration(),
//               child: Stack(
//                 alignment: AlignmentDirectional(0.0, 0.0),
//                 children: [
//                   Row(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Container(
//                         width: MediaQuery.of(context).size.width * 0.425,
//                         height: 50.0,
//                         decoration: BoxDecoration(),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             FlutterFlowIconButton(
//                               borderRadius: 20.0,
//                               borderWidth: 1.0,
//                               buttonSize: 40.0,
//                               icon: Icon(
//                                 Icons.arrow_back_rounded,
//                                 color: FlutterFlowTheme.of(context).primaryText,
//                                 size: 24.0,
//                               ),
//                               // onPressed: () async {
//                               //   await Navigator.push(context,
//                               //   MaterialPageRoute(builder: (context) => MembershipWidget()
//                               //   ),
//                               //   );
//                               // },
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         width: MediaQuery.of(context).size.width * 0.425,
//                         height: 50.0,
//                         decoration: BoxDecoration(),
//                       ),
//                     ],
//                   ),
//                   Text(
//                     'Membership Package List',
//                     style: FlutterFlowTheme.of(context).bodyMedium.override(
//                           fontFamily: 'Quicksand',
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                           lineHeight: 2.0,
//                         ),
//                   ),
//                 ],
//               ),
//             ),
//             actions: [],
//             centerTitle: true,
//             toolbarHeight: 50.0,
//             elevation: 0.0,
//           ),
//         ),
//         body: SafeArea(
//           top: true,
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
//                   child: Container(
//                     width: MediaQuery.of(context).size.width * 0.85,
//                     height: 50.0,
//                     decoration: BoxDecoration(
//                       color: FlutterFlowTheme.of(context).primaryBackground,
//                       borderRadius: BorderRadius.circular(5.0),
//                       border: Border.all(
//                         color: Color(0xFFD9D9D9),
//                         width: 1.0,
//                       ),
//                     ),
//                     child: Padding(
//                       padding:
//                           EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
//                       child: TextFormField(
//                         controller: _model.textController,
//                         obscureText: false,
//                         decoration: InputDecoration(
//                           labelText: 'Search Membership',
//                           labelStyle:
//                               FlutterFlowTheme.of(context).labelMedium.override(
//                                     fontFamily: 'Quicksand',
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                           hintStyle:
//                               FlutterFlowTheme.of(context).labelMedium.override(
//                                     fontFamily: 'Quicksand',
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                           enabledBorder: InputBorder.none,
//                           focusedBorder: InputBorder.none,
//                           errorBorder: InputBorder.none,
//                           focusedErrorBorder: InputBorder.none,
//                           prefixIcon: Icon(
//                             Icons.search_rounded,
//                           ),
//                         ),
//                         style: FlutterFlowTheme.of(context).bodyMedium.override(
//                               fontFamily: 'Quicksand',
//                               fontWeight: FontWeight.w500,
//                             ),
//                         validator:
//                             _model.textControllerValidator.asValidator(context),
//                       ),
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
