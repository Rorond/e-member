// import 'package:emembers/data/models/user.dart';
// import 'package:emembers/flutter_flow/flutter_flow_theme.dart';
// import 'package:emembers/flutter_flow/flutter_flow_util.dart';
// import 'package:emembers/ui/golf/checkout.dart';
// import 'package:flutter/material.dart';

// class TeeTimeBookingScreen extends StatefulWidget {
//   final User user;
//   final String imageUrl;
//   final String projectName;

//   TeeTimeBookingScreen({required this.imageUrl, required this.projectName, required this.user});

//   @override
//   _TeeTimeBookingScreenState createState() => _TeeTimeBookingScreenState();
// }

// class _TeeTimeBookingScreenState extends State<TeeTimeBookingScreen> {
//   String? selectedDate;
//   String selectedOption = 'Tee Time Book';
//   int selectedPlayers = 1;
//   String? selectedTeeTime;
//   int? selectedHole;
//   final double pricePerPlayer = 500000;

//   final List<Map<String, dynamic>> teeTimes = [
//     {'time': '09:00', 'isBooked': true},
//     {'time': '10:00', 'isBooked': false},
//     {'time': '11:00', 'isBooked': false},
//     {'time': '12:00', 'isBooked': true},
//     {'time': '13:00', 'isBooked': false},
//     {'time': '14:00', 'isBooked': true},
//     {'time': '15:00', 'isBooked': false},
//     {'time': '16:00', 'isBooked': false},
//   ];

//   double calculateTotalPrice() {
//     return selectedPlayers * pricePerPlayer;
//   }

