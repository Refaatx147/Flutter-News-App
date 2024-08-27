// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:news_appp/core/app_constants/app_strings.dart';

class HomeNewsModel extends Equatable {
  String? title;
  String? author;
  String? urlToImage;
  String? publishedAt;
  String? description;
  HomeNewsModel({
    required this.title,
    required this.author,
    required this.urlToImage,
    required this.publishedAt,
    required this.description,
  });

  factory HomeNewsModel.fromJson(Map<String, dynamic> jsonData) {
    return HomeNewsModel(
        title: jsonData['title'] ?? "",
        author: jsonData['author'] ?? "",
        urlToImage: jsonData['image_url'] ?? AppStrings.defaultImage,
        publishedAt: jsonData['publishedAt'] ?? "",
        description: jsonData['description'] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'image_url': urlToImage,
      'publishedAt': publishedAt,
      'description': description,
    };
  }

  @override
  List<Object?> get props =>
      [title, author, urlToImage, publishedAt, description];
}
