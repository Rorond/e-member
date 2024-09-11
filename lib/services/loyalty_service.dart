import 'dart:convert';
import 'dart:io';

import 'package:emembers/constants.dart';
import 'package:emembers/data/models/membershipModel.dart';
import 'package:emembers/data/models/redeemVoucher.dart';
import 'package:emembers/data/models/tenants.dart';
import 'package:emembers/data/models/user.dart';
import 'package:emembers/data/models/viewVoucherHeader.dart';
import 'package:emembers/data/models/voucherType.dart';
import 'package:http/http.dart' as http;

class LoyaltyService {
  List<voucherTypeListData> voucherList = [];
  List<tenantListData> tenantData = [];
  List<viewVoucherHeaderData> voucherData = [];
  List<viewVoucherHeaderData> assignedVouchers = [];
  List<redeemVoucherData> dataListRedeemVoucher = [];

  var modelsRedeemVoucher;

  Future<List<tenantListData>> fetchTenantsData(ProjectList project) async {
    Uri uri = Uri.parse(Constants.apiLoyalty +
        '/loyalty/tenants?WhereClause=projectID=' +
        project.id.toString() +
        '&PageSize=999999&CurrentPageNumber=1&SortDirection=ASC&SortExpression=TenantName');
    final response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse.containsKey('entity')) {
        List<dynamic> dataset = jsonResponse['entity'];
        tenantData = tenantListData.fromJsonList(dataset);
      }
    }
    return tenantData;
  }

  Future<List<viewVoucherHeaderData>> fetchVoucherData(
    ProjectList project,
    List<tenantListData> tenantData,
  ) async {
    tenantData = tenantData;

    Uri uriVoucher = Uri.parse(Constants.apiLoyalty +
        "/loyalty/viewVoucherHeader?" +
        "WhereClause=" +
        Uri.encodeComponent("v.tenantID='${tenantData.first.tenantId}' "
            "AND validEnd > '${DateTime.now().toIso8601String()}' "
            "AND voucherQuantity > 0 "
            "AND ProjectID=${project.id}") +
        "&PageSize=999999&CurrentPageNumber=1&SortDirection=ASC&SortExpression=TenantName");
    final responseVoucher = await http.get(uriVoucher, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });

    if (responseVoucher.statusCode == 200) {
      Map<String, dynamic> jsonResponseVoucher =
          json.decode(responseVoucher.body);
      if (jsonResponseVoucher.containsKey('entity')) {
        List<dynamic> datasetVoucher = jsonResponseVoucher['entity'];

        voucherData = viewVoucherHeaderData.fromJsonList(datasetVoucher);
      }
    }
    return voucherData;
  }

  Future<List<voucherTypeListData>> fetchListVoucher(
    String tenantId,
    ProjectList project,
  ) async {
    tenantData = await fetchTenantsData(project);
    var modelVoucherType;
    Uri voucherTypeURL = Uri.parse(Constants.apiGateway +
        "/loyalty/voucherTypes?WhereClause=TenantID='$tenantId'&PageSize=999999&CurrentPageNumber=1&SortDirection=ASC&SortExpression=voucherTypeName");

    var responseVoucherType =
        await http.get(voucherTypeURL, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'POST, GET, OPTIONS, PUT, DELETE, HEAD',
      'Access-Control-Allow-Headers':
          'Origin, X-Requested-With, Content-Type, Accept',
      'Access-Control-Allow-Credentials': 'true'
    });

    print("Ini adalah Url" + voucherTypeURL.toString());
    
    if (responseVoucherType.statusCode == 200) {
      var dataVoucherType = jsonDecode(responseVoucherType.body);
      if (dataVoucherType["entity"] != null) {
        var dataset = dataVoucherType["entity"];
        modelVoucherType = voucherTypeListData.fromJsonList(dataset);
      }
    }

    if (modelVoucherType != null) {
      for (int i = 0; i < modelVoucherType.length; i++) {
        for (int j = 0; j < tenantData.length; j++) {
          if (modelVoucherType[i].tenantID.contains(tenantData[j].tenantId)) {
            voucherList.add(modelVoucherType[i]);
          }
        }
      }
    }

    return voucherList;
  }

  Future<List<viewVoucherHeaderData>> fetchReedemVoucher(
    User user,
    List<viewVoucherHeaderData> voucherData,
    List<voucherTypeListData> voucherList,
  ) async {
    voucherData = voucherData;
    dataListRedeemVoucher = dataListRedeemVoucher;
    voucherList = voucherList;

    Uri redeemVoucherURL = Uri.parse(Constants.apiGateway +
        "/loyalty/RedeemVouchers?WhereClause=customerID=" +
        user.userId.toString() +
        "&PageSize=999999&CurrentPageNumber=1&SortDirection=ASC&SortExpression=redeemDate");
    var responseRedeemVoucher =
        await http.get(redeemVoucherURL, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'POST, GET, OPTIONS, PUT, DELETE, HEAD',
      'Access-Control-Allow-Headers':
          'Origin, X-Requested-With, Content-Type, Accept',
      'Access-Control-Allow-Credentials': 'true'
    });
    if (responseRedeemVoucher.statusCode == 200) {
      print(responseRedeemVoucher.body);
      var data = jsonDecode(responseRedeemVoucher.body);
      if (data["entity"] != null) {
        var dataset = data["entity"];
        modelsRedeemVoucher = redeemVoucherData.fromJsonList(dataset);
      }
    }
    if (modelsRedeemVoucher != null) {
      dataListRedeemVoucher = [];
      for (int x = 0; x < modelsRedeemVoucher.length; x++) {
        for (int y = 0; y < voucherList.length; y++) {
          if (modelsRedeemVoucher[x]
              .voucherTypeID
              .contains(voucherList[y].voucherTypeID)) {
            dataListRedeemVoucher.add(modelsRedeemVoucher[x]);
          }
        }
      }
    }

    // JIKA VOUCHER NYA TIDAK BOLEH DUPLIKAT PAKAI YANG INI
    assignedVouchers = voucherData.where((voucher) {
      return dataListRedeemVoucher.any((redeemVoucher) =>
          redeemVoucher.voucherTypeID == voucher.voucherTypeID);
    }).toList();

    return assignedVouchers;
  }

  Future<bool> setRedeemVoucher(
      User user, viewVoucherHeaderData voucher) async {
    Map dataRedeemVoucher = {
      "voucherTypeID": voucher.voucherTypeID,
      "customerID": user.userId,
      "redeemDate": DateTime.now().toString(),
      "CreatedBy": user.userId.toString() + " - " + user.userName
    };
    String bodyRedeemVoucher = json.encode(dataRedeemVoucher);
    Uri urlRedeemVoucher =
        Uri.parse(Constants.apiGateway + "/loyalty/redeemVoucher");
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

  Future<List<redeemVoucherData>> getRedeemVoucher(User user) async {
    List<redeemVoucherData> result = [];

    Uri redeemVoucherURL = Uri.parse(Constants.apiGateway +
        "/loyalty/RedeemVouchers?WhereClause=customerID=" +
        user.userId.toString() +
        "&PageSize=999999&CurrentPageNumber=1&SortDirection=ASC&SortExpression=redeemDate");
    var responseRedeemVoucher =
        await http.get(redeemVoucherURL, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'POST, GET, OPTIONS, PUT, DELETE, HEAD',
      'Access-Control-Allow-Headers':
          'Origin, X-Requested-With, Content-Type, Accept',
      'Access-Control-Allow-Credentials': 'true'
    });
    if (responseRedeemVoucher.statusCode == 200) {
      print(responseRedeemVoucher.body);
      var data = jsonDecode(responseRedeemVoucher.body);
      if (data["entity"] != null) {
        var dataset = data["entity"];
        result = redeemVoucherData.fromJsonList(dataset);
      }
    }
    return result;
  }

  Future<bool> setRedeemVoucherUsage(
      User user, redeemVoucherData voucher) async {
    Map dataRedeemVoucher = {
      "RedeemVoucherID": voucher.redeemVoucherID,
      "SalesID": user.userId,
      "VoucherTypeID": voucher.redeemVoucherID,
      "IsUsed": true,
    };
    String bodyRedeemVoucher = json.encode(dataRedeemVoucher);
    Uri urlRedeemVoucher =
        Uri.parse(Constants.apiGateway + "/loyalty/redeemVoucher");
    var responseRedeemVoucher = await http.put(
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

  Future<bool> updateVoucherQuantity(
    User user,
    viewVoucherHeaderData voucher,
    String tenantId,
    ProjectList project,
  ) async {
    var result = await fetchListVoucher(tenantId, project);

    voucherList = result;

    int tempIndex = voucherList.indexWhere(
        (element) => element.voucherTypeID == voucher.voucherTypeID);
    Map dataVoucherType = {
      "voucherTypeID": voucher.voucherTypeID,
      "tenantID": voucherList[tempIndex].tenantID,
      "voucherTypeName": voucherList[tempIndex].voucherTypeName,
      "voucherTypeDescription": voucherList[tempIndex].voucherTypeDescription,
      "termsAndConditions": voucherList[tempIndex].termsAndConditions,
      "validFrom": voucherList[tempIndex].validFrom,
      "validEnd": voucherList[tempIndex].validEnd,
      "voucherRedeemType": voucherList[tempIndex].voucherRedeemType,
      "voucherMinimumTransaction":
          voucherList[tempIndex].voucherMinimumTransaction,
      "voucherAmount": voucherList[tempIndex].voucherAmount,
      "voucherMultiply": voucherList[tempIndex].voucherMultiply,
      "voucherStatus": "Active",
      "voucherQuantity": voucherList[tempIndex].voucherQuantity - 1,
      "ChangedBy": user.userId.toString() + " - " + user.userName
    };
    String bodyVoucherType = json.encode(dataVoucherType);
    Uri url = Uri.parse(Constants.apiGateway + "/loyalty/voucherType");
    var response = await http.put(
      url,
      body: bodyVoucherType,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'POST, GET, OPTIONS, PUT, DELETE, HEAD',
        'Access-Control-Allow-Headers':
            'Origin, X-Requested-With, Content-Type, Accept',
        'Access-Control-Allow-Credentials': 'true'
      },
    );

    if (response == 200) {
      return true;
    }
    return false;
  }
}
