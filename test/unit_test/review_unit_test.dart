import 'package:blushstore/core/failure/failure.dart';
import 'package:blushstore/features/home/domain/entity/review_entity.dart';
import 'package:blushstore/features/home/domain/usecases/ReviewUsecase.dart';
import 'package:blushstore/features/home/presentation/viewmodel/ReviewViewModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

class MockReviewUseCase extends Mock implements ReviewUseCase {}

void main() {
  late ReviewViewModel reviewViewModel;
  late MockReviewUseCase mockReviewUseCase;
  final tProductId = '1';
  final tReviews = [
    ReviewEntity(userName: 'John', productId: tProductId, rating: 5, review: 'Great product!'),
    ReviewEntity(userName: 'Doe', productId: tProductId, rating: 4, review: 'Good product'),
  ];

  setUp(() {
    mockReviewUseCase = MockReviewUseCase();
    reviewViewModel = ReviewViewModel(reviewUseCase: mockReviewUseCase);
  });

  group('fetchReviews', () {
    test('should set state to loading, fetch reviews and update the state', () async {
      // Arrange
      when(mockReviewUseCase.getReviews("1")).thenAnswer((_) async => Right(tReviews));

      // Assert initial state
      expect(reviewViewModel.state.isLoading, false);

      // Act
      await reviewViewModel.fetchReviews(tProductId);

      // Assert
      verify(mockReviewUseCase.getReviews(tProductId));
      expect(reviewViewModel.state.isLoading, false);
      expect(reviewViewModel.state.reviews, tReviews);
      expect(reviewViewModel.state.error, isNull);
    });

    test('should set error when fetching reviews fails', () async {
      // Arrange
      const tError = 'Error occurred';
      when(mockReviewUseCase.getReviews("1")).thenAnswer((_) async => Left(Failure(error: tError)));

      // Act
      await reviewViewModel.fetchReviews(tProductId);

      // Assert
      verify(mockReviewUseCase.getReviews(tProductId));
      expect(reviewViewModel.state.isLoading, false);
      expect(reviewViewModel.state.reviews, []);
      expect(reviewViewModel.state.error, tError);
    });
  });

  group('addReview', () {
    final tReview = ReviewEntity(userName: 'John', productId: tProductId, rating: 5, review: 'Great product!');

    test('should add review and update the state', () async {
      // Arrange
      when(mockReviewUseCase.createReview(tReview!)).thenAnswer((_) async => Right(true));

      // Act
      await reviewViewModel.addReview(tReview);

      // Assert
      verify(mockReviewUseCase.createReview(tReview));
      expect(reviewViewModel.state.reviews, contains(tReview));
      expect(reviewViewModel.state.error, isNull);
    });

    test('should set error when adding review fails', () async {
      // Arrange
      const tError = 'Error occurred';
      when(mockReviewUseCase.createReview(tReview)).thenAnswer((_) async => Left(Failure(error: tError)));

      // Act
      await reviewViewModel.addReview(tReview);

      // Assert
      verify(mockReviewUseCase.createReview(tReview));
      expect(reviewViewModel.state.error, tError);
    });
  });
}
