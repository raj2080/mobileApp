import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entity/review_entity.dart';
import '../../domain/repository/ReviewRepository.dart';
import '../data_source/remote/review_data_source.dart';

final reviewRemoteRepositoryProvider = Provider(
  (ref) => ReviewRepositoryimpl(reviewRemoteDatasource: ref.read(reviewRemoteDatasourceProvider)),
);

class ReviewRepositoryimpl implements IReviewRepository {
  final ReviewRemoteDatasource reviewRemoteDatasource;

  ReviewRepositoryimpl({required this.reviewRemoteDatasource});

  @override
  Future<Either<Failure, List<ReviewEntity>>> getReviews(String productId) {
    return reviewRemoteDatasource.getReviews(productId);
  }

  @override
  Future<Either<Failure, bool>> createReview(ReviewEntity review) async {
    return await reviewRemoteDatasource.submitReview(review: review);
  }
}
