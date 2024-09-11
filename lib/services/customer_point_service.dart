import 'dart:convert';
import 'dart:io';

import 'package:emembers/constants.dart';
import 'package:emembers/data/models/customer_point.dart';
import 'package:emembers/data/models/user.dart';
import 'package:http/http.dart' as http;

class CustomerPointService {
  Future<List<CustomerPoint>> fetchCustomerPoint(User user) async {
    List<CustomerPoint> result = [];
    Uri uri = Uri.parse(Constants.apiGateway +
        '/loyalty/CustomerPoints?WhereClause=CustomerID=' +
        user.userId.toString() +
        '&PageSize=999999&CurrentPageNumber=1&SortDirection=ASC&SortExpression=CustomerTotalPoint');
    final response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse.containsKey('entity')) {
        List<dynamic> dataset = jsonResponse['entity'];
        result = CustomerPoint.fromJsonList(dataset);
      }
    }
    return result;
  }

  Future<bool> setCustomerPoint(User user, CustomerPoint customerPoint) async {
    bool result = false;
    var entity = await fetchCustomerPoint(user);
    if (entity.isNotEmpty && entity.length > 0) {
      result = await updateCustomerPoint(user, customerPoint);
    } else {
      result = await createCustomerPoint(user, customerPoint);
    }
    return result;
  }

  Future<bool> createCustomerPoint(
      User user, CustomerPoint customerPoint) async {
    Map param = {
      "CustomerId": user.userId,
      "PaymentID": customerPoint.paymentId.toString(),
      "CustomerTotalPoint": customerPoint.customerTotalPoint,
    };
    String bodyRedeemVoucher = json.encode(param);
    Uri urlRedeemVoucher =
        Uri.parse(Constants.apiGateway + "/loyalty/CustomerPoints");
    var responseRedeemVoucher = await http.post(
      urlRedeemVoucher,
      body: bodyRedeemVoucher,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'POST, GET, OPTIONS, PUT, DELETE, HEAD',
        'Access-Control-Allow-Headers':
            'Origin, X-Requested-With, Content-Type, Accept',
        'Access-Control-Allow-Credentials': 'true'
      },
    );
    if (responseRedeemVoucher.statusCode == 200) {
      return true;
    }

    return false;
  }

  Future<bool> updateCustomerPoint(
    User user,
    CustomerPoint customerPoint,
  ) async {
    var customer = await fetchCustomerPoint(user);
    if (customer.isEmpty) {
      return false;
    }
    Map param = {
      "CustomerPointID": customer[0].customerPointId,
      "CustomerId": user.userId,
      "CustomerTotalPoint": customerPoint.customerTotalPoint,
      "PointMethod": customerPoint.pointMethod,
    };
    String bodyRedeemVoucher = json.encode(param);
    Uri urlRedeemVoucher =
        Uri.parse(Constants.apiLoyalty + "/loyalty/UpdateCustomerPoint");
    var responseRedeemVoucher = await http.post(
      urlRedeemVoucher,
      body: bodyRedeemVoucher,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'POST, GET, OPTIONS, PUT, DELETE, HEAD',
        'Access-Control-Allow-Headers':
            'Origin, X-Requested-With, Content-Type, Accept',
        'Access-Control-Allow-Credentials': 'true'
      },
    );
    if (responseRedeemVoucher.statusCode == 200) {
      return true;
    }

    return false;
  }
}
