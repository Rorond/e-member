import 'dart:convert';

import 'package:emembers/data/models/viewVoucherHeader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataSharedPreferences {
  Future saveString(String name, String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(name, value);
  }

  Future saveInt(String name, int value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(name, value);
  }

  Future saveDouble(String name, double value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setDouble(name, value);
  }

  Future<String?> readString(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(value);
  }

  Future<int?> readInt(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(value);
  }

  Future<double?> readDouble(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getDouble(value);
  }

  Future removeData(value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(value);
  }

  Future clearData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  Future<bool> checkData(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(name);
  }

  Future<void> saveList(String name, List<String> list) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // Konversi list menjadi string JSON
    String listJson = jsonEncode(list);

    sharedPreferences.setString(name, listJson);
  }

  Future<List<String>> readList(String name) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? listJson = sharedPreferences.getString(name);

    if (listJson != null) {
      // Konversi string JSON menjadi list
      List<String> list = List<String>.from(jsonDecode(listJson));
      return list;
    } else {
      return [];
    }
  }

  Future saveAssignedVouchers(List<viewVoucherHeaderData> vouchers) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Konversi list ke JSON String
    List<String> jsonList =
        vouchers.map((voucher) => jsonEncode(voucher.toJson())).toList();

    // Simpan ke SharedPreferences
    await prefs.setStringList('assignedVouchers', jsonList);
  }

  Future<List<viewVoucherHeaderData>> getAssignedVouchers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Ambil data dari SharedPreferences
    List<String>? jsonList = prefs.getStringList('assignedVouchers');

    if (jsonList != null) {
      // Konversi JSON String kembali ke objek
      return jsonList
          .map((jsonString) =>
              viewVoucherHeaderData.fromJson(jsonDecode(jsonString)))
          .toList();
    } else {
      return [];
    }
  }

  Future<void> removeUsedVoucher(String voucherTypeID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Ambil data dari SharedPreferences
    List<String>? jsonList = prefs.getStringList('assignedVouchers');

    if (jsonList != null) {
      // Konversi JSON String kembali ke objek
      List<viewVoucherHeaderData> vouchers = jsonList
          .map((jsonString) =>
              viewVoucherHeaderData.fromJson(jsonDecode(jsonString)))
          .toList();

      // Hapus voucher berdasarkan voucherTypeID
      vouchers.removeWhere((voucher) => voucher.voucherTypeID == voucherTypeID);

      // Simpan kembali daftar yang sudah diperbarui
      List<String> updatedJsonList =
          vouchers.map((voucher) => jsonEncode(voucher.toJson())).toList();
      await prefs.setStringList('assignedVouchers', updatedJsonList);
    }
  }
}
