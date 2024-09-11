class AddProductListData {
  int productId = 0;
  int price = 0;
  int quantity;
  String productCode;
  String productName;
  String promoName;
  String bookingDate;
  String imageUrl;

  AddProductListData._(
      {required this.productId,
      required this.price,
      required this.quantity,
      required this.productCode,
      required this.productName,
      required this.promoName,
      required this.bookingDate,
      required this.imageUrl});

  factory AddProductListData.fromJson(Map<String, dynamic> json) {
    return new AddProductListData._(
        productId: json["productId"],
        price: json["price"],
        quantity: json["quantity"],
        productCode: json["productCode"],
        productName: json["productName"],
        promoName: json["promoName"],
        bookingDate: json["bookingDate"].toString().toString(),
        imageUrl: json['imageUrl'].toString());
  }
}
