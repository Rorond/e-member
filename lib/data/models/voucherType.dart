class voucherTypeListData {
  String voucherTypeID;
  String tenantID;
  String voucherTypeName;
  String voucherTypeDescription;
  String termsAndConditions;
  String validFrom;
  String validEnd;
  String voucherRedeemType;
  int voucherMinimumTransaction;
  int voucherAmount;
  int voucherMultiply;
  String voucherStatus;
  int voucherQuantity;
  String imageURL;
  String imageBase64String;
  String CreatedBy;
  String CreatedDate;
  String ChangedBy;
  String ChangedDate;

  voucherTypeListData._({
    this.voucherTypeID = '',
    this.tenantID = '',
    this.voucherTypeName = '',
    this.voucherTypeDescription = '',
    this.termsAndConditions = '',
    this.validFrom = '',
    this.validEnd = '',
    this.voucherRedeemType = '',
    this.voucherMinimumTransaction = 0,
    this.voucherAmount = 0,
    this.voucherMultiply = 0,
    this.voucherStatus = '',
    this.voucherQuantity = 0,
    this.imageURL = '',
    this.imageBase64String = '',
    this.CreatedBy = '',
    this.CreatedDate = '',
    this.ChangedBy = '',
    this.ChangedDate = '',
  });

  factory voucherTypeListData.fromJson(Map<String, dynamic> json) {
    return new voucherTypeListData._(
      voucherTypeID: json["voucherTypeID"] ?? " ",
      tenantID: json["tenantID"] ?? " ",
      voucherTypeName: json["voucherTypeName"] ?? " ",
      voucherTypeDescription: json["voucherTypeDescription"] ?? " ",
      termsAndConditions: json["termsAndConditions"] ?? " ",
      validFrom: json["validFrom"] ?? " ",
      validEnd: json["validEnd"] ?? " ",
      voucherRedeemType: json["voucherRedeemType"] ?? " ",
      voucherMinimumTransaction: json["voucherMinimumTransaction"] ?? " ",
      voucherAmount: json["voucherAmount"] ?? " ",
      voucherMultiply: json["voucherMultiply"] ?? " ",
      voucherStatus: json["voucherStatus"] ?? " ",
      voucherQuantity: json["voucherQuantity"] ?? 0,
      imageURL: json["imageURL"] ?? " ",
      imageBase64String: json["imageBase64String"] ?? " ",
      CreatedBy: json["CreatedBy"] ?? " ",
      CreatedDate: json["CreatedDate"] ?? " ",
      ChangedBy: json["ChangedBy"] ?? " ",
      ChangedDate: json["ChangedDate"] ?? " ",
    );
  }
  static List<voucherTypeListData> fromJsonList(List list) {
    if (list == null) return [];
    return list.map((item) => voucherTypeListData.fromJson(item)).toList();
  }

  String tenantAsString() {
    return '#${this.voucherTypeID} ${this.voucherTypeName}';
  }

  bool isEqual(voucherTypeListData model) {
    return this.voucherTypeID == model.voucherTypeID;
  }

  @override
  String toString() => voucherTypeName;
}
