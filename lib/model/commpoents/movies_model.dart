// To parse this JSON data, do
//
//     final moviesModel = moviesModelFromJson(jsonString);

import 'dart:convert';

List<MoviesModel> moviesModelFromJson(String str) => List<MoviesModel>.from(json.decode(str).map((x) => MoviesModel.fromJson(x)));

String moviesModelToJson(List<MoviesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MoviesModel {
  MoviesModel({
    this.num,
    this.name,
    this.title,
    this.year,
    this.streamType,
    this.streamId,
    this.streamIcon,
    this.rating,
    this.rating5Based,
    this.added,
    this.categoryId,
    this.categoryIds,
    this.containerExtension,
    this.customSid,
    this.directSource,
  });

  int? num;
  String? name;
  String? title;
  String? year;
  String? streamType;
  int? streamId;
  String? streamIcon;
  double? rating;
  double? rating5Based;
  String? added;
  String? categoryId;
  List<int>? categoryIds;
  String? containerExtension;
  String? customSid;
  String? directSource;

  MoviesModel copyWith({
    int? num,
    String? name,
    String? title,
    String? year,
    String? streamType,
    int? streamId,
    String? streamIcon,
    double? rating,
    double? rating5Based,
    String? added,
    String? categoryId,
    List<int>? categoryIds,
    String? containerExtension,
    String? customSid,
    String? directSource,
  }) =>
      MoviesModel(
        num: num ?? this.num,
        name: name ?? this.name,
        title: title ?? this.title,
        year: year ?? this.year,
        streamType: streamType ?? this.streamType,
        streamId: streamId ?? this.streamId,
        streamIcon: streamIcon ?? this.streamIcon,
        rating: rating ?? this.rating,
        rating5Based: rating5Based ?? this.rating5Based,
        added: added ?? this.added,
        categoryId: categoryId ?? this.categoryId,
        categoryIds: categoryIds ?? this.categoryIds,
        containerExtension: containerExtension ?? this.containerExtension,
        customSid: customSid ?? this.customSid,
        directSource: directSource ?? this.directSource,
      );

  factory MoviesModel.fromJson(Map<String, dynamic> json) => MoviesModel(
    num: json["num"] ?? null,
    name: json["name"] ?? null,
    title: json["title"] ?? null,
    year: json["year"] ?? null,
    streamType: json["stream_type"] ?? null,
    streamId: json["stream_id"] ?? null,
    streamIcon: json["stream_icon"] ?? null,
    rating: json["rating"] == null ? null : json["rating"].toDouble(),
    rating5Based: json["rating_5based"] == null ? null : json["rating_5based"].toDouble(),
    added: json["added"] ?? null,
    categoryId: json["category_id"] ?? null,
    categoryIds: json["category_ids"] == null ? null : List<int>.from(json["category_ids"].map((x) => x)),
    containerExtension: json["container_extension"] ?? null,
    customSid: json["custom_sid"] ?? null,
    directSource: json["direct_source"] ?? null,
  );

  Map<String, dynamic> toJson() => {
    "num": num ?? null,
    "name": name ?? null,
    "title": title ?? null,
    "year": year ?? null,
    "stream_type": streamType ?? null,
    "stream_id": streamId ?? null,
    "stream_icon": streamIcon ?? null,
    "rating": rating ?? null,
    "rating_5based": rating5Based ?? null,
    "added": added ?? null,
    "category_id": categoryId ?? null,
    "category_ids": categoryIds == null ? null : List<dynamic>.from(categoryIds!.map((x) => x)),
    "container_extension": containerExtension ?? null,
    "custom_sid": customSid ?? null,
    "direct_source": directSource ?? null,
  };
}

