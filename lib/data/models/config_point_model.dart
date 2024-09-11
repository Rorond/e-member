class ConfigPointModel {
  String? configPointId;
  int? projectId;
  double? marginalAmount;
  String? createdBy;
  DateTime? createdDate;
  String? changedBy;
  DateTime? changedDate;

  ConfigPointModel({
    this.configPointId,
    this.projectId,
    this.marginalAmount,
    this.createdBy,
    this.createdDate,
    this.changedBy,
    this.changedDate,
  });

  factory ConfigPointModel.fromJson(Map<String, dynamic> json) {
    return ConfigPointModel(
      configPointId: json['configPointID'] as String?,
      projectId: json['projectID'] as int?,
      marginalAmount: json['marginalAmount'] as double?,
      createdBy: json['createdBy'] as String?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      changedBy: json['changedBy'] as String?,
      changedDate: json['changedDate'] == null
          ? null
          : DateTime.parse(json['changedDate'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'configPointID': configPointId,
        'projectID': projectId,
        'marginalAmount': marginalAmount,
        'createdBy': createdBy,
        'createdDate': createdDate?.toIso8601String(),
        'changedBy': changedBy,
        'changedDate': changedDate?.toIso8601String(),
      };

  static List<ConfigPointModel> fromJsonList(List<dynamic> list) {
    if (list == null) return [];
    return list.map((item) => ConfigPointModel.fromJson(item)).toList();
  }
}
