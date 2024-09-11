class ProjectList {
  final int id;
  final String name;
  final int companyId;
  final String imageUrl;
  final String ticketClosedTime;
  final String city;
  final String currentPrice;

  //final List<ImageProject> imageUrl;

  ProjectList._(
      {required this.id,
      required this.name,
      required this.companyId,
      required this.imageUrl,
      required this.ticketClosedTime,
      required this.city,
      required this.currentPrice});

  factory ProjectList.fromJson(Map<String, dynamic> json) {
    return new ProjectList._(
        id: json['id'],
        name: json['name'].toString(),
        companyId: json['companyId'],
        imageUrl: json['imageUrl'],
        ticketClosedTime: json['ticketClosedTime'],
        city: json['city'] == null ? "" : json['city'],
        currentPrice:
            json['currentPrice'] == null ? "0" : json['currentPrice']);
  }

  static List<ProjectList> fromJsonList(List<dynamic> list) {
    if (list == null) return [];
    return list.map((item) => ProjectList.fromJson(item)).toList();
  }

  //  factory ProjectList.fromJson(Map<String, dynamic> json) {
  //     var list = json['images'] as List;
  //     print(list.runtimeType);
  //     //returns List<dynamic>
  //     List<ImageProject> imagesList = list.map((i) => ImageProject.fromJson(i)).toList();

  //   return new ProjectList._(
  //     id: json['ProjectIdRelatation'],
  //     name: json['ProjectName'].toString(),
  //     companyId: json['CompanyId'],
  //     imagePath : imagesList
  //   );
  // }
}

class ImageProject {
  final int id;
  final String url;

  ImageProject({required this.id, required this.url});

  factory ImageProject.fromJson(Map<String, dynamic> parsedJson) {
    return ImageProject(id: parsedJson['id'], url: parsedJson['url']);
  }
}

class MembershipList {
  final int id;
  final String name;
  final int projectId;
  final int typeId;
  final int categoryId;
  final String price;
  final String tax;
  final String discount;
  final String validFrom;
  final String validTo;
  final int currencyId;
  final String period;
  final String imagePath;
  final String freeFlag;

  MembershipList._(
      {this.id = 0,
      this.name = '',
      this.projectId = 0,
      this.typeId = 0,
      this.categoryId = 0,
      this.price = '',
      this.tax = '',
      this.discount = '',
      this.validFrom = '',
      this.validTo = '',
      this.currencyId = 0,
      this.period = '',
      this.imagePath = '',
      this.freeFlag = ''});

  factory MembershipList.fromJson(Map<String, dynamic> json) {
    return new MembershipList._(
        id: json['id'],
        name: json['name'].toString(),
        projectId: json['projectId'],
        typeId: json['typeId'],
        categoryId: json['categoryId'],
        price: json['price'].toString(),
        tax: json['tax'].toString(),
        discount: json['discount'].toString(),
        validFrom: json['validFrom'].toString(),
        validTo: json['validTo'].toString(),
        currencyId: json['currencyId'],
        period: json['period'].toString(),
        imagePath: json['imagePath'].toString(),
        freeFlag: json['freeFlag'].toString());
  }
}
