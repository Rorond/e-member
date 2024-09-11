// To parse required this JSON data, do
//
//     final termconditionModel = termconditionModelFromJson(jsonString);

import 'dart:convert';

List<TermconditionModel> termconditionModelFromJson(String str) =>
    List<TermconditionModel>.from(
        json.decode(str).map((x) => TermconditionModel.fromJson(x)));

String termconditionModelToJson(List<TermconditionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TermconditionModel {
  TermconditionModel({
    required this.id,
    required this.title,
    required this.termcondition,
    required this.projectid,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.agreement,
    required this.image,
  });

  int id;
  String title;
  String termcondition;
  int projectid;
  bool status;
  DateTime createdAt;
  DateTime updatedAt;
  String agreement;
  Image image;

  factory TermconditionModel.fromJson(Map<String, dynamic> json) =>
      TermconditionModel(
        id: json["id"],
        title: json["title"],
        termcondition: json["termcondition"],
        projectid: json["projectid"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        agreement: json["agreement"],
        image: Image.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "termcondition": termcondition,
        "projectid": projectid,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "agreement": agreement,
        "image": image.toJson(),
      };
}

class Image {
  Image({
    required this.id,
    required this.name,
    required this.alternativeText,
    required this.caption,
    required this.width,
    required this.height,
    required this.formats,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.size,
    required this.url,
    required this.previewUrl,
    required this.provider,
    required this.providerMetadata,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String alternativeText;
  String caption;
  int width;
  int height;
  Formats formats;
  String hash;
  String ext;
  String mime;
  double size;
  String url;
  dynamic previewUrl;
  String provider;
  dynamic providerMetadata;
  DateTime createdAt;
  DateTime updatedAt;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
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
        "formats": formats.toJson(),
        "hash": hash,
        "ext": ext,
        "mime": mime,
        "size": size,
        "url": url,
        "previewUrl": previewUrl,
        "provider": provider,
        "provider_metadata": providerMetadata,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Formats {
  Formats({
    required this.small,
    required this.medium,
    required this.thumbnail,
  });

  Medium small;
  Medium medium;
  Medium thumbnail;

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        small: Medium.fromJson(json["small"]),
        medium: Medium.fromJson(json["medium"]),
        thumbnail: Medium.fromJson(json["thumbnail"]),
      );

  Map<String, dynamic> toJson() => {
        "small": small.toJson(),
        "medium": medium.toJson(),
        "thumbnail": thumbnail.toJson(),
      };
}

class Medium {
  Medium({
    required this.ext,
    required this.url,
    required this.hash,
    required this.mime,
    required this.path,
    required this.size,
    required this.width,
    required this.height,
  });

  String ext;
  String url;
  String hash;
  String mime;
  dynamic path;
  double size;
  int width;
  int height;

  factory Medium.fromJson(Map<String, dynamic> json) => Medium(
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
