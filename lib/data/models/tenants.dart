class tenantListData {
  String tenantId;
  int projectId;
  String tenantName;
  String tenantUsername;
  String tenantPassword;
  String tenantEmail;
  String tenantPhoneNumber;
  String imageURL;
  String imageBase64String;
  String tenantDescription;
  String CreatedBy;
  String CreatedDate;
  String ChangedBy;
  String ChangedDate;

  tenantListData({
    this.tenantId = '',
    this.projectId = 0,
    this.tenantName = '',
    this.tenantUsername = '',
    this.tenantPassword = '',
    this.tenantEmail = '',
    this.tenantPhoneNumber = '',
    this.imageURL = '',
    this.imageBase64String = '',
    this.tenantDescription = '',
    this.CreatedBy = '',
    this.CreatedDate = '',
    this.ChangedBy = '',
    this.ChangedDate = '',
  });

  factory tenantListData.fromJson(Map<String, dynamic> json) {
    return tenantListData(
      tenantId: json["tenantID"] ?? '',
      projectId: json["projectID"] ?? 0,
      tenantName: json["tenantName"] ?? '',
      tenantUsername: json["tenantUsername"] ?? '',
      tenantPassword: json["tenantPassword"] ?? '',
      tenantEmail: json["tenantEmail"] ?? '',
      tenantPhoneNumber: json["tenantPhoneNumber"] ?? '',
      imageURL: json["imageURL"] ?? '',
      imageBase64String: json["imageBase64String"] ?? '',
      tenantDescription: json["tenantDescription"] ?? '',
      CreatedBy: json["CreatedBy"] ?? '',
      CreatedDate: json["CreatedDate"] ?? '',
      ChangedBy: json["ChangedBy"] ?? '',
      ChangedDate: json["ChangedDate"] ?? '',
    );
  }

  static List<tenantListData> fromJsonList(List<dynamic> list) {
    if (list == null) return [];
    return list.map((item) => tenantListData.fromJson(item)).toList();
  }

  @override
  String toString() => tenantName;
}
