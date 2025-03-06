import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../../../../order/presentation/view/PaymentPage.dart';
import '../../../domain/entity/review_entity.dart';
import '../../../domain/entity/product_entity.dart';
import '../../state/review_state.dart';
import '../../viewmodel/ReviewViewModel.dart';

class ProductDetailsPage extends ConsumerStatefulWidget {
  final ProductEntity product;

  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends ConsumerState<ProductDetailsPage> {
  late TextEditingController reviewController;
  late TextEditingController usernameController;
  int selectedRating = 0;
  int currentPage = 0;
  final int reviewsPerPage = 4;

  @override
  void initState() {
    super.initState();
    reviewController = TextEditingController();
    usernameController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(reviewViewModelProvider.notifier).fetchReviews("${widget.product.id}");
    });
  }

  @override
  void dispose() {
    reviewController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  Future<void> _refreshReviews() async {
    // Refresh the reviews list
    await ref.read(reviewViewModelProvider.notifier).fetchReviews("${widget.product.id}");
  }

  @override
  Widget build(BuildContext context) {
    var reviewState = ref.watch(reviewViewModelProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text(widget.product.productName), backgroundColor: Colors.purple, centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(widget.product.productImage, screenWidth),
            SizedBox(height: screenHeight * 0.02),
            _buildProductTitle(widget.product.productName),
            SizedBox(height: screenHeight * 0.01),
            _buildProductDescription(widget.product.productDescription),
            SizedBox(height: screenHeight * 0.02),
            _buildProductPrice("${widget.product.productPrice}"),
            SizedBox(height: screenHeight * 0.02),
            _buildAddToCartButton(screenWidth, widget.product),
            SizedBox(height: screenHeight * 0.02),
            Divider(),
            SizedBox(height: screenHeight * 0.02),
            _buildReviewSectionTitle(reviewState),
            SizedBox(height: screenHeight * 0.02),
            _buildReviewsList(reviewState, screenHeight),
            _buildPaginationButtons(reviewState.reviews.length),
            _buildRatingSelection(screenWidth),
            _buildUsernameField(screenWidth),
            _buildReviewField(screenWidth),
            _buildSubmitButton(screenWidth, screenHeight),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(String imageUrl, double screenWidth) {
    return Container(
      height: screenWidth * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[200],
        image:
            imageUrl.isNotEmpty
                ? DecorationImage(image: NetworkImage("http://10.0.2.2:3001/products/$imageUrl"), fit: BoxFit.contain)
                : null,
      ),
      child:
          imageUrl.isEmpty ? Center(child: Icon(Icons.image, color: Colors.grey[400], size: screenWidth * 0.2)) : null,
    );
  }

  Widget _buildProductTitle(String title) {
    return Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold));
  }

  Widget _buildProductDescription(String description) {
    return Text(description, style: TextStyle(fontSize: 16, color: Colors.grey[700]));
  }

  Widget _buildProductPrice(String price) {
    return Text('Npr. $price', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange));
  }

  Widget _buildAddToCartButton(double screenWidth, ProductEntity product) {
    void _proceedToPayment(double itemPrice) {
      const shipping = 50.0;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => PaymentPage(
                shipping: shipping,

                products: [product], // Pass the product details here
              ),
        ),
      );
    }

    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              _proceedToPayment(double.parse("${product.productPrice}"));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              padding: const EdgeInsets.symmetric(vertical: 12.0),
            ),
            child: Text('Buy Now', style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ),
        const SizedBox(width: 16.0),
        IconButton(
          icon: Icon(Icons.favorite_border, color: Colors.red, size: 30),
          onPressed: () {
            // Add to wishlist functionality
          },
        ),
      ],
    );
  }

  Widget _buildReviewSectionTitle(ReviewState reviewState) {
    final totalReviews = reviewState.reviews.length;
    return Row(
      children: [
        Expanded(child: Text('Reviews ($totalReviews)', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
      ],
    );
  }

  Widget _buildReviewsList(ReviewState reviewState, double screenHeight) {
    if (reviewState.isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (reviewState.error != null) {
      return Text('Error: ${reviewState.error}', style: TextStyle(color: Colors.red));
    } else {
      final start = currentPage * reviewsPerPage;
      final end = (start + reviewsPerPage).clamp(0, reviewState.reviews.length);
      final reviewsToShow = reviewState.reviews.sublist(start, end);

      final averageRating = _calculateAverageRating(reviewState.reviews);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAverageRating(averageRating, screenHeight),
          SizedBox(height: screenHeight * 0.02),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: reviewsToShow.length,
            itemBuilder: (context, index) {
              final review = reviewsToShow[index];
              return Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                child: ListTile(
                  leading: CircleAvatar(backgroundColor: Colors.purple, child: Text(review.userName[0].toUpperCase())),
                  title: Text(review.userName, style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(review.review),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (starIndex) {
                      return Icon(starIndex < review.rating ? Icons.star : Icons.star_border, color: Colors.orange);
                    }),
                  ),
                ),
              );
            },
          ),
        ],
      );
    }
  }

  Widget _buildPaginationButtons(int totalReviews) {
    final totalPages = (totalReviews / reviewsPerPage).ceil();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (currentPage > 0)
          ElevatedButton(
            onPressed: () {
              setState(() {
                currentPage--;
              });
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
            child: Text('Previous', style: TextStyle(color: Colors.white)),
          ),
        if (currentPage < totalPages - 1)
          ElevatedButton(
            onPressed: () {
              setState(() {
                currentPage++;
              });
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
            child: const Text('Next', style: TextStyle(color: Colors.white)),
          ),
      ],
    );
  }

  Widget _buildRatingSelection(double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < selectedRating ? Icons.star : Icons.star_border,
            color: Colors.orange,
            size: screenWidth * 0.08,
          ),
          onPressed: () {
            setState(() {
              selectedRating = index + 1;
            });
          },
        );
      }),
    );
  }

  Widget _buildUsernameField(double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      child: TextField(
        controller: usernameController,
        decoration: InputDecoration(
          labelText: 'Username',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
    );
  }

  Widget _buildReviewField(double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      child: TextField(
        controller: reviewController,
        decoration: InputDecoration(
          labelText: 'Add a review',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        maxLines: 3,
      ),
    );
  }

  Widget _buildSubmitButton(double screenWidth, double screenHeight) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () async {
          final reviewText = reviewController.text;
          final userName = usernameController.text;
          if (reviewText.isNotEmpty && selectedRating > 0 && userName.isNotEmpty) {
            final newReview = ReviewEntity(
              userName: userName,
              productId: '${widget.product.id}',
              rating: selectedRating,
              review: reviewText,
            );
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset(
                        'assets/success.json', // Update the path to your Lottie animation file
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Review Added  Successfully!',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),
                      ),
                      SizedBox(height: 8),
                      Text('Thank you for your Review .', textAlign: TextAlign.center),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        setState(() {
                          reviewController.text = "";
                          usernameController.text = "";
                          selectedRating = 0;
                        });
                        await _refreshReviews();
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
            await ref.read(reviewViewModelProvider.notifier).addReview(newReview);

            setState(() {
              reviewController.text = "";
              usernameController.text = "";
              selectedRating = 0;
            });

            // // Refresh the reviews list
            // await _refreshReviews();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02, horizontal: screenWidth * 0.1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        child: Text('Submit', style: TextStyle(fontSize: 16, color: Colors.white)),
      ),
    );
  }

  double _calculateAverageRating(List<ReviewEntity> reviews) {
    if (reviews.isEmpty) return 0;
    final totalRating = reviews.fold<int>(0, (sum, review) => sum + review.rating);
    return totalRating / reviews.length;
  }

  Widget _buildAverageRating(double averageRating, double screenHeight) {
    return Row(
      children: [
        Text('Product Rating: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Row(
          children: List.generate(5, (index) {
            return Icon(
              index < averageRating.floor() ? Icons.star : Icons.star_border,
              color: Colors.orange,
              size: screenHeight * 0.03,
            );
          }),
        ),
        Text(' ${averageRating.toStringAsFixed(1)}', style: TextStyle(fontSize: 18)),
      ],
    );
  }
}
