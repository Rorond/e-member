// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      token: json['token'].toString(),
      userId: json['id'],
      employeeId: json['employeeId'] ?? "",
      isEmployee: json['isEmployee'] ?? "",
      memberNo: json['memberNo'].toString() ?? "",
      firstName: json['firstName'].toString(),
      lastName: json['lastName'].toString(),
      emailAddress: json['emailAddress'].toString(),
      avatar: Constants.apiImage + "/Guest/" + json['imageUrl'].toString(),
      isAuthenicated: json['isAuthenicated'],
      isMember: json['isMember'],
      totalPoint: json['totalPoint'].toString(),
      imageUrl: json['imageUrl'] ?? "",
      imageBase64String: json['imageBase64String'] ?? "",
      guestTypeId: json['guestTypeId'],
      birthDate: json['birthDate'] ?? "",
      birthPlace: json['birthPlace'] ?? "",
      genderId: json['genderId'],
      religionId: json['religionId'],
      bloodTypeId: json['bloodTypeId'] ?? "",
      maritalStatusId: json['maritalStatusId'] ?? "",
      npwp: json['npwp'] ?? "",
      ktp: json['ktp'] ?? "",
      sim: json['sim'] ?? "",
      status: json['status'] ?? "",
      firebaseToken: json['firebaseToken'] ?? "",
      userName: json['userName'] ?? "",
      localization: json['localization'] ?? "",
      evCode: json['evCode'] ?? "",
      evCodeExpired: json['evCodeExpired'] ?? "",
      evCodeStatus: json['evCodeStatus'].toString());
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'token': instance.token,
      'id': instance.userId,
      'employeeId': instance.employeeId,
      'isEmployee': instance.isEmployee,
      'memberNo': instance.memberNo,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'emailAddress': instance.emailAddress,
      'avatar': instance.avatar,
      'isAuthenicated': instance.isAuthenicated,
      'isMember': instance.isMember,
      'totalPoint': instance.totalPoint,
      'imageUrl': instance.imageUrl,
      'imageBase64String': instance.imageBase64String,
      'guestTypeId': instance.guestTypeId,
      'birthDate': instance.birthDate,
      'birthPlace': instance.birthPlace,
      'genderId': instance.genderId,
      'religionId': instance.religionId,
      'bloodTypeId': instance.bloodTypeId,
      'maritalStatusId': instance.maritalStatusId,
      'npwp': instance.npwp,
      'ktp': instance.ktp,
      'sim': instance.sim,
      'status': instance.status,
      'firebaseToken': instance.firebaseToken,
      'userName': instance.userName,
      'localization': instance.localization,
      'evCode': instance.evCode,
      'evCodeExpired': instance.evCodeExpired,
      'evCodeStatus': instance.evCodeStatus
    };
