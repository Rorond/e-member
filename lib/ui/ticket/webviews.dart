import 'dart:convert';
import 'package:emembers/data/models/customer_point.dart';
import 'package:emembers/services/customer_point_service.dart';

import '../home/homepage_widget.dart';
import 'package:flutter/material.dart';
import 'package:emembers/data/web_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:webview_flutter/webview_flutter.dart';
// #docregion platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import 'package:emembers/data/models/user.dart';
// import 'package:emembers/ui/lockedscreen/ticketing/transcationlist.dart';
// import 'package:native_widgets/native_widgets.dart';

// import 'package:emembers/ui/lockedscreen/ticketing/success1_view.dart';
import '../../../constants.dart';
import '../transaction/transcationlist.dart';
import 'success1_view.dart';

class WebViewPage extends StatefulWidget {
  WebViewPage(
      {Key? key,
      this.title,
      this.url,
      this.user,
      this.orderId,
      this.orderName,
      required this.totalPoint})
      : super(key: key);
  final String? title;
  final String? url;
  final User? user;
  final String? orderId;
  final String? orderName;
  final int totalPoint;

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebViewPage> {
  // Reference to webview controller
  late final WebViewController _controller;
  List callback = [];
  bool isLoading = true;
  String navTo = "home";

  Future<bool> navigateTo(BuildContext context, user, toNavigate) async {
    if (toNavigate == "trax") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Transaction(user: user)),
      );
    } else {
      Navigator.pop(context);
    }
    return true;
  }

  @override
  void initState() {
    super.initState();

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
            if (url.contains('payment-result?pa_res')) {
              navTo = "trax";
            }
            setState(() {
              isLoading = false;
            });
            // if (url.contains('dynamic-payment-page')) {
            //   String script =
            //       'window.addEventListener("message", receiveMessage, false);' +
            //           'function receiveMessage(event) { Toaser.postMessage(JSON.stringify(event.data)); };';
            //   _controller.runJavascript(script);
            // }
            if (url.contains('Notification')) {
              Navigator.push(context, TransactionRoute(widget.user!));
            }
            // if (url.contains('payment-result?pa_res')) {
            //   var _token = widget.user.token == "null" ? "" : widget.user.token;
            //   Uri paymentUrl = Uri.parse(Constants.apiGateway +
            //       "/Payment/Inquiry" +
            //       BaseUrlParams.baseUrlParams("4") +
            //       "&WhereClause=Payment.order_id='" +
            //       widget.orderId +
            //       "'&PageSize=10&CurrentPageNumber=1&SortDirection=DESC&SortExpression=process_date");

            //   var response =
            //       await WebClient(User(token: _token)).get(paymentUrl);
            //   bool responseData = response == null ? false : true;
            //   if (response["returnStatus"] == true && responseData == true) {
            //     var dataset = response["entity"];
            //     if (dataset.first["status"] == "settlement" ||
            //         dataset.first["status"] == "capture") {
            //       Uri memberURL = Uri.parse(
            //           Constants.apiGateway + "/Payment/UpdateOrderStatus");

            //       Map orderUpdate = {
            //         "id": widget.orderId,
            //         "name": widget.orderName,
            //         "status": "Paid"
            //       };
            //       var responseOrderUpdate = await WebClient(User(token: _token))
            //           .post(memberURL, orderUpdate);
            //       List payment = [
            //         {
            //           "status_code": "200",
            //           "status_message":
            //               "Success, Credit Card transaction is successful",
            //           "transaction_id": dataset.first["id"],
            //           "masked_card": "0000-0000-0000-0000-0000",
            //           "order_id": widget.orderId,
            //           "currency": dataset.first["currency_name"],
            //           "gross_amount": dataset.first["total_amount"],
            //           "payment_type": "credit_card",
            //           "transaction_time": dataset.first["process_date"],
            //           "transaction_status": "capture"
            //         }
            //       ];
            //       SharedPreferences.getInstance().then((prefs) {
            //         prefs.remove("orderId");
            //       });
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => new Success1View(
            //                 user: widget.user,
            //                 orderId: widget.orderId,
            //                 orderName: widget.orderName,
            //                 payment: payment)),
            //       );
            //     } else {
            //       // var _token = widget.user.token;
            //       Uri urlDelete = Uri.parse(Constants.apiGateway +
            //           "/Product/PromotionLog/" +
            //           widget.orderId);
            //       WebClient(User(token: _token)).delete(urlDelete);
            //       FocusScope.of(context).unfocus();
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => new Success1View(
            //                 user: widget.user,
            //                 orderId: widget.orderId,
            //                 orderName: widget.orderName,
            //                 payment: callback)),
            //       );
            //     }
            //     // print(dataset);
            //   } else {
            //     // var _token = widget.user.token;
            //     Uri urlDelete = Uri.parse(Constants.apiGateway +
            //         "/Product/PromotionLog/" +
            //         widget.orderId);
            //     WebClient(User(token: _token)).delete(urlDelete);
            //     FocusScope.of(context).unfocus();
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => new Success1View(
            //               user: widget.user,
            //               orderId: widget.orderId,
            //               orderName: widget.orderName,
            //               payment: callback)),
            //     );
            //   }
            // }
            if (url.contains('callback') || url.contains('result-completion')) {
              String script =
                  'window.addEventListener("message", receiveMessage, false);' +
                      'function receiveMessage(event) { Toaser.postMessage(JSON.stringify(event.data)); };';
              _controller.runJavaScript(script);
            }
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onHttpError: (HttpResponseError error) {
            debugPrint('Error occurred on page: ${error.response?.statusCode}');
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
          onHttpAuthRequest: (HttpAuthRequest request) {
            openDialog(request);
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaser',
        onMessageReceived: (JavaScriptMessage message) async {
          // if (message == null) {}
          String pageBody = message.message;
          print('page body: $pageBody');
          callback.add(json.decode(message.message));
          var _token = widget.user!.token == "null" ? "" : widget.user!.token;
          if (callback.first["status_code"] == "200") {
            Uri paymentUrl = Uri.parse(Constants.apiGateway +
                "/Payment/Inquiry" +
                BaseUrlParams.baseUrlParams("4") +
                "&WhereClause=Payment.order_id='" +
                widget.orderId +
                "'&PageSize=10&CurrentPageNumber=1&SortDirection=DESC&SortExpression=process_date");

            var response = await WebClient(User(token: _token)).get(paymentUrl);
            bool responseData = response == null ? false : true;
            if (response["returnStatus"] == true && responseData == true) {
              var dataset = response["entity"];
              if (dataset.first["status"] == "settlement" ||
                  dataset.first["status"] == "capture") {
                Uri memberURL = Uri.parse(
                    Constants.apiGateway + "/Payment/UpdateOrderStatus");

                Map orderUpdate = {
                  "id": widget.orderId,
                  "name": widget.orderName,
                  "status": "Paid"
                };

                WebClient(User(token: _token)).post(memberURL, orderUpdate);

                _updateCustomerPoint(widget.totalPoint, widget.orderId!);

                SharedPreferences.getInstance().then((prefs) {
                  prefs.remove("orderId");
                });
                FocusScope.of(context).unfocus();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => new Success1View(
                          user: widget.user!,
                          orderId: widget.orderId!,
                          orderName: widget.orderName!,
                          payment: callback)),
                );
              } else {
                Uri paymentUrl = Uri.parse(Constants.apiGateway +
                    "/Payment/Inquiry" +
                    BaseUrlParams.baseUrlParams("4") +
                    "&WhereClause=Payment.order_id='" +
                    widget.orderId +
                    "'&PageSize=10&CurrentPageNumber=1&SortDirection=DESC&SortExpression=process_date");

                var response =
                    await WebClient(User(token: _token)).get(paymentUrl);
                bool responseData = response == null ? false : true;
                if (response["returnStatus"] == true && responseData == true) {
                  var dataset = response["entity"];
                  if (dataset.first["status"] == "settlement" ||
                      dataset.first["status"] == "capture") {
                    Uri memberURL = Uri.parse(
                        Constants.apiGateway + "/Payment/UpdateOrderStatus");

                    Map orderUpdate = {
                      "id": widget.orderId,
                      "name": widget.orderName,
                      "status": "Paid"
                    };
                    WebClient(User(token: _token)).post(memberURL, orderUpdate);

                    _updateCustomerPoint(widget.totalPoint, widget.orderId!);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new Success1View(
                              user: widget.user!,
                              orderId: widget.orderId!,
                              orderName: widget.orderName!,
                              payment: callback)),
                    );
                    SharedPreferences.getInstance().then((prefs) {
                      prefs.remove("orderId");
                    });
                  } else {
                    // var _token = widget.user.token;
                    Uri urlDelete = Uri.parse(Constants.apiGateway +
                        "/Product/PromotionLog/" +
                        widget.orderId);
                    WebClient(User(token: _token)).delete(urlDelete);
                    FocusScope.of(context).unfocus();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new Success1View(
                              user: widget.user!,
                              orderId: widget.orderId!,
                              orderName: widget.orderName!,
                              payment: callback)),
                    );
                  }
                  // print(dataset);
                } else {
                  // var _token = widget.user.token;
                  Uri urlDelete = Uri.parse(Constants.apiGateway +
                      "/Product/PromotionLog/" +
                      widget.orderId);
                  WebClient(User(token: _token)).delete(urlDelete);
                  FocusScope.of(context).unfocus();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new Success1View(
                            user: widget.user!,
                            orderId: widget.orderId!,
                            orderName: widget.orderName!,
                            payment: callback)),
                  );
                }
              }
            }
          } else {
            // var _token = widget.user.token;
            Uri urlDelete = Uri.parse(Constants.apiGateway +
                "/Product/PromotionLog/" +
                widget.orderId);
            WebClient(User(token: _token)).delete(urlDelete);
            FocusScope.of(context).unfocus();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => new Success1View(
                      user: widget.user!,
                      orderId: widget.orderId!,
                      orderName: widget.orderName!,
                      payment: callback)),
            );
          }
        },
      )
      ..loadRequest(Uri.parse('https://flutter.dev'));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  _updateCustomerPoint(int TotalPoint, String paymentId) async {
    CustomerPoint customerPoint = CustomerPoint();
    customerPoint.pointMethod = "Plus";
    customerPoint.customerId = widget.user!.userId;
    customerPoint.customerTotalPoint = TotalPoint;
    customerPoint.paymentId = paymentId;

    CustomerPointService().setCustomerPoint(widget.user!, customerPoint);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title!),
        ),
        body: PopScope(
          canPop: false, //It should be false to work
          onPopInvokedWithResult: (bool didPop, Object? result) {
            if (didPop) {
              return;
            }
            navigateTo(context, widget.user, navTo);
          },
          child: Stack(children: <Widget>[
            WebViewWidget(
              controller: _controller,
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : Stack(),
          ]),
        ));
  }

  Future<void> openDialog(HttpAuthRequest httpRequest) async {
    final TextEditingController usernameTextController =
        TextEditingController();
    final TextEditingController passwordTextController =
        TextEditingController();

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${httpRequest.host}: ${httpRequest.realm ?? '-'}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(labelText: 'Username'),
                  autofocus: true,
                  controller: usernameTextController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  controller: passwordTextController,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            // Explicitly cancel the request on iOS as the OS does not emit new
            // requests when a previous request is pending.
            TextButton(
              onPressed: () {
                httpRequest.onCancel();
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                httpRequest.onProceed(
                  WebViewCredential(
                    user: usernameTextController.text,
                    password: passwordTextController.text,
                  ),
                );
                Navigator.of(context).pop();
              },
              child: const Text('Authenticate'),
            ),
          ],
        );
      },
    );
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls({super.key, required this.webViewController});

  final WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () async {
            if (await webViewController.canGoBack()) {
              await webViewController.goBack();
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No back history item')),
                );
              }
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () async {
            if (await webViewController.canGoForward()) {
              await webViewController.goForward();
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No forward history item')),
                );
              }
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.replay),
          onPressed: () => webViewController.reload(),
        ),
      ],
    );
  }
}
