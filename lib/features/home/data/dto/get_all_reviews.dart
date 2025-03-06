import 'package:json_annotation/json_annotation.dart';

import '../model/review_model.dart';

part 'get_all_reviews.g.dart';

@JsonSerializable()
class GetAllReviewsDTO {
  final List<ReviewModel> reviews;

  GetAllReviewsDTO({required this.reviews});

  factory GetAllReviewsDTO.fromJson(Map<String, dynamic> json) => _$GetAllReviewsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllReviewsDTOToJson(this);
}
