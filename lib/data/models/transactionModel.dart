// To parse this JSON data, do
//
//     final transactionModel = transactionModelFromJson(jsonString);

import 'dart:convert';

TransactionModel transactionModelFromJson(String str) =>
    TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) =>
    json.encode(data.toJson());

class TransactionModel {
  TransactionModel({
    this.errors,
    this.totalPages,
    this.totalRows,
    this.pageSize,
    this.isAuthenticated,
    this.entity,
    this.token,
    this.returnStatus,
    this.returnMessage,
  });

  Errors? errors;
  int? totalPages;
  int? totalRows;
  int? pageSize;
  bool? isAuthenticated;
  List<Entity>? entity;
  dynamic token;
  bool? returnStatus;
  List<String>? returnMessage;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        errors: Errors.fromJson(json["errors"]),
        totalPages: json["totalPages"],
        totalRows: json["totalRows"],
        pageSize: json["pageSize"],
        isAuthenticated: json["isAuthenticated"],
        entity:
            List<Entity>.from(json["entity"].map((x) => Entity.fromJson(x))),
        token: json["token"],
        returnStatus: json["returnStatus"],
        returnMessage: List<String>.from(json["returnMessage"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "errors": errors!.toJson(),
        "totalPages": totalPages,
        "totalRows": totalRows,
        "pageSize": pageSize,
        "isAuthenticated": isAuthenticated,
        "entity": List<dynamic>.from(entity!.map((x) => x.toJson())),
        "token": token,
        "returnStatus": returnStatus,
        "returnMessage": List<dynamic>.from(returnMessage!.map((x) => x)),
      };
}

class Entity {
  Entity({
    this.id,
    this.name,
    this.paymentType,
    this.totalAmount,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.description,
    this.companyId,
    this.companyName,
    this.projectId,
    this.projectName,
    this.processDate,
    this.transactionId,
    this.paymentGateway,
    this.paymentMethod,
    this.bookingDate,
    this.status,
  });

  String? id;
  String? name;
  String? paymentType;
  String? totalAmount;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  dynamic description;
  int? companyId;
  String? companyName;
  int? projectId;
  String? projectName;
  String? processDate;
  String? transactionId;
  String? paymentGateway;
  String? paymentMethod;
  String? bookingDate;
  String? status;

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
        id: json["id"],
        name: json["name"],
        paymentType: json["payment_type"],
        totalAmount: json["total_amount"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
        description: json["description"],
        companyId: json["company_id"],
        companyName: json["company_name"],
        projectId: json["project_id"],
        projectName: json["project_name"],
        processDate: json["process_date"],
        transactionId: json["transaction_id"],
        paymentGateway: json["payment_gateway"],
        paymentMethod: json["payment_method"],
        bookingDate: json["booking_date"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "payment_type": paymentType,
        "total_amount": totalAmount,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "description": description,
        "company_id": companyId,
        "company_name": companyName,
        "project_id": projectId,
        "project_name": projectName,
        "process_date": processDate,
        "transaction_id": transactionId,
        "payment_gateway": paymentGateway,
        "payment_method": paymentMethod,
        "booking_date": bookingDate,
        "status": status,
      };
}

class Errors {
  Errors();

  factory Errors.fromJson(Map<String, dynamic> json) => Errors();

  Map<String, dynamic> toJson() => {};
}
