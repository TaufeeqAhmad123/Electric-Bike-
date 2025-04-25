
import 'package:electric_bike_ui/products/controller/search_controller.dart'
    as custom;
import 'package:electric_bike_ui/products/controller/product_controller.dart';
import 'package:electric_bike_ui/products/model/categoryModel.dart';
import 'package:electric_bike_ui/products/model/product_model.dart';
import 'package:electric_bike_ui/products/utils/shimmer_widget.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final _searchController = Get.put(custom.SearchController());
  final _controller = Get.put(ProductController());

  // late Future<ProductModel> _bannerFuture;

  // @override
  // void initState() {
  //   super.initState();
  // //  _bannerFuture = _controller.fetchBannerProduct(); // Fetch only once
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Row(
          children: [
            const Text("Products"),
            const Spacer(),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/search');
              },
              icon: const Icon(CupertinoIcons.search),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Obx(() {
            final isSearching = _searchController.isSearching.value;

            return Column(
              children: [
                const SizedBox(height: 16),

                // 🔍 Search bar
                TextField(
                  controller: _searchController.textController,
                  onChanged: _searchController.performSearch,
                  decoration: InputDecoration(
                    labelText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.textController.clear();
                        _searchController.searchResults.clear();
                        _searchController.isSearching.value = false;
                      },
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),

                // 🔎 Search results
                if (isSearching)
                  Expanded(
                    child: _searchController.isLoading.value
                        ? CustomShimmer(type: ShimmerType.list, itemCount: 8)
                            
                        
                        : _searchController.searchResults.isEmpty &&
                              _searchController.textController.text.isNotEmpty
                        ? const Center(child: Text('No results found'))
                        : ListView.builder(
                            itemCount: _searchController.searchResults.length,
                            itemBuilder: (context, index) {
                              final product =
                                  _searchController.searchResults[index];
                              return ListTile(
                                leading: Image.network(
                                  product.thumbnail,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(product.title),
                                subtitle: Text(product.brand),
                                onTap: () {},
                              );
                            },
                          ),
                  )
                else
                  Expanded(
                    child: Column(
                      children: [
                        // 🎯 Static Banner
                        FutureBuilder<ProductModel>(
                          future: _controller.banner,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                             return CircularProgressIndicator();
                            } else if (snapshot.hasError ||
                                !snapshot.hasData ||
                                snapshot.data!.products.isEmpty) {
                              return const SizedBox();
                            }

                            final product = snapshot.data!.products.first;

                            return Container(
                              height: 200,
                              margin: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.shade300,
                                image: DecorationImage(
                                  image: NetworkImage(product.images[0]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),

                        // 🧭 Category Filters
                        GetBuilder<ProductController>(
                          builder: (controller) {
                            return FutureBuilder<List<CategoryModel>>(
                              future: _controller.categoryList,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError ||
                                    !snapshot.hasData) {
                                  return const Text('No categories');
                                }

                                final categories = [
                                  'All',
                                  ...snapshot.data!.map((e) => e.name),
                                ];

                                return SizedBox(
                                  height: 40,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: categories.length,
                                    itemBuilder: (context, index) {
                                      final category = categories[index];
                                      final isSelected =
                                          _controller.selectedCategory ==
                                          category.toLowerCase();
                                      return Container(
                                        margin: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? Colors.deepPurple
                                              : Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 1,
                                            ),
                                            backgroundColor: isSelected
                                                ? Colors.deepPurple
                                                : Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          onPressed: () {
                                            _controller.fetchcategoryData(
                                              category.toLowerCase(),
                                            );
                                          },
                                          child: Text(
                                            category,
                                            style: TextStyle(
                                              color: isSelected
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(width: 2),
                                  ),
                                );
                              },
                            );
                          },
                        ),

                        const SizedBox(height: 16),

                        // 🛍 Product Grid
                        Expanded(
                          child: GetBuilder<ProductController>(
                            builder: (controller) {
                              return FutureBuilder<ProductModel>(
                                future: _controller.productFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CustomShimmer(type:  ShimmerType.grid, itemCount: 10);
                                  } else if (snapshot.hasError ||
                                      !snapshot.hasData) {
                                    return const Center(
                                      child: Text("No products found."),
                                    );
                                  }

                                  final products = snapshot.data!.products;
                                  return GridView.builder(
                                    itemCount: products.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 200,
                                          childAspectRatio: 0.7,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10,
                                        ),
                                    itemBuilder: (context, index) {
                                      final data = products[index];
                                      return ProductCard(
                                        product: data,
                                        onPress: () {},
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

//
class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.3,
    required this.product,
    required this.onPress,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;
  final VoidCallback onPress;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isImageLoading = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 256,
      width: 195,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: widget.aspectRetio,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // ✅ Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 208, 229, 233),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.network(
                        widget.product.images[0],
                        fit: BoxFit.cover,
                        frameBuilder:
                            (
                              BuildContext context,
                              Widget child,
                              int? frame,
                              bool wasSynchronouslyLoaded,
                            ) {
                              if (wasSynchronouslyLoaded || frame != null) {
                                if (_isImageLoading) {
                                  WidgetsBinding.instance.addPostFrameCallback((
                                    _,
                                  ) {
                                    if (mounted) {
                                      setState(() {
                                        _isImageLoading = false;
                                      });
                                    }
                                  });
                                }
                                return child;
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                      ),
                    ),
                  ),

                  // ✅ Shimmer overlay
                  if (_isImageLoading)
                    Positioned.fill(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            Text(
              widget.product.title,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${widget.product.price}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFF7643),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Rating : ',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.product.rating.toString(),
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Category : ',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.product.category.toString(),
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

