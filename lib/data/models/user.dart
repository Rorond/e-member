import 'package:json_annotation/json_annotation.dart';
import 'package:emembers/constants.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User(
      {this.token = '',
      this.userId = 0,
      this.employeeId = '',
      this.firstName = '',
      this.lastName = '',
      this.memberNo = '',
      this.emailAddress = '',
      this.isAuthenicated = false,
      this.isMember = false,
      this.isEmployee = false,
      this.totalPoint = '',
      this.imageUrl = '',
      this.imageBase64String,
      this.guestTypeId = 0,
      this.birthDate = '',
      this.birthPlace = '',
      this.genderId = 0,
      this.religionId = 0,
      this.bloodTypeId = 0,
      this.maritalStatusId = 0,
      this.npwp = '',
      this.ktp = '',
      this.sim = '',
      this.status = '',
      this.firebaseToken = '',
      this.userName = '',
      this.localization = '',
      this.avatar = '',
      this.evCode = '',
      this.evCodeExpired = '',
      this.evCodeStatus = ''});

  final int userId;
  final String employeeId;
  final bool isEmployee;
  @JsonKey(name: "firstName")
  final String firstName;
  final String lastName;
  String emailAddress;
  final String avatar;
  @JsonKey(name: "memberNo")
  final String memberNo;
  final bool isAuthenicated;
  final bool isMember;
  // final String totalPoint;
  late String totalPoint;
  String imageUrl;
  var imageBase64String;
  final int guestTypeId;
  String birthDate;
  String birthPlace;
  final int genderId;
  final int religionId;
  final int bloodTypeId;
  final int maritalStatusId;
  String npwp;
  String ktp;
  String sim;
  final String status;
  final String firebaseToken;
  final String userName;
  final String localization;
  @JsonKey(nullable: true)
  String token;
  final String evCode;
  final String evCodeExpired;
  String evCodeStatus;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return "$firstName".toString();
  }

  static void add(User user) {}
}
