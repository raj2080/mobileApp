// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String?, dynamic> json) => ReviewModel(
  userName: json['userName'] as String?,
  productId: json['productId'] as String?,
  userId: json['userId'] as String?,
  rating: json['rating'] as int?,
  review: json['review'] as String,
  id: json['_id'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  v: json['__v'] as int?,

);

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'productId': instance.productId,
      'userId': instance.userId,
      'rating': instance.rating,
      'review': instance.review,
      '_id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,

    };
