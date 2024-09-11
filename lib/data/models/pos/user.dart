// // To parse this JSON data, do
// //
// //     final user = userFromJson(jsonString);

// import 'dart:convert';

// User userFromJson(String str) => User.fromJson(json.decode(str));

// String userToJson(User data) => json.encode(data.toJson());

// class User {
//   User({
//     this.errors,
//     this.totalPages = 0,
//     this.totalRows = 0,
//     this.pageSize = 1,
//     this.isAuthenticated = true,
//     this.entity,
//     this.token = "",
//     this.returnStatus = true,
//     this.returnMessage,
//   });

//   Errors? errors;
//   int totalPages;
//   int totalRows;
//   int pageSize;
//   bool isAuthenticated;
//   Entity? entity;
//   String? token;
//   bool returnStatus;
//   List<dynamic>? returnMessage;

//   factory User.fromJson(Map<String, dynamic> json) => User(
//         errors: Errors.fromJson(json["errors"]),
//         totalPages: json["totalPages"],
//         totalRows: json["totalRows"],
//         pageSize: json["pageSize"],
//         isAuthenticated: json["isAuthenticated"],
//         entity: Entity.fromJson(json["entity"]),
//         token: json["token"],
//         returnStatus: json["returnStatus"],
//         returnMessage: List<dynamic>.from(json["returnMessage"].map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "errors": errors!.toJson(),
//         "totalPages": totalPages,
//         "totalRows": totalRows,
//         "pageSize": pageSize,
//         "isAuthenticated": isAuthenticated,
//         "entity": entity!.toJson(),
//         "token": token,
//         "returnStatus": returnStatus,
//         "returnMessage": List<dynamic>.from(returnMessage!.map((x) => x)),
//       };
// }

// class Entity {
//   Entity({
//     this.id = 0,
//     this.name = '',
//     this.emailAddress = '',
//     this.handPhoneNo = '',
//     this.password = '',
//     this.passwordConfirmation,
//     this.token = '',
//     this.projectId,
//     this.projectName = '',
//     this.isAuthenticated = true,
//     this.lastLogin,
//     this.imageUrl = '',
//     this.imageBase64String,
//     required this.authorizationProfile,
//     this.productCategory,
//     this.cashier,
//     this.paymentMethod,
//   });

//   int id;
//   String name;
//   String emailAddress;
//   dynamic handPhoneNo;
//   String password;
//   dynamic passwordConfirmation;
//   String token;
//   int? projectId;
//   String projectName;
//   bool isAuthenticated;
//   dynamic lastLogin;
//   String imageUrl;
//   dynamic imageBase64String;
//   AuthorizationProfile authorizationProfile;
//   List<ProductCategory>? productCategory;
//   List<Cashier>? cashier;
//   List<PaymentMethod>? paymentMethod;

//   factory Entity.fromJson(Map<String, dynamic> json) => Entity(
//         id: json["id"],
//         name: json["name"],
//         emailAddress: json["emailAddress"],
//         handPhoneNo: json["handPhoneNo"],
//         password: json["password"],
//         passwordConfirmation: json["passwordConfirmation"],
//         token: json["token"],
//         projectId: json["projectId"],
//         projectName: json["projectName"] == null ? '' : json["projectName"],
//         isAuthenticated: json["isAuthenticated"],
//         lastLogin: json["lastLogin"],
//         imageUrl: json["imageUrl"],
//         imageBase64String: json["imageBase64String"],
//         authorizationProfile:
//             AuthorizationProfile.fromJson(json["authorizationProfile"]),
//         productCategory: json["productCategory"] == null
//             ? []
//             : List<ProductCategory>.from(json["productCategory"]!
//                 .map((x) => ProductCategory.fromJson(x))),
//         cashier: json["cashier"] == null
//             ? []
//             : List<Cashier>.from(
//                 json["cashier"]!.map((x) => Cashier.fromJson(x))),
//         paymentMethod: json["paymentMethod"] == null
//             ? []
//             : List<PaymentMethod>.from(
//                 json["paymentMethod"]!.map((x) => PaymentMethod.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "emailAddress": emailAddress,
//         "handPhoneNo": handPhoneNo,
//         "password": password,
//         "passwordConfirmation": passwordConfirmation,
//         "token": token,
//         "projectId": projectId,
//         "projectName": projectName,
//         "isAuthenticated": isAuthenticated,
//         "lastLogin": lastLogin,
//         "imageUrl": imageUrl,
//         "imageBase64String": imageBase64String,
//         "authorizationProfile": authorizationProfile.toJson(),
//         "productCategory": productCategory == null
//             ? []
//             : List<dynamic>.from(productCategory!.map((x) => x.toJson())),
//         "cashier": cashier == null
//             ? []
//             : List<dynamic>.from(cashier!.map((x) => x.toJson())),
//         "paymentMethod": paymentMethod == null
//             ? []
//             : List<dynamic>.from(paymentMethod!.map((x) => x.toJson())),
//       };
// }

// class AuthorizationProfile {
//   AuthorizationProfile({
//     required this.authMenu,
//     required this.authObject,
//   });

//   List<AuthMenu> authMenu;
//   List<AuthObject> authObject;

//   factory AuthorizationProfile.fromJson(Map<String, dynamic> json) =>
//       AuthorizationProfile(
//         authMenu: List<AuthMenu>.from(
//             json["authMenu"].map((x) => AuthMenu.fromJson(x))),
//         authObject: List<AuthObject>.from(
//             json["authObject"].map((x) => AuthObject.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "authMenu": List<dynamic>.from(authMenu.map((x) => x.toJson())),
//         "authObject": List<dynamic>.from(authObject.map((x) => x.toJson())),
//       };
// }

// class AuthMenu {
//   AuthMenu({
//     this.name = '',
//     this.url = '',
//     this.description = '',
//   });

