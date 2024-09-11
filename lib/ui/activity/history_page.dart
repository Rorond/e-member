import 'package:emembers/flutter_flow/flutter_flow_theme.dart';
import 'package:emembers/ui/home/homepage_widget.dart';
import 'package:flutter/material.dart';
import 'package:emembers/data/models/user.dart';
import 'package:emembers/data/web_client.dart';
import '../../../constants.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({required Key key, required this.user}) : super(key: key);
  final User user;
  @override
  HistoryPageState createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  final memberURL = Constants.apiGateway + "/GuestActivity/InquiryByGuestId";
  List histories = [];
  List<HistoryModel> historiesList = [];
  late TextEditingController controllerYear;
  String month = DateTime.now().month.toString();
  @override
  Widget build(BuildContext context) {
    // todo: implement build
    return new Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.black,
            ),
            onPressed: () {
              Navigator.pop(context, "/homepage");
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Text(
                "My Activity",
                style: ListTittleProfile,
              ),
              Spacer(flex: 2),
            ],
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            Navigator.pop(context);
            return false;
          },
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
//              height: 42.0,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 16.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.calendar_today),
                                  SizedBox(width: 8),
                                  Text(
                                    'Month',
                                    style: LogOutText,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: DropdownButton(
                                      items: getMonth(),
                                      hint: Text(month),
                                      onChanged: (newValue) {
                                        setState(() => month = newValue);
                                      },
                                      value: month,
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                          DateTime.now().year.toString(),
                                          style: LogOutText)),
                                  Padding(
                                    padding: EdgeInsets.only(left: 60.0),
                                    child: GestureDetector(
                                      onTapUp: (tapDetail) {},
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 2,
                                              color: Color(0x1A000000),
                                              offset: Offset(0, -2),
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                            color: Color(0x15000000),
                                            width: 1,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.search,
                                          size: 30,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: historiesList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _historyWidget(historiesList[index]);
                      }),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _historyWidget(HistoryModel history) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0, left: 15.0, right: 15.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Image.asset(
                  "assets/images/logo.png",
                  height: 40.0,
                  width: 40.0,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        history.name,
                        style: LogOutText,
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        history.description,
                        style: bodyText,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> navigateToHomePage(BuildContext context, User user) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomepageWidget(user: user)),
    );
    return false;
  }

  _fetchData() async {
    Uri uri = Uri.parse(memberURL +
        BaseUrlParams.baseUrlParams(widget.user.userId.toString()) +
        "&GuestId=" +
        widget.user.userId.toString());
    var _token = widget.user.token;
    var _data = await WebClient(User(token: _token)).get(uri);
    var datasets = _data["entity"];
    setState(() {
      histories = (datasets)
          .map((datasets) => new HistoryModel.fromJson(datasets))
          .toList();
      for (var i = 0; i < histories.length; i++) {
        historiesList.add(histories[i]);
      }
    });
  }

  @override
  initState() {
    controllerYear = TextEditingController(text: "");
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchData());
  }
}

List<DropdownMenuItem> getMonth() {
  final months = [
    DropdownMenuItem(value: "1", child: Text("Jan")),
    DropdownMenuItem(value: "2", child: Text("Feb")),
    DropdownMenuItem(value: "3", child: Text("Mar")),
    DropdownMenuItem(value: "4", child: Text("Apr")),
    DropdownMenuItem(value: "5", child: Text("May")),
    DropdownMenuItem(value: "6", child: Text("Jun")),
    DropdownMenuItem(value: "7", child: Text("Jul")),
    DropdownMenuItem(value: "8", child: Text("Aug")),
    DropdownMenuItem(value: "9", child: Text("Sep")),
    DropdownMenuItem(value: "10", child: Text("Oct")),
    DropdownMenuItem(value: "11", child: Text("Nov")),
    DropdownMenuItem(value: "12", child: Text("Dec")),
  ];
  return months;
}

class HistoryModel {
  final int id;
  final String name;
  final String description;
  final String activityDate;
  final String activityTime;
  final int guestId;
  final int projectId;
  final String projectName;
  final int venueId;
  final String venueName;
  final String status;
  final String attachment;

  HistoryModel._(
      {required this.id,
      required this.name,
      required this.description,
      required this.activityDate,
      required this.activityTime,
      required this.guestId,
      required this.projectId,
      required this.projectName,
      required this.venueId,
      required this.venueName,
      required this.status,
      required this.attachment});

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return new HistoryModel._(
      id: json['id'],
      name: json['name'].toString(),
      description: json['description'].toString(),
      activityDate: json['activityDate'],
      activityTime: json['activityTime'].toString(),
      guestId: json['guestId'],
      projectId: json['projectId'],
      projectName: json['projectName'].toString(),
      venueId: json['venueId'],
      venueName: json['venueName'].toString(),
      status: json['status'].toString(),
      attachment: json['attachment'].toString(),
    );
  }
}
