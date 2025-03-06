import 'package:equatable/equatable.dart';

class ReviewEntity extends Equatable {
  final String userName;
  final String? productId;
  final String? userId;
  final int rating;
  final String review;
  final String? id; // Nullable to handle cases where this might be null
  final DateTime? createdAt; // Nullable to handle cases where this might be null
  final DateTime? updatedAt; // Nullable to handle cases where this might be null
  final int? v; // Nullable to handle cases where this might be null

  const ReviewEntity({
    required this.userName,
    required this.productId,
    this.userId,
    required this.rating,
    required this.review,
    this.id, // Nullable
    this.createdAt, // Nullable
    this.updatedAt, // Nullable
    this.v, // Nullable
  });

  @override
  List<Object?> get props => [userName, productId, rating, review];
}
