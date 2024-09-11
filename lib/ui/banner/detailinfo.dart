import 'package:flutter/material.dart';

// import 'package:native_widgets/native_widgets.dart';
import 'package:emembers/data/models/user.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:html/dom.dart' as dom;
import 'package:emembers/data/models/eventnewsModel.dart';
import '../../../constants.dart';

Color primaryColor = Color(0xff0074ff);

class NewseventsWidget extends PageRouteBuilder {
  final NewsEventModel eventnews;
  final User user;
  NewseventsWidget({required this.eventnews, required this.user})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return MembershipListPage(eventnews: eventnews, user: user);
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

class MembershipListPage extends StatefulWidget {
  final NewsEventModel eventnews;
  final User user;
  MembershipListPage({required this.eventnews, required this.user});

  @override
  MembershipListState createState() => MembershipListState();
}

class MembershipListState extends State<MembershipListPage> {
  final TextEditingController searchController = TextEditingController();
  bool isShowSearchButton = false;
  int selectedIndex = 0;
  bool isLoading = false;
  List membership = [];
  List searchResults = [];

  // _fetchProjectData() async {
  //   var contentURL = Constants.apiContent + "/Eventnews/"+ widget.eventnews.mainImages[0].url;
  //   final response = await http.get(contentURL,
  //     headers: {
  //       HttpHeaders.contentTypeHeader: 'application/json',
  //     }
  //   );
  //   if (response.statusCode == 200) {
  //     //var responseJson = json.decode(response.body);
  //     // var dataset = responseJson["entity"];
  //     // membership = (dataset)
  //     //     .map((dataset) => new MembershipList.fromJson(dataset))
  //     //     .toList();
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }

  void initState() {
    super.initState();
    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) {
    //       _fetchProjectData();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //appBar: _buildAppBar(),
      //bottomNavigationBar: _buildBottomBar(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    String eImage =
        Constants.apiContent + widget.eventnews.mainImages![0].url.toString();
    String eTitle = widget.eventnews.title;
    String eBody = widget.eventnews.body;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 2,
          child: new Container(
            width: MediaQuery.of(context).size.width,
            decoration: new BoxDecoration(
              color: AppColors.primaryColor,
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
                          color: AppColors.white,
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      Text(
                        '$eTitle',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 26.0,
                            color: AppColors.white),
                      ),
                    ],
                  )
                ]),
          ),
        ),
        Flexible(
          flex: 3,
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
              child: ListView(
                children: <Widget>[
                  Text(
                    '$eTitle',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: SingleChildScrollView(
                        child: HtmlWidget(
                      eBody,
                      //Optional parameters:
                      customStylesBuilder: (element) {
                        if (element.localName == 'p') {
                          return {
                            'font-size': '20px',
                            'line-height': '2',
                          };
                        }
                        if (element.localName == 'a') {
                          return {
                            'color': '#FF5722', // AppColors.primaryColor
                            'text-decoration': 'underline',
                          };
                        }
                        return null;
                      },
                      onTapUrl: (url) {
                        print("Opening $url...");
                        return true; // Return true to follow the link
                      },
                    )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
