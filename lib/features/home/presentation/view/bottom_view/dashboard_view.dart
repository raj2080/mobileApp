import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/common/NoContentPage.dart';
import '../../../../order/presentation/view/orderPage.dart';
import '../../viewmodel/product_view_model.dart';
import '../../widgets/ProductCard.dart';
import '../../../domain/entity/product_entity.dart';
import '../pages/ProductDetailsPage.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  late ScrollController _scrollController;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  bool showYesNoDialog = true;
  bool isDialogShowing = false;
  List<double> _gyroscopeValues = [];
  bool _isLoading = false;
  final List<StreamSubscription<dynamic>> _streamSubscription = [];
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  Map<String, bool> wishlistStatus = {};

  void _toggleWishlistStatus(String productId) {
    setState(() {
      wishlistStatus[productId] = !(wishlistStatus[productId] ?? false);
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _searchController.addListener(_debounceSearchChanged);
  }

  void _debounceSearchChanged() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_searchController.text == _searchQuery) return; // Prevent unnecessary rebuilds
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  void _refreshPage() async {
    if (mounted) {
      await _loadMoreProducts();
    }
  }

  void _onProductAdded() {
    _refreshPage();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
      _loadMoreProducts();
    }
  }

  Future<void> _loadMoreProducts() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      ref.read(productViewModelProvider.notifier).loadMoreProducts();
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productViewModelProvider);
    final filteredProducts =
        productState.products.where((product) {
          return product.productName.toLowerCase().contains(_searchQuery.toLowerCase());
        }).toList();

    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _loadMoreProducts,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25), // Circular search field
                  boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 5, offset: const Offset(0, 3)),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: const Icon(Icons.search, color: Colors.deepPurple),
                    suffixIcon:
                        _searchController.text.isNotEmpty
                            ? IconButton(
                              icon: const Icon(Icons.clear, color: Colors.deepPurple),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _searchQuery = '';
                                });
                              },
                            )
                            : null,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child:
                  _isLoading
                      ? const Center(child: CircularProgressIndicator()) // Loading state indicator
                      : GridView.builder(
                        controller: _scrollController,
                        itemCount: filteredProducts.length,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Adjust the number of columns here
                          childAspectRatio: 0.5, // Adjust aspect ratio as needed
                        ),
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          final isInWishlist = wishlistStatus[product.id] ?? false;
                          return ProductCard(
                            product: product,
                            isInWishlist: isInWishlist,
                            onWishlistToggle: () => _toggleWishlistStatus("${product.id}"),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ProductDetailsPage(product: product)),
                              );
                            },
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    for (var subscription in _streamSubscription) {
      subscription.cancel();
    }
    super.dispose();
  }
}
