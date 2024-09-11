class ProductListData {
  final int id;
  final String name;
  final String description;
  final String stock;
  final String uoM;
  final int projectId;
  final int productTypeId;
  final int productCategoryId;
  int quantity;
  final String price;
  final String priceWeekDay;
  final String priceWeekEnd;
  final String tax;
  final String discount;
  String discountPercentage;
  int total;
  String validFrom;
  final int currencyId;
  dynamic barcode;
  bool isMembershipRelated;
  int membershipId;
  bool isPassCodeRelated;
  dynamic bankIdentificationNumber;
  bool isCourtRelated;
  String courtId;
  String time;
  String courtScheduleId;
  String bundleQty;
  String thirdPartyFixedAmount;
  String thirdPartyPercentage;
  final String imageUrl;

  ProductListData._(
      {required this.id,
      required this.name,
      required this.description,
      required this.validFrom,
      required this.stock,
      required this.uoM,
      required this.projectId,
      required this.productTypeId,
      required this.productCategoryId,
      required this.quantity,
      required this.price,
      required this.priceWeekDay,
      required this.priceWeekEnd,
      required this.tax,
      required this.discount,
      required this.discountPercentage,
      required this.total,
      required this.currencyId,
      this.barcode,
      required this.isMembershipRelated,
      required this.membershipId,
      required this.isPassCodeRelated,
      this.bankIdentificationNumber,
      required this.isCourtRelated,
      required this.courtId,
      required this.time,
      required this.courtScheduleId,
      required this.bundleQty,
      required this.thirdPartyFixedAmount,
      required this.thirdPartyPercentage,
      required this.imageUrl});

  // factory ProductListData1.fromJson(Map<String, dynamic> json) {
  //   return new ProductListData1._(
  //       id: json['id'],
  //       name: json['name'].toString(),
  //       description: json['description'].toString(),
  //       stock: json['stock'].toString(),
  //       uoM: json['uoM'].toString(),
  //       projectId: json['projectId'],
  //       productTypeId: json['productTypeId'],
  //       productCategoryId: json['productCategoryId'],
  //       quantity: 0,
  //       price: json['currentPrice'].toString(),
  //       priceWeekDay: json['priceWeekDay'].toString(),
  //       priceWeekEnd: json['priceWeekEnd'].toString(),
  //       tax: json['tax'].toString(),
  //       discount: json['discount'].toString(),
  //       total: 0,
  //       validFrom: json['validFrom'].toString(),
  //       currencyId: json['currencyId'],
  //       imageUrl: json['imageUrl'].toString());
  // }

  factory ProductListData.fromJson(Map<String, dynamic> json) =>
      new ProductListData._(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        validFrom: json["validFrom"],
        stock: json["stock"],
        uoM: json["uoM"] == null ? "" : json["uoM"],
        imageUrl: json["imageUrl"],
        productTypeId: json["productTypeId"],
        productCategoryId: json["productCategoryId"],
        projectId: json["projectId"],
        quantity: 0,
        barcode: json["barcode"],
        isMembershipRelated: json["isMembershipRelated"],
        membershipId: json["membershipId"],
        isPassCodeRelated: json["isPassCodeRelated"],
        bankIdentificationNumber: json["bankIdentificationNumber"],
        isCourtRelated: json["isCourtRelated"],
        courtId: json["courtId"],
        time: json["time"],
        price: json["currentPrice"],
        priceWeekDay: json["priceWeekDay"],
        priceWeekEnd: json["priceWeekEnd"],
        discount: json["discount"],
        discountPercentage: json["discountPercentage"],
        total: 0,
        tax: json["tax"],
        currencyId: json["currencyId"],
        courtScheduleId: json["courtScheduleId"],
        bundleQty: json["bundleQty"],
        thirdPartyFixedAmount: json["thirdPartyFixedAmount"],
        thirdPartyPercentage: json["thirdPartyPercentage"],
      );
}
