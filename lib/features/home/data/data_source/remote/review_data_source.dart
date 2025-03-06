import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../app/constants/api_endpoint.dart';
import '../../../../../core/failure/failure.dart';
import '../../../../../core/networking/remote/http_service.dart';
import '../../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../../domain/entity/review_entity.dart';
import '../../dto/get_all_reviews.dart';
import '../../model/review_model.dart';

final reviewRemoteDatasourceProvider = Provider<ReviewRemoteDatasource>((ref) {
  final dio = ref.read(httpServiceProvider);
  final reviewapiModel = ref.read(reviewModelProvider);
  final userSharedPrefs = ref.read(userSharedPrefsProvider);

  return ReviewRemoteDatasource(dio: dio, reviewModel: reviewapiModel, userSharedPrefs: userSharedPrefs);
});

class ReviewRemoteDatasource {
  final Dio dio;
  final ReviewModel reviewModel;
  final UserSharedPrefs userSharedPrefs;

  ReviewRemoteDatasource({required this.dio, required this.reviewModel, required this.userSharedPrefs});

  /// Fetch reviews for a specific product
  Future<Either<Failure, List<ReviewEntity>>> getReviews(String productId) async {
    print(ApiEndpoints.getReviewUrl(productId));
    try {
      final token = await userSharedPrefs.getUserToken();
      token.fold((l) => throw Failure(error: l.error), (r) => r);

      final response = await dio.get(
        ApiEndpoints.getReviewUrl(productId),
        options: Options(headers: {'authorization': 'Bearer $token'}),
      );
      print(response);

      if (response.statusCode == 200) {
        final reviewDto = GetAllReviewsDTO.fromJson(response.data);
        return Right(reviewModel.toEntityList(reviewDto.reviews).cast<ReviewEntity>());
      }

      return Left(Failure(error: response.statusMessage.toString(), statusCode: response.statusCode.toString()));
    } on DioException catch (e) {
      return Left(Failure(error: e.message.toString()));
    }
  }

  /// Submit a review for a specific product
  Future<Either<Failure, bool>> submitReview({required ReviewEntity review}) async {
    try {
      final token = await userSharedPrefs.getUserToken();

      final authToken = token.fold((l) => throw Failure(error: l.error), (r) => r);
      print(authToken);
      final userId = await userSharedPrefs.getUserId();
      if (userId == null) {
        return Left(Failure(error: 'User ID is null'));
      }
      final requestData = {
        'productId': review.productId,
        'userName': review.userName,
        // 'userId': userId,  // Ensure userId is included
        'rating': review.rating,
        'review': review.review,
      };
      final response = await dio.post(
        ApiEndpoints.submitReview,
        data: requestData,
        options: Options(headers: {'authorization': 'Bearer $authToken', 'Content-Type': 'application/json'}),
      );
      print(response);
      print('Response Status Code: ${response.statusCode}');

      if (response.statusCode == 201) {
        print(response.data);
        ReviewModel.fromJson(response.data);
        return Right(true);
      }

      return Left(Failure(error: response.statusMessage.toString(), statusCode: response.statusCode.toString()));
    } on DioException catch (e) {
      return Left(Failure(error: e.message.toString()));
    }
  }
}
