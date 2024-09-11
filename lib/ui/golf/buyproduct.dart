import 'package:emembers/constants.dart';
import 'package:emembers/data/models/membershipModel.dart';
import 'package:emembers/data/models/user.dart';
import 'package:emembers/flutter_flow/flutter_flow_theme.dart';
import 'package:emembers/flutter_flow/flutter_flow_util.dart';
import 'package:emembers/ui/golf/teetimebooking.dart';
import 'package:emembers/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class BuyProduct extends StatefulWidget {
  final ProjectList? project;
  final User user;

  BuyProduct({required this.project, required this.user});

  @override
  State<BuyProduct> createState() => _BuyProductState();
}

class _BuyProductState extends State<BuyProduct> {
  ScrollController? _controllerScroll;
  int selectedPlayers = 1;
  final double pricePerPlayer = 500000;
  final TextEditingController searchController = TextEditingController();
  bool isShowSearchButton = false;
  String? selectedDate;
  String? selectedTeeTime;
  int? selectedHole;

  final List<Map<String, dynamic>> project = [
    {'time': '09:00', 'isBooked': true},
    {'time': '10:00', 'isBooked': false},
    {'time': '11:00', 'isBooked': false},
    {'time': '12:00', 'isBooked': true},
    {'time': '13:00', 'isBooked': false},
    {'time': '14:00', 'isBooked': true},
    {'time': '15:00', 'isBooked': false},
    {'time': '16:00', 'isBooked': false},
  ];

  double calculateTotalPrice() {
    return selectedPlayers * pricePerPlayer;
  }

