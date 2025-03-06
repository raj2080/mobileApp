import 'package:dartz/dartz.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../data/repository/ReviewRepositoryimpl.dart';
import '../entity/review_entity.dart';

final reviewRepositoryProvider = Provider((ref) {
  return ref.watch(reviewRemoteRepositoryProvider);
});

abstract class IReviewRepository {
  Future<Either<Failure, List<ReviewEntity>>> getReviews(String productId);
  Future<Either<Failure, bool>> createReview(ReviewEntity review);
}
