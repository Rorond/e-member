class redeemVoucherData {
  String redeemVoucherID;
  String salesID;
  String voucherTypeID;
  String redeemDate;
  int customerID;

  redeemVoucherData._(
      {this.redeemVoucherID = '',
      this.salesID = '',
      this.voucherTypeID = '',
      this.customerID = 0,
      this.redeemDate = ''});
  factory redeemVoucherData.fromJson(Map<String, dynamic> json) {
    return new redeemVoucherData._(
        redeemVoucherID: json["redeemVoucherID"] ?? "",
        salesID: json["salesID"] ?? "",
        voucherTypeID: json["voucherTypeID"] ?? "",
        customerID: json["customerID"] ?? 0,
        redeemDate: json["redeemDate"] ?? "");
  }

  static List<redeemVoucherData> fromJsonList(List list) {
    if (list == null) return [];
    return list.map((item) => redeemVoucherData.fromJson(item)).toList();
  }

  String redeemVoucherAsString() {
    return '#${this.redeemVoucherID} ${this.salesID}';
  }

  // ///custom comparing function to check if two users are equal
  // bool isEqual(UserModel model) {
  //   return this.id == model.id;
  // }

  ///custom comparing function to check if two users are equal
  bool isEqual(redeemVoucherData model) {
    return this.redeemVoucherID == model.redeemVoucherID;
  }

  @override
  String toString() => redeemVoucherID;
}