//   @override
//   Widget build(BuildContext context) {
//     NumberFormat currencyFormat = NumberFormat.currency(locale: 'id', symbol: 'Rp.', decimalDigits: 0);
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Image.network(
//             widget.imageUrl,
//             height: 150,
//             width: double.infinity,
//             fit: BoxFit.cover,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Text(
//               widget.projectName,
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),
//           // Select Option
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         selectedOption = 'Tee Time Book';
//                       });
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor:Colors.transparent,
//                       foregroundColor: selectedOption == 'Tee Time Book'
//                           ? Colors.green
//                           : Colors.black,
//                       elevation: 0,
//                       shadowColor: Colors.transparent,
//                     ),
//                     //   backgroundColor: selectedOption == 'Tee Time Book'
//                     //       ? Colors.transparent
//                     //       // : Colors.grey[300],
//                     //       : Colors.transparent,
//                     //   foregroundColor: selectedOption == 'Tee Time Book'
//                     //       ? Colors.white
//                     //       : Colors.black,
//                     //   elevation: 0,
//                     //   shadowColor: Colors.transparent,
//                     // ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(
//                           Icons.calendar_today,
//                           // color: FlutterFlowTheme.of(context).primary,
//                           size: 24,
//                         ),
//                         SizedBox(height: 4),
//                         Text('Tee Time Book'),
//                         ]
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         selectedOption = 'Driving Range';
//                       });
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.transparent,
//                       foregroundColor: selectedOption == 'Driving Range'
//                           ? Colors.green
//                           : Colors.black,
//                       elevation: 0,
//                       shadowColor: Colors.transparent,
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(
//                           Icons.calendar_today,
//                           // color: FlutterFlowTheme.of(context).primary,'
//                           size: 24,
//                         ),
//                         SizedBox(height: 4),
//                         Text('Driving Range'),
//                         ]
//                     ),
//                     // child: Text('Driving Range'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Select Golf Hole
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: DropdownButtonFormField<int>(
//               value: selectedHole,
//               decoration: InputDecoration(
//                 labelText: 'Select Golf Hole',
//                 border: OutlineInputBorder(),
//               ),
//               items: List.generate(5, (index) {
//                 return DropdownMenuItem(
//                   value: index + 1,
//                   child: Text('Hole ${index + 1}'),
//                 );
//               }),
//               onChanged: (value) {
//                 setState(() {
//                   selectedHole = value!;
//                 });
//               },
//             ),
//           ),
//           // Select Number of Players
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: DropdownButtonFormField<int>(
//               value: selectedPlayers,
//               decoration: InputDecoration(
//                 labelText: 'Select Players',
//                 border: OutlineInputBorder(),
//               ),
//               items: List.generate(4, (index) {
//                 return DropdownMenuItem(
//                   value: index + 1,
//                   child: Text('${index + 1} Player'),
//                 );
//               }),
//               onChanged: (value) {
//                 setState(() {
//                   selectedPlayers = value!;
//                 });
//               },
//             ),
//           ),
//           // Select Date
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: GestureDetector(
//               onTap: () async {
//                 DateTime? pickedDate = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime.now(),
//                   lastDate: DateTime(2100),
//                 );
//                 if (pickedDate != null) {
//                   setState(() {
//                     selectedDate = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
//                   });
//                 }
//               },
//               child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: Colors.grey),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(selectedDate ?? 'Select Date'),
//                     Icon(Icons.calendar_today),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           // Select Tee Time
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: GridView.builder(
//               shrinkWrap: true,
//               itemCount: teeTimes.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 5,
//                 crossAxisSpacing: 5,
//                 mainAxisSpacing: 5,
//                 childAspectRatio: 1,
//               ),
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: teeTimes[index]['isBooked']
//                       ? null
//                       : () {
//                           setState(() {
//                             selectedTeeTime = teeTimes[index]['time'];
//                           });
//                         },
//                   child: Column(
//                     children: [
//                       Container(
//                         height: 60,
//                         width: 60,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(30),
//                           color: selectedTeeTime == teeTimes[index]['time']
//                                   ? Colors.grey
//                                   : teeTimes[index]['isBooked']
//                                       ? Colors.grey
//                                       : Colors.green.shade600,
//                           // color: Colors.green.shade600,
//                         ),
//                         child: Icon(
//                           Icons.golf_course,
//                           size: 30,
//                           color: selectedTeeTime == teeTimes[index]['time']
//                           ? Colors.orange
//                           : teeTimes[index]['isBooked']
//                                   ? Colors.green.shade200
//                                   : Colors.white,
//                         ),
//                       ),
//                       // Add some space between icon and text
//                       SizedBox(height: 4),
//                       Text(
//                         teeTimes[index]['time'],
//                         style: TextStyle(
//                           color: Colors.black, // Changed to black for better visibility
//                           fontWeight: FontWeight.bold,
//                           fontSize: 12,
//                         ),
//                         // child: Stack(
//                         //   alignment: Alignment.center,
//                         //   children: [
//                         //     Icon(
//                         //       Icons.golf_course,
//                         //       // Icons.sports_golf,
//                         //       size: 30,
//                         //       color: selectedTeeTime == teeTimes[index]['time']
//                         //           ? Colors.orange
//                         //           : teeTimes[index]['isBooked']
//                         //               ? Colors.green.shade200
//                         //               : Colors.white,
//                         //     ),
//                         //     Text(
//                         //       teeTimes[index]['time'],
//                         //       style: TextStyle(
//                         //         color: Colors.white,
//                         //         fontWeight: FontWeight.bold,
//                         //         fontSize: 12,
//                         //       ),
//                         //     ),
//                         //   ],
//                         // ),

//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//           // // Number of Players
//           // Padding(
//           //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           //   child: Column(
//           //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //     crossAxisAlignment: CrossAxisAlignment.start,
//           //     children: [
//           //       Text(
//           //         'Player Number :',
//           //         style: TextStyle(fontSize: 16),
//           //       ),
//           //       SizedBox(height: 5),
//           //       Row(
//           //         children: List.generate(4, (index) {
//           //           return Padding(
//           //             padding: const EdgeInsets.symmetric(horizontal: 4.0),
//           //             child: ElevatedButton(
//           //               onPressed: () {
//           //                 setState(() {
//           //                   selectedPlayers = index + 1;
//           //                 });
//           //               },
//           //               style: ElevatedButton.styleFrom(
//           //                 backgroundColor: selectedPlayers == index + 1
//           //                     ? Colors.green
//           //                     : Colors.grey[300],
//           //                 foregroundColor: selectedPlayers == index + 1
//           //                     ? Colors.white
//           //                     : Colors.black,
//           //               ),
//           //               child: Text((index + 1).toString()),
//           //             ),
//           //           );
//           //         }),
//           //       ),
//           //     ],
//           //   ),
//           // ),
//           // Booking Button
//          Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: ElevatedButton(
//             onPressed: selectedTeeTime != null ? () {
//               double totalPrice = calculateTotalPrice();
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => CheckoutScreen(
//                     selectedDate: selectedDate!,
//                     selectedTeeTime: selectedTeeTime!,
//                     numberOfPlayers: selectedPlayers,
//                     pricePerPlayer: pricePerPlayer,
//                     golfCourse: widget.projectName,
//                     location: 'Karawang',
//                     user: widget.user,
//                   ),
//                 ),
//               );
//             } : null,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: selectedTeeTime != null ? Colors.red : Colors.grey,
//               padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//             ),
//             child: Text(
//               '${currencyFormat.format(calculateTotalPrice())} Booking Now',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: selectedTeeTime != null ? Colors.white : Colors.grey,
//               ),
//             ),
//           ),
//         )

//         ],
//       ),
//     );
//   }
// }

// // class CheckoutScreen extends StatelessWidget {
// //   final String selectedDate;
// //   final String selectedTeeTime;
// //   final int numberOfPlayers;
// //   final double pricePerPlayer;
// //   final String golfCourse;
// //   final String location;

// //   CheckoutScreen({
// //     required this.selectedDate,
// //     required this.selectedTeeTime,
// //     required this.numberOfPlayers,
// //     required this.pricePerPlayer,
// //     required this.golfCourse,
// //     required this.location,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     double totalPrice = numberOfPlayers * pricePerPlayer;

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Checkout"),
// //         centerTitle: true,
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text("Course: $golfCourse"),
// //             Text("Location: $location"),
// //             Text("Date: $selectedDate"),
// //             Text("Tee Time: $selectedTeeTime"),
// //             Text("Players: $numberOfPlayers"),
// //             Spacer(),
// //             ElevatedButton(
// //               onPressed: () {
// //                 ScaffoldMessenger.of(context).showSnackBar(
// //                   SnackBar(
// //                     content: Text("Payment Successful!"),
// //                   ),
// //                 );
// //               },
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor: Colors.red,
// //                 padding: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
// //                 shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(8.0),
// //                 ),
// //               ),
// //               child: Text(
// //                 'Pay Rp ${totalPrice.toStringAsFixed(0)}',
// //                 style: TextStyle(fontSize: 16),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
