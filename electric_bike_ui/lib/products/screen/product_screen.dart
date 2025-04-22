import 'dart:io';

import 'package:electric_bike_ui/products/controller/product_controller.dart';
import 'package:electric_bike_ui/products/controller/service_controller.dart';
import 'package:electric_bike_ui/products/model/categoryModel.dart';
import 'package:electric_bike_ui/products/model/product_model.dart';
import 'package:electric_bike_ui/products/screen/execption_screen.dart';
import 'package:electric_bike_ui/products/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
// TODO: add flutter_svg package to pubspec.yaml

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final _controller=Get.put(ProductController());
  // late Future<ProductModel> productFuture;
  // late Future<List<CategoryModel>> categoryList;

  // String selectedCategory = 'all';

  // @override
  // void initState() {
  //   super.initState();
  //   //final services = Services();
  //   productFuture = Services().getProducts();
  //   categoryList = Services().getCategory();
  // }

  // void getCategoryProduct(String category) {
  //   setState(() {
  //     selectedCategory = category;
  //     if (category.toLowerCase() == 'all') {
  //       productFuture = Services().getProducts();
  //     } else {
  //       productFuture = Services().getCategoryProduct(category);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Row(
          children: [
            const Text("Products"),
            Spacer(),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/search');
              },
              icon: Icon(CupertinoIcons.search),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              GetBuilder<ProductController>(builder:(controller){
                return FutureBuilder<List<CategoryModel>>(
                future: _controller.categoryList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LinearProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData) {
                    return const Text('No categories');
                  }
                  final categories = [
                    'All',
                    ...snapshot.data!.map((e) => e.name),
                  ];
                  return SizedBox(
                    height: 40,
                    child: ListView.separated(
                      itemCount: categories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        final isSelected =
                            _controller.selectedCategory == category.toLowerCase();
                        return Container(
                          margin: EdgeInsets.all(3),
                         
                        

                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.deepPurple
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
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
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                             _controller. fetchcategoryData(category.toLowerCase());
                            },
                            child: Text(
                              category,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(width: 2),
                    ),
                  );
                },
              );
              }),
              const SizedBox(height: 16),

              Expanded(
                child: GetBuilder<ProductController>(builder: (controller){
                 return FutureBuilder<ProductModel>(
                  future: _controller.productFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return GridView.builder(
                        itemCount: 6, // show 6 shimmer cards
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 0.7,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 16,
                            ),
                        itemBuilder: (context, index) => buildShimmerCard(),
                      );
                    } else if (snapshot.hasError) {
                      final error = snapshot.error;
                      if (error is SocketException) {
                        return NoInternetScreen(
                          onRetry: () {
                            setState(() {
                          _controller.    productFuture =_controller.productFuture;
                            });
                          },
                        );
                      }
                    } else if (!snapshot.hasData ||
                        snapshot.data!.products.isEmpty) {
                      return const Center(child: Text("No products found."));
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
                        var data = products[index];

                        return ProductCard(product: data, onPress: () {});
                      },
                    );
                  },
                );
                })
              ),
            ],
          ),
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

Widget buildShimmerCard() {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade300,
    enabled: true,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 140,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(height: 8),
        Container(height: 16, width: 100, color: Colors.white),
        const SizedBox(height: 4),
        Container(
          height: 14,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(20),
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Container(height: 14, width: 100, color: Colors.white),
        const SizedBox(height: 4),
        Container(height: 14, width: 100, color: Colors.white),
      ],
    ),
  );
}
