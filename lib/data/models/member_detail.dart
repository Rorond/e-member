class MemberDetail {
  final String bgAsset;
  final int membershipId;
  final String membershipName;
  final String validDate;
  final String balance;
  final String accountNumber;
  final String status;

  MemberDetail._(
      {required this.bgAsset,
      required this.membershipId,
      required this.membershipName,
      required this.accountNumber,
      required this.validDate,
      required this.status,
      required this.balance});

  factory MemberDetail.fromJson(Map<String, dynamic> json) {
    return new MemberDetail._(
      bgAsset: "assets/images/bgkartu.png",
      membershipId: json['membershipId'],
      membershipName: json['membershipName'].toString(),
      accountNumber:
          json['membershipId'].toString() + " " + json['id'].toString(),
      validDate: json['validTo'].toString(),
      balance: "0",
      status: json['status'].toString(),
    );
  }
}
