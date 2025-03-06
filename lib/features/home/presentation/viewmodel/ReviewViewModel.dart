import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entity/review_entity.dart';
import '../../domain/usecases/ReviewUsecase.dart';
import '../state/review_state.dart';

final reviewViewModelProvider = StateNotifierProvider<ReviewViewModel, ReviewState>((ref) {
  return ReviewViewModel(reviewUseCase: ref.read(reviewUseCaseProvider));
});

class ReviewViewModel extends StateNotifier<ReviewState> {
  final ReviewUseCase reviewUseCase;

  ReviewViewModel({required this.reviewUseCase}) : super(ReviewState.initial());

  Future<void> fetchReviews(String productId) async {
    state = state.copyWith(isLoading: true);
    final result = await reviewUseCase.getReviews(productId);
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, error: failure.error),
      (reviews) => state = state.copyWith(reviews: [...reviews], isLoading: false),
    );
  }

  Future<void> addReview(ReviewEntity review) async {
    final result = await reviewUseCase.createReview(review);
    result.fold((failure) => state = state.copyWith(error: failure.error), (newReview) {
      state = state.copyWith(reviews: [...state.reviews]);
    });
  }
}
