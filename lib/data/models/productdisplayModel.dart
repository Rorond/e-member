// To parse this JSON data, do
//
//     final productDisplayModel = productDisplayModelFromJson(jsonString);

import 'dart:convert';

List<ProductDisplayModel> productDisplayModelFromJson(String str) =>
    List<ProductDisplayModel>.from(
        json.decode(str).map((x) => ProductDisplayModel.fromJson(x)));

String productDisplayModelToJson(List<ProductDisplayModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductDisplayModel {
  ProductDisplayModel({
    this.id = 0,
    this.productname = '',
    this.productdesc,
    this.productlink = 0,
    this.status = false,
    this.termconditionstatus = false,
    this.publishdatefrom,
    this.publishdateto,
    this.createdAt,
    this.updatedAt,
    this.projectlink = 0,
    this.mainimage,
  });

  int id;
  String productname;
  dynamic productdesc;
  int productlink;
  bool status;
  bool termconditionstatus;
  DateTime? publishdatefrom;
  DateTime? publishdateto;
  DateTime? createdAt;
  DateTime? updatedAt;
  int projectlink;
  Mainimage? mainimage;

  factory ProductDisplayModel.fromJson(Map<String, dynamic> json) =>
      ProductDisplayModel(
        id: json["id"],
        productname: json["productname"],
        productdesc: json["productdesc"],
        productlink: json["productlink"],
        status: json["status"],
        termconditionstatus: json["termconditionstatus"],
        publishdatefrom: DateTime.parse(json["publishdatefrom"]),
        publishdateto: DateTime.parse(json["publishdateto"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        projectlink: json["projectlink"],
        mainimage: Mainimage.fromJson(json["mainimage"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productname": productname,
        "productdesc": productdesc,
        "productlink": productlink,
        "status": status,
        "termconditionstatus": termconditionstatus,
        "publishdatefrom": publishdatefrom?.toIso8601String(),
        "publishdateto": publishdateto?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "projectlink": projectlink,
        "mainimage": mainimage?.toJson(),
      };
}

class Mainimage {
  Mainimage({
    this.id = 0,
    this.name = '',
    this.alternativeText = '',
    this.caption = '',
    this.width = 0,
    this.height = 0,
    this.formats,
    this.hash = '',
    this.ext = '',
    this.mime = '',
    this.size = 0.0,
    this.url,
    this.previewUrl,
    this.provider = '',
    this.providerMetadata,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String alternativeText;
  String caption;
  int width;
  int height;
  Formats? formats;
  String hash;
  String ext;
  String mime;
  double size;
  String? url;
  dynamic previewUrl;
  String provider;
  dynamic providerMetadata;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Mainimage.fromJson(Map<String, dynamic> json) => Mainimage(
        id: json["id"],
        name: json["name"],
        alternativeText: json["alternativeText"],
        caption: json["caption"],
        width: json["width"],
        height: json["height"],
        formats: Formats.fromJson(json["formats"]),
        hash: json["hash"],
        ext: json["ext"],
        mime: json["mime"],
        size: json["size"].toDouble(),
        url: json["url"],
        previewUrl: json["previewUrl"],
        provider: json["provider"],
        providerMetadata: json["provider_metadata"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "alternativeText": alternativeText,
        "caption": caption,
        "width": width,
        "height": height,
        "formats": formats?.toJson(),
        "hash": hash,
        "ext": ext,
        "mime": mime,
        "size": size,
        "url": url,
        "previewUrl": previewUrl,
        "provider": provider,
        "provider_metadata": providerMetadata,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Formats {
  Formats({
    this.thumbnail,
  });

  Large? thumbnail;

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        thumbnail: Large.fromJson(json["thumbnail"]),
      );

  Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail?.toJson(),
      };
}

class Large {
  Large({
    this.ext = '',
    this.url = '',
    this.hash = '',
    this.mime = '',
    this.path,
    this.size = 0.0,
    this.width = 0,
    this.height = 0,
  });

  String ext;
  String url;
  String hash;
  String mime;
  dynamic path;
  double size;
  int width;
  int height;

  factory Large.fromJson(Map<String, dynamic> json) => Large(
        ext: json["ext"],
        url: json["url"],
        hash: json["hash"],
        mime: json["mime"],
        path: json["path"],
        size: json["size"].toDouble(),
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "ext": ext,
        "url": url,
        "hash": hash,
        "mime": mime,
        "path": path,
        "size": size,
        "width": width,
        "height": height,
      };
}