  void _searchTextChanged(String text) {
    isShowSearchButton = text.isNotEmpty;
    // searchResults = productList.where((i) {
    //   return i.name.toLowerCase().contains(text.toLowerCase());
    // }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarUI(),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget getAppBarUI() {
    String eImage = widget.project!.imageUrl;
    String eTitle = widget.project!.name;
    return PreferredSize(
      preferredSize: Size.fromHeight(120.0),
      child: AppBar(
        centerTitle: true,
        titleSpacing: 0.0,
        iconTheme: IconThemeData(size: 24, color: AppColors.black, fill: 0.1),
        flexibleSpace: Container(
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            image:
                DecorationImage(image: NetworkImage(eImage), fit: BoxFit.cover),
          ),
        ),
        backgroundColor: Colors.transparent,
        title: Text('$eTitle', style: clubname),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      child: Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          controller: _controllerScroll,
          slivers: [
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
              return Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        getSearchBarUI(),
                        getBookingDate(),
                        getproductteetime(),
                      ],
                    ),
                  ),
                ),
                // getListProduct(),
                EmembersButton(
                  title: '$selectedPlayers Items | Total : ' +
                      NumberFormat("#,##0", "id_ID")
                          .format(calculateTotalPrice()),
                  icon: Icons.shopping_basket,
                  iconSize: 20.0,
                  onPressed: () async {
                    double summary = calculateTotalPrice();
                    if (summary > 0) {
                      // Your existing booking logic
                    } else {
                      _alertMsg(context, "Please add the product.");
                    }
                  },
                ),
              ]);
            }, childCount: 1)),
          ],
        ),
      ),
    );
  }

  Widget getSearchBarUI() {
    return SizedBox(
      height: 72.0,
      width: MediaQuery.of(context).size.width - 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: 64,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffB9BABC),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(13.0),
                          bottomLeft: Radius.circular(13.0),
                          topLeft: Radius.circular(13.0),
                          topRight: Radius.circular(13.0),
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: TextField(
                                style: ListTittleProfile,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: 'Search for product',
                                  border: InputBorder.none,
                                  helperStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xffB9BABC),
                                  ),
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    letterSpacing: 0.2,
                                    color: Color(0xffB9BABC),
                                  ),
                                ),
                                controller: searchController,
                                onChanged: _searchTextChanged,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: Icon(Icons.search, color: Color(0xffB9BABC)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getBookingDate() {
    return Card(
      child: SizedBox(
        height: 70.0,
        width: MediaQuery.of(context).size.width - 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Padding(
            //   padding: EdgeInsets.only(left: 30, right: 30),
            //   child: DateTimePicker(
            //     type: DateTimePickerType.date,
            //     dateMask: 'dd MMM yyyy',
            //     controller: _controller,
            //     //initialValue: _initialValue,
            //     firstDate: initDate,
            //     lastDate: bookingLastDate,
            //     icon: Icon(Icons.event),
            //     cursorColor: AppColors.primaryColor,

            //     dateLabelText: 'Tanggal Kedatangan',
            //     onChanged: (val) => setState(() {
            //       valueChanged = val;

            //       sumCounter = 0;
            //       summary = 0;
            //       addproduct.clear();
            //       checkout.clear();
            //       adminFee.clear();
            //       // _fetchData();
            //     }),
            //     validator: (val) {
            //       setState(() => valueToValidate = val!);
            //       return null;
            //     },
            //     onSaved: (val) => setState(() => valueSaved = val!),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget getproductteetime() {
    NumberFormat currencyFormat =
        NumberFormat.currency(locale: 'id', symbol: 'Rp.', decimalDigits: 0);

    // Assuming a base price for the tee time (you can replace this with your actual logic)
    int basePrice = 100000; // Example base price

    int calculateTotalPrice() {
      // Assuming each player adds an additional cost to the total price
      int playerCost = selectedPlayers * 50000; // Example cost per player
      return basePrice + playerCost;
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Select Tee Time
          Container(
            margin: EdgeInsets.only(bottom: 8.0, left: 16.0, right: 16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: project.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    Color getTeeTimeColor() {
                      if (project[index]['isBooked']) {
                        return const Color.fromARGB(255, 237, 237, 237);
                      } else if (selectedTeeTime == project[index]['time']) {
                        return widget.project!.name == "Karawang"
                            ? Colors.green
                            : Colors.blue;
                      } else {
                        return Colors.white;
                      }
                    }

                    return GestureDetector(
                      onTap: project[index]['isBooked']
                          ? null
                          : () {
                              setState(() {
                                selectedTeeTime = project[index]['time'];
                              });
                            },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: project[index]['isBooked']
                              ? Colors.grey
                              : selectedTeeTime == project[index]['time']
                                  ? Colors.white
                                  : widget.project!.name == "Karawang"
                                      ? Colors.green
                                      : Colors.blue,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/golf_icon.png',
                              height: 24,
                              width: 24,
                              color: project[index]['isBooked']
                                  ? Colors.black
                                  : selectedTeeTime == project[index]['time']
                                      ? Colors.white
                                      : widget.project!.name == "Karawang"
                                          ? Colors.white
                                          : Colors.white,
                            ),
                            SizedBox(height: 2),
                            Text(
                              project[index]['time'],
                              style: TextStyle(
                                color: project[index]['isBooked']
                                    ? Colors.black
                                    : selectedTeeTime == project[index]['time']
                                        ? Colors.white
                                        : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          // Select Number of Players
          Container(
            margin: EdgeInsets.only(bottom: 8.0, left: 16.0, right: 16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: DropdownButtonFormField<int>(
                  value: selectedPlayers,
                  decoration: InputDecoration(
                    labelText: 'Number of Players',
                  ),
                  items: List.generate(4, (index) {
                    return DropdownMenuItem(
                      value: index + 1,
                      child: Text('${index + 1} Player'),
                    );
                  }),
                  onChanged: (value) {
                    setState(() {
                      selectedPlayers = value!;
                    });
                  },
                ),
              ),
            ),
          ),
          // Player Names
          Container(
            margin: EdgeInsets.only(bottom: 8.0, left: 16.0, right: 16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    selectedPlayers,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Player ${index + 1} Name',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Select Golf Hole
          Container(
            margin: EdgeInsets.only(bottom: 8.0, left: 16.0, right: 16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: DropdownButtonFormField<int>(
                  value: selectedHole,
                  decoration: InputDecoration(
                    labelText: 'Select Hole',
                  ),
                  items: List.generate(18, (index) {
                    return DropdownMenuItem(
                      value: index + 1,
                      child: Text('Hole ${index + 1}'),
                    );
                  }),
                  onChanged: (value) {
                    setState(() {
                      selectedHole = value!;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future _alertMsg(BuildContext context, String message) {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Info'),
        content: new Text('$message'),
        actions: <Widget>[
          new TextButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColors.primaryColor)),
            child: Text(
              'Ok',
              textScaleFactor: AppColors.textScaleFactor,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.of(context).pop(true),
          )
        ],
      ),
    );
  }
}
