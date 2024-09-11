// class viewVoucherHeaderData {
//   String voucherTypeID;
//   String imageURL;
//   String imageBase64String;
//   String voucherTypeName;
//   String tenantID;
//   String tenantName;
//   String validFrom;
//   String validEnd;
//   int voucherQuantity;
//   int requiredPoint;

//   viewVoucherHeaderData._(
//       {this.voucherTypeID = '',
//       this.imageURL = '',
//       this.imageBase64String = '',
//       this.voucherTypeName = '',
//       this.tenantID = '',
//       this.tenantName = '',
//       this.validFrom = '',
//       this.validEnd = '',
//       this.voucherQuantity = 0,
//       this.requiredPoint = 0,
//       });

//   factory viewVoucherHeaderData.fromJson(Map<String, dynamic> json) {
//     print(json);
//     print(json["voucherTypeID"]);
//     return new viewVoucherHeaderData._(
//         voucherTypeID: json["voucherTypeID"] ?? " ",
//         imageURL: json["imageURL"] ?? " ",
//         imageBase64String: json["imageBase64String"] ?? " ",
//         voucherTypeName: json["voucherTypeName"] ?? " ",
//         tenantID: json["tenantID"] ?? " ",
//         tenantName: json["tenantName"] ?? " ",
//         validFrom: json["validFrom"] ?? " ",
//         validEnd: json["validEnd"] ?? " ",
//         voucherQuantity: json["voucherQuantity"] ?? 0,
//         requiredPoint: json["requiredPoint"] ?? 0,
//         );
//   }
//   static List<viewVoucherHeaderData> fromJsonList(List list) {
//     if (list == null) return [];
//     return list.map((item) => viewVoucherHeaderData.fromJson(item)).toList();
//   }

//   String tenantAsString() {
//     return '#${this.voucherTypeID} ${this.voucherTypeName}';
//   }

//   bool isEqual(viewVoucherHeaderData model) {
//     return this.voucherTypeID == model.voucherTypeID;
//   }

//   @override
//   String toString() => voucherTypeName;
// }

class viewVoucherHeaderData {
  String voucherTypeID;
  String imageURL;
  String imageBase64String;
  String voucherTypeName;
  String tenantID;
  String tenantName;
  String validFrom;
  String validEnd;
  int voucherQuantity;
  int requiredPoint;

  viewVoucherHeaderData({
    required this.voucherTypeID,
    required this.imageURL,
    required this.imageBase64String,
    required this.voucherTypeName,
    required this.tenantID,
    required this.tenantName,
    required this.validFrom,
    required this.validEnd,
    required this.voucherQuantity,
    required this.requiredPoint,
  });

  // Additional named constructor if needed
  viewVoucherHeaderData._({
    this.voucherTypeID = '',
    this.imageURL = '',
    this.imageBase64String = '',
    this.voucherTypeName = '',
    this.tenantID = '',
    this.tenantName = '',
    this.validFrom = '',
    this.validEnd = '',
    this.voucherQuantity = 0,
    this.requiredPoint = 0,
  });

  factory viewVoucherHeaderData.fromJson(Map<String, dynamic> json) {
    return viewVoucherHeaderData(
      voucherTypeID: json["voucherTypeID"],
      imageURL: json["imageURL"] ?? "",
      imageBase64String: json["imageBase64String"] ?? "",
      voucherTypeName: json["voucherTypeName"],
      tenantID: json["tenantID"],
      tenantName: json["tenantName"],
      validFrom: json["validFrom"],
      validEnd: json["validEnd"],
      voucherQuantity: json["voucherQuantity"],
      requiredPoint: json["requiredPoint"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'voucherTypeID': voucherTypeID,
        'imageURL': imageURL,
        'imageBase64String': imageBase64String,
        'voucherTypeName': voucherTypeName,
        'tenantID': tenantID,
        'tenantName': tenantName,
        'validFrom': validFrom,
        'validEnd': validEnd,
        'voucherQuantity': voucherQuantity,
        'requiredPoint': requiredPoint,
      };

  static List<viewVoucherHeaderData> fromJsonList(List list) {
    if (list == null) return [];
    return list.map((item) => viewVoucherHeaderData.fromJson(item)).toList();
  }
}
