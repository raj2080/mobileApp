import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/review_entity.dart';

part 'review_model.g.dart';

final reviewModelProvider = Provider((ref) => const ReviewModel.empty());

@JsonSerializable()
class ReviewModel extends Equatable {
  final String? userName;
  final String? productId;
  final String? userId;
  final int? rating;
  final String? review;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  const ReviewModel({
    required this.userName,
    required this.productId,
    this.userId,
    required this.rating,
    required this.review,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  const ReviewModel.empty()
      : userName = '',
        productId = '',
        userId=null,
        rating = 0,
        review = '',
  id=null,
  createdAt=null,
  updatedAt=null,
  v=null;

  ReviewEntity toEntity() {
    return ReviewEntity(
      userName: userName!,
      productId: productId!,
      userId: userId,
      rating: rating!,
      review: review!,
    );
  }

  static ReviewModel fromEntity(ReviewEntity entity) {
    return ReviewModel(
      userName: entity.userName,
      productId: entity.productId,
      // userId: entity.userId,
      rating: entity.rating,
      review: entity.review,
    );
  }

  factory ReviewModel.fromJson(Map<String?, dynamic> json) =>
      _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);

  List<ReviewEntity> toEntityList(List<ReviewModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [userName, productId, rating, review];
}
