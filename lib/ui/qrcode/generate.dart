import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:emembers/data/models/user.dart';

import '../../../constants.dart';

class GenerateScreen extends StatefulWidget {
  final User user;
  GenerateScreen({required this.user});
  @override
  State<StatefulWidget> createState() => GenerateScreenState();
}

class GenerateScreenState extends State<GenerateScreen> {
  static const double _topSectionTopPadding = 50.0;
  static const double _topSectionBottomPadding = 20.0;
  //static const double _topSectionHeight = 50.0;

  GlobalKey globalKey = new GlobalKey();

  late String inputErrorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My QrID'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _captureAndSharePng,
          )
        ],
        backgroundColor: AppColors.primaryColor,
      ),
      body: _contentWidget(),
    );
  }

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary? boundary = globalKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary?;
      var image = await boundary!.toImage();
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);

      final channel = const MethodChannel('channel:me.alfian.share/share');
      channel.invokeMethod('shareFile', 'image.png');
    } catch (e) {
      print(e.toString());
    }
  }

  _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: _topSectionTopPadding,
              left: 20.0,
              right: 10.0,
              bottom: _topSectionBottomPadding,
            ),
            child: Container(
              margin: EdgeInsets.only(left: 16.0, right: 16.0),
              child: ListBody(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.card_membership),
                    title: Text(
                      'Membership No.',
                      textScaleFactor: AppColors.textScaleFactor,
                    ),
                    subtitle: Text(
                      widget.user.memberNo,
                      textScaleFactor: AppColors.textScaleFactor,
                    ),
                  ),
                  Divider(
                    height: 10.0,
                  ),
                  ListTile(
                    leading: Icon(Icons.account_box),
                    title: Text(
                      'Name',
                      textScaleFactor: AppColors.textScaleFactor,
                    ),
                    subtitle: Text(
                      widget.user.firstName + ' ' + widget.user.lastName,
                      textScaleFactor: AppColors.textScaleFactor,
                    ),
                  ),
                  Divider(height: 10.0),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 50.0),
                child: RepaintBoundary(
                  key: globalKey,
                  child: QrImageView(
                    data: widget.user.memberNo,
                    size: 0.5 * bodyHeight,
                    // onError: (ex) {
                    //   print("[QR] ERROR - $ex");
                    //   setState(() {
                    //     inputErrorText =
                    //         "Error! Maybe your input value is too long?";
                    //   });
                    // },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
