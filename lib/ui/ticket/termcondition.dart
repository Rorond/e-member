import 'dart:io';
import 'dart:convert';
import 'package:emembers/constants.dart';
import 'package:emembers/flutter_flow/flutter_flow_theme.dart';
import 'package:emembers/ui/golf/golfcth.dart';
import 'package:emembers/ui/golf/teetimebooking.dart';
import 'package:emembers/ui/ticket/checkout.dart';
import 'package:emembers/ui/ticket/ticketing_widget.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as htmlParser;
import 'package:flutter/material.dart';
// import 'package:native_widgets/native_widgets.dart';
import 'package:emembers/data/models/user.dart';
import 'package:emembers/data/models/membershipModel.dart';
import 'package:emembers/data/models/termconditionModel.dart';

Color primaryColor = Color(0xff0074ff);

class TermConditionRoute extends PageRouteBuilder {
  final ProjectList project;
  final User user;
  final String img;
  TermConditionRoute(
      {required this.project, required this.user, required this.img})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return TermConditionPage(project: project, user: user, img: img);
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: new Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: new SlideTransition(
                position: new Tween<Offset>(
                  begin: Offset.zero,
                  end: const Offset(-1.0, 0.0),
                ).animate(secondaryAnimation),
                child: child,
              ),
            );
          },
        );
}

class TermConditionPage extends StatefulWidget {
  final ProjectList project;
  final User user;
  final String img;
  TermConditionPage(
      {required this.project, required this.user, required this.img});

  @override
  TermConditionState createState() => TermConditionState();
}

class TermConditionState extends State<TermConditionPage> {
  final TextEditingController searchController = TextEditingController();
  bool isShowSearchButton = false;
  int selectedIndex = 0;
  bool isLoading = false;

  List tcList = [];
  List<TermconditionModel> tc = [];
  List searchResults = [];
  late String termContent;

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    Uri uriTC = Uri.parse(Constants.apiContent +
        "/termconditions?projectid=" +
        widget.project.id.toString() +
        "&status=true");
    final responseTC = await http.get(uriTC, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    if (responseTC.statusCode == 200) {
      var responseJsonProduct = json.decode(responseTC.body);
      var datasetProduct = responseJsonProduct;
      tcList = (datasetProduct)
          .map((dataset) => new TermconditionModel.fromJson(dataset))
          .toList();
      for (var i = 0; i < tcList.length; i++) {
        tc.add(tcList[i]);
      }
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  bool _isButtonDisabled = true;
  bool _agreedToTOS = false;
  void _setAgreedToTOS(bool? newValue) {
    setState(() {
      _agreedToTOS = newValue ?? false;
      _isButtonDisabled = _agreedToTOS == true ? false : true;
    });
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Center(
              child: _buildBody(context),
            ),
    );
  }

  Widget _buildBody(BuildContext context) {
    String eImage = widget.img;
    String eTitle = tc.length > 0 ? tc.last.title : '';
    // String eBody = tc.last.termcondition;
    String eBodyImg = tc.length > 0
        ? Constants.apiContent +
            tc.last.image.url +
            "?v=" +
            DateTime.now().toString()
        : '';
    String eAgreement = tc.length > 0 ? tc.last.agreement : '';
    ScrollController _scrollController = new ScrollController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 2,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: new BoxDecoration(
              color: AppColors.backgroundLight,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              image: DecorationImage(
                  image: NetworkImage(eImage), fit: BoxFit.cover),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 85)),
                      IconButton(
                          icon: Icon(Icons.arrow_back),
                          color: AppColors.black,
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      Spacer(),
                      Text('$eTitle', style: ListTittleProfile),
                      Spacer(
                        flex: 2,
                      )
                    ],
                  )
                ]),
          ),
        ),
        Flexible(
          flex: 4,
          child: ListView(
              controller: _scrollController,
              reverse: true,
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.topCenter,
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        image: NetworkImage(eBodyImg), fit: BoxFit.fitWidth),
                  ),
                ),
              ]),
        ),
        Flexible(
          flex: 2,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 65,
                  color: Colors.white,
                  child: Checkbox(
                    value: _agreedToTOS,
                    onChanged: _setAgreedToTOS,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 75,
                  color: Colors.white,
                  child: GestureDetector(
                    onTap: () => _setAgreedToTOS(!_agreedToTOS),
                    child: HtmlWidget(
                      '''$eAgreement''',
                      renderMode: RenderMode.listView,
                      // set the default styling for text
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: _isButtonDisabled
                  ? MaterialStateProperty.all(AppColors.grey)
                  : MaterialStateProperty.all(AppColors.primaryColor),
            ),
            child: Text(
              'Next',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            onPressed: _isButtonDisabled
                ? null
                : () {
                    if (widget.project.id == 4) {
                      Navigator.push(
                        context,
                        ProductGolfRoute(
                          project: widget.project,
                          user: widget.user,
                          img: widget.img,
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        ProductListRoute(
                          project: widget.project,
                          user: widget.user,
                          img: widget.img,
                        ),
                      );
                    }
                  },
          ),
        ),
      ],
    );
  }
}
