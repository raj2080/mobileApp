import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../entity/review_entity.dart';
import '../repository/ReviewRepository.dart';

final reviewUseCaseProvider = Provider.autoDispose<ReviewUseCase>(
  (ref) => ReviewUseCase(reviewRepository: ref.read(reviewRepositoryProvider)),
);

class ReviewUseCase {
  final IReviewRepository reviewRepository;

  ReviewUseCase({required this.reviewRepository});

  @override
  Future<Either<Failure, List<ReviewEntity>>> getReviews(String productId) {
    return reviewRepository.getReviews(productId);
  }

  @override
  Future<Either<Failure, bool>> createReview(ReviewEntity review) async {
    return await reviewRepository.createReview(review);
  }
}
