// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

List<CategoryModel> categoryModelFromJson(String str) => List<CategoryModel>.from(json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelToJson(List<CategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
  CategoryModel({
    this.categoryId,
    this.categoryName,
    this.parentId,
  });

  String? categoryId;
  String? categoryName;
  var parentId;

  CategoryModel copyWith({
    String? categoryId,
    String? categoryName,
    var parentId,
  }) =>
      CategoryModel(
        categoryId: categoryId ?? this.categoryId,
        categoryName: categoryName ?? this.categoryName,
        parentId: parentId ?? this.parentId,
      );

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    categoryId: json["category_id"] ?? null,
    categoryName: json["category_name"] ?? null,
    parentId: json["parent_id"] ?? null,
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId ?? null,
    "category_name": categoryName ?? null,
    "parent_id": parentId ?? null,
  };
}