//   String name;
//   String url;
//   String description;

//   factory AuthMenu.fromJson(Map<String, dynamic> json) => AuthMenu(
//         name: json["name"],
//         url: json["url"],
//         description: json["description"],
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "url": url,
//         "description": description,
//       };
// }

// class AuthObject {
//   AuthObject({
//     this.authObjectId = 0,
//     this.authObjectName = '',
//     this.authFieldId = 0,
//     this.authFieldName = '',
//     this.value = '',
//   });

//   int authObjectId;
//   String authObjectName;
//   int authFieldId;
//   String authFieldName;
//   String value;

//   factory AuthObject.fromJson(Map<String, dynamic> json) => AuthObject(
//         authObjectId: json["authObjectId"],
//         authObjectName: json["authObjectName"],
//         authFieldId: json["authFieldId"],
//         authFieldName: json["authFieldName"],
//         value: json["value"],
//       );

//   Map<String, dynamic> toJson() => {
//         "authObjectId": authObjectId,
//         "authObjectName": authObjectName,
//         "authFieldId": authFieldId,
//         "authFieldName": authFieldName,
//         "value": value,
//       };
// }

// class Errors {
//   Errors();

//   factory Errors.fromJson(Map<String, dynamic> json) => Errors();

//   Map<String, dynamic> toJson() => {};
// }

// // To parse this JSON data, do
// //
// //     final pos = posFromJson(jsonString);

// Pos posFromJson(String str) => Pos.fromJson(json.decode(str));

// String posToJson(Pos data) => json.encode(data.toJson());

// class Pos {
//   Pos({
//     this.id,
//     this.name,
//     this.isBarRestaurant,
//     this.projectId,
//     this.locationId,
//     this.productCategory,
//     this.cashier,
//     this.paymentMethod,
//     this.userId,
//     this.userName,
//     this.localization,
//     this.employeeId,
//   });

//   int? id;
//   String? name;
//   bool? isBarRestaurant;
//   int? projectId;
//   dynamic locationId;
//   List<ProductCategory>? productCategory;
//   List<Cashier>? cashier;
//   List<PaymentMethod>? paymentMethod;
//   int? userId;
//   dynamic userName;
//   dynamic localization;
//   dynamic employeeId;

//   factory Pos.fromJson(Map<String, dynamic> json) => Pos(
//         id: json["id"],
//         name: json["name"],
//         isBarRestaurant: json["isBarRestaurant"],
//         projectId: json["projectId"],
//         locationId: json["locationId"],
//         productCategory: json["productCategory"] == null
//             ? []
//             : List<ProductCategory>.from(json["productCategory"]!
//                 .map((x) => ProductCategory.fromJson(x))),
//         cashier: json["cashier"] == null
//             ? []
//             : List<Cashier>.from(
//                 json["cashier"]!.map((x) => Cashier.fromJson(x))),
//         paymentMethod: json["paymentMethod"] == null
//             ? []
//             : List<PaymentMethod>.from(
//                 json["paymentMethod"]!.map((x) => PaymentMethod.fromJson(x))),
//         userId: json["userId"],
//         userName: json["userName"],
//         localization: json["localization"],
//         employeeId: json["employeeId"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "isBarRestaurant": isBarRestaurant,
//         "projectId": projectId,
//         "locationId": locationId,
//         "productCategory": productCategory == null
//             ? []
//             : List<dynamic>.from(productCategory!.map((x) => x.toJson())),
//         "cashier": cashier == null
//             ? []
//             : List<dynamic>.from(cashier!.map((x) => x.toJson())),
//         "paymentMethod": paymentMethod == null
//             ? []
//             : List<dynamic>.from(paymentMethod!.map((x) => x.toJson())),
//         "userId": userId,
//         "userName": userName,
//         "localization": localization,
//         "employeeId": employeeId,
//       };
// }

// class Cashier {
//   Cashier({
//     this.id,
//     this.cashierId,
//     this.pointOfSalesId,
//   });

//   int? id;
//   int? cashierId;
//   int? pointOfSalesId;

//   factory Cashier.fromJson(Map<String, dynamic> json) => Cashier(
//         id: json["id"],
//         cashierId: json["cashierId"],
//         pointOfSalesId: json["pointOfSalesId"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "cashierId": cashierId,
//         "pointOfSalesId": pointOfSalesId,
//       };
// }

// class PaymentMethod {
//   PaymentMethod({
//     this.id,
//     this.paymentMethodId,
//     this.paymentMethodName,
//     this.currencyId,
//     this.pointOfSalesId,
//   });

//   int? id;
//   int? paymentMethodId;
//   String? paymentMethodName;
//   int? currencyId;
//   int? pointOfSalesId;

//   factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
//         id: json["id"],
//         paymentMethodId: json["paymentMethodId"],
//         paymentMethodName: json["paymentMethodName"],
//         currencyId: json["currencyId"],
//         pointOfSalesId: json["pointOfSalesId"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "paymentMethodId": paymentMethodId,
//         "paymentMethodName": paymentMethodName,
//         "currencyId": currencyId,
//         "pointOfSalesId": pointOfSalesId,
//       };
// }

// class ProductCategory {
//   ProductCategory({
//     this.id,
//     this.productCategoryId,
//     this.pointOfSalesId,
//   });

//   int? id;
//   int? productCategoryId;
//   int? pointOfSalesId;

//   factory ProductCategory.fromJson(Map<String, dynamic> json) =>
//       ProductCategory(
//         id: json["id"],
//         productCategoryId: json["productCategoryId"],
//         pointOfSalesId: json["pointOfSalesId"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "productCategoryId": productCategoryId,
//         "pointOfSalesId": pointOfSalesId,
//       };
// }
