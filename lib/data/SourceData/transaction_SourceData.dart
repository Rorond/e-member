// import 'dart:convert';
// import 'dart:io';

// import 'package:emembers/data/models/transactionModel.dart';
// import 'package:emembers/data/models/user.dart';
// import 'package:emembers/data/web_client.dart';

// import '../../constants.dart';
// import '../../ui/lockedscreen/transaction_model.dart';
// import 'package:http/http.dart' as http;

// class TransactionSourceData {
//   List<TransactionModel> transactionList = [];

//   get memberURL => null;

//   Future<List<TransactionModel>?> fetchData(User user) async {

//   Uri uri = Uri.parse(memberURL +
//         BaseUrlParams.baseUrlParams(user.userId.toString()) +
//         "&WhereClause=status='Paid' AND email='" +
//         user.emailAddress +
//         "' Order By booking_date DESC");
//     var _token = user.token;
//     var response = await WebClient(User(token: _token)).get(uri);
//     transactionList = TransactionModel.fromJson(response) as List<TransactionModel>;

//   return transactionList;
// }

// }

// // class TransactionSourceData {
// //   List<TransactionModel> transactionList =[];

// //   Future<List<TransactionModel>?> fetchData() async {

// //   Uri uri = Uri.parse(memberURL +
// //         BaseUrlParams.baseUrlParams(widget.user.userId.toString()) +
// //         "&WhereClause=status='Paid' AND email='" +
// //         widget.user.emailAddress +
// //         "' Order By booking_date DESC");
// //     var _token = widget.user.token;
// //     var response = await WebClient(User(token: _token)).get(uri);
// //     transactionList = TransactionModel.fromJson(response) as List<TransactionModel>;

// //   }
// // }
