// To parse this JSON data, do
//
//     final newsEventModel = newsEventModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../flutter_flow/flutter_flow_model.dart';

List<NewsEventModel> newsEventModelFromJson(String str) =>
    List<NewsEventModel>.from(
        json.decode(str).map((x) => NewsEventModel.fromJson(x)));

String newsEventModelToJson(List<NewsEventModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewseventsModel extends FlutterFlowModel {
  final unfocusNode = FocusNode();

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }
}

class NewsEventModel {
  NewsEventModel({
    this.id = 0,
    this.title = '',
    this.category = '',
    this.body = '',
    this.publishDate,
    this.status = '',
    this.createdAt,
    this.updatedAt,
    this.projectccid,
    this.mainImages,
  });

  int id;
  String title;
  String category;
  String body;
  DateTime? publishDate;
  String status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic projectccid;
  List<MainImage>? mainImages;

  factory NewsEventModel.fromJson(Map<String, dynamic> json) => NewsEventModel(
        id: json["id"],
        title: json["Title"],
        category: json["Category"],
        body: json["Body"],
        publishDate: DateTime.parse(json["PublishDate"]),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        projectccid: json["projectccid"],
        mainImages: List<MainImage>.from(
            json["MainImages"].map((x) => MainImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Title": title,
        "Category": category,
        "Body": body,
        "PublishDate":
            "${publishDate?.year.toString().padLeft(4, '0')}-${publishDate?.month.toString().padLeft(2, '0')}-${publishDate?.day.toString().padLeft(2, '0')}",
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "projectccid": projectccid,
        "MainImages": List<dynamic>.from(mainImages!.map((x) => x.toJson())),
      };

  void dispose() {}
}

class MainImage {
  MainImage({
    this.id = 0,
    this.name = '',
    this.alternativeText = '',
    this.caption = '',
    this.width = 0,
    this.height = 0,
    this.formats,
    this.hash = '',
    this.ext,
    this.mime,
    this.size = 0.0,
    this.url,
    this.previewUrl,
    this.provider,
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
  Ext? ext;
  Mime? mime;
  double size;
  String? url;
  dynamic previewUrl;
  String? provider;
  dynamic providerMetadata;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory MainImage.fromJson(Map<String, dynamic> json) => MainImage(
        id: json["id"],
        name: json["name"],
        alternativeText: json["alternativeText"],
        caption: json["caption"],
        width: json["width"],
        height: json["height"],
        formats: Formats.fromJson(json["formats"]),
        hash: json["hash"],
        ext: extValues.map[json["ext"]],
        mime: mimeValues.map[json["mime"]],
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
        "ext": extValues.reverse[ext],
        "mime": mimeValues.reverse[mime],
        "size": size,
        "url": url,
        "previewUrl": previewUrl,
        "provider": provider,
        "provider_metadata": providerMetadata,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

enum Ext { PNG, JPEG }

final extValues = EnumValues({".jpeg": Ext.JPEG, ".png": Ext.PNG});

class Formats {
  Formats({
    this.small,
    this.thumbnail,
    this.large,
    this.medium,
  });

  Small? small;
  Small? thumbnail;
  Small? large;
  Small? medium;

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        small: Small.fromJson(json["small"]),
        thumbnail: Small.fromJson(json["thumbnail"]),
        large: json["large"] == null ? null : Small.fromJson(json["large"]),
        medium: json["medium"] == null ? null : Small.fromJson(json["medium"]),
      );

  Map<String, dynamic> toJson() => {
        "small": small?.toJson(),
        "thumbnail": thumbnail?.toJson(),
        "large": large == null ? null : large?.toJson(),
        "medium": medium == null ? null : medium?.toJson(),
      };
}

class Small {
  Small({
    this.ext,
    this.url = '',
    this.hash = '',
    this.mime,
    this.path,
    this.size = 0.0,
    this.width = 0,
    this.height = 0,
  });

  Ext? ext;
  String url;
  String hash;
  Mime? mime;
  dynamic path;
  double size;
  int width;
  int height;

  factory Small.fromJson(Map<String, dynamic> json) => Small(
        ext: extValues.map[json["ext"]],
        url: json["url"],
        hash: json["hash"],
        mime: mimeValues.map[json["mime"]],
        path: json["path"],
        size: json["size"].toDouble(),
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "ext": extValues.reverse[ext],
        "url": url,
        "hash": hash,
        "mime": mimeValues.reverse[mime],
        "path": path,
        "size": size,
        "width": width,
        "height": height,
      };
}

enum Mime { IMAGE_PNG, IMAGE_JPEG }

final mimeValues =
    EnumValues({"image/jpeg": Mime.IMAGE_JPEG, "image/png": Mime.IMAGE_PNG});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
