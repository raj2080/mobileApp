import '../../domain/entity/review_entity.dart';

class ReviewState {
  final List<ReviewEntity> reviews;
  final bool isLoading;
  final String? error;

  ReviewState({required this.reviews, required this.isLoading, this.error});

  factory ReviewState.initial() {
    return ReviewState(reviews: [], isLoading: false, error: null);
  }

  ReviewState copyWith({List<ReviewEntity>? reviews, bool? isLoading, String? error}) {
    return ReviewState(
      reviews: reviews ?? this.reviews,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
