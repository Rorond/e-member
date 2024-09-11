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
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.description,
    this.totalAmount,
    this.currencyId,
    this.currencyName,
    this.companyId,
    this.companyName,
    this.projectId,
    this.projectName,
    this.processDate,
    this.bookingDate,
    this.status,
    this.paymentType,
    this.orderItems,
  });

  String? id;
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? description;
  String? totalAmount;
  int? currencyId;
  dynamic currencyName;
  int? companyId;
  String? companyName;
  int? projectId;
  String? projectName;
  String? processDate;
  String? bookingDate;
  String? status;
  String? paymentType;
  List<OrderItem>? orderItems;

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
        id: json["id"],
        name: json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
        description: json["description"],
        totalAmount: json["total_amount"],
        currencyId: json["currency_id"],
        currencyName: json["currency_name"],
        companyId: json["company_id"],
        companyName: json["company_name"],
        projectId: json["project_id"],
        projectName: json["project_name"],
        processDate: json["process_date"],
        bookingDate: json["booking_date"],
        status: json["status"],
        paymentType: json["payment_type"],
        orderItems: json["order_items"] == null
            ? null
            : List<OrderItem>.from(
                json["order_items"].map((x) => OrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "description": description,
        "total_amount": totalAmount,
        "currency_id": currencyId,
        "currency_name": currencyName,
        "company_id": companyId,
        "company_name": companyName,
        "project_id": projectId,
        "project_name": projectName,
        "process_date": processDate,
        "booking_date": bookingDate,
        "status": status,
        "payment_type": paymentType,
        "order_items": List<dynamic>.from(orderItems!.map((x) => x.toJson())),
      };
}

class OrderItem {
  OrderItem({
    this.orderId,
    this.itemId,
    this.name,
    this.quantity,
    this.price,
    this.amount,
    this.currencyId,
    this.currencyName,
  });

  int? orderId;
  String? itemId;
  String? name;
  String? quantity;
  String? price;
  String? amount;
  String? currencyId;
  String? currencyName;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        orderId: json["order_id"],
        itemId: json["item_id"],
        name: json["name"],
        quantity: json["quantity"],
        price: json["price"],
        amount: json["amount"],
        currencyId: json["currency_id"],
        currencyName: json["currency_name"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "item_id": itemId,
        "name": name,
        "quantity": quantity,
        "price": price,
        "amount": amount,
        "currency_id": currencyId,
        "currency_name": currencyName,
      };
}

class Errors {
  Errors();

  factory Errors.fromJson(Map<String, dynamic> json) => Errors();

  Map<String, dynamic> toJson() => {};
}
