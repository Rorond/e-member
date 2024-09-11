class CustomerPoint {
  String? customerPointId;
  dynamic paymentId;
  int? customerId;
  int? customerTotalPoint;
  dynamic pointMethod;
  dynamic createdBy;
  DateTime? createdDate;
  dynamic changedBy;
  DateTime? changedDate;

  CustomerPoint({
    this.customerPointId,
    this.paymentId,
    this.customerId,
    this.customerTotalPoint,
    this.pointMethod,
    this.createdBy,
    this.createdDate,
    this.changedBy,
    this.changedDate,
  });

  factory CustomerPoint.fromJson(Map<String, dynamic> json) => CustomerPoint(
        customerPointId: json['customerPointID'] as String?,
        paymentId: json['paymentID'] as dynamic,
        customerId: json['customerID'] as int?,
        customerTotalPoint: json['customerTotalPoint'] as int?,
        pointMethod: json['pointMethod'] as dynamic,
        createdBy: json['createdBy'] as dynamic,
        createdDate: json['createdDate'] == null
            ? null
            : DateTime.parse(json['createdDate'] as String),
        changedBy: json['changedBy'] as dynamic,
        changedDate: json['changedDate'] == null
            ? null
            : DateTime.parse(json['changedDate'] as String),
      );

  Map<String, dynamic> toJson() => {
        'customerPointID': customerPointId,
        'paymentID': paymentId,
        'customerID': customerId,
        'customerTotalPoint': customerTotalPoint,
        'pointMethod': pointMethod,
        'createdBy': createdBy,
        'createdDate': createdDate?.toIso8601String(),
        'changedBy': changedBy,
        'changedDate': changedDate?.toIso8601String(),
      };

  static List<CustomerPoint> fromJsonList(List<dynamic> list) {
    if (list == null) return [];
    return list.map((item) => CustomerPoint.fromJson(item)).toList();
  }
}
