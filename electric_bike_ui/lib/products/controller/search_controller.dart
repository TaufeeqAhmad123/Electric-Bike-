import 'package:electric_bike_ui/products/controller/service_controller.dart';
import 'package:electric_bike_ui/products/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final TextEditingController textController = TextEditingController();
  final services = Get.find<ServiceController>();

  var searchResults = <Product>[].obs;
  var isLoading = false.obs;

  void performSearch(String query) async {
    if (query.isEmpty) return;
    isLoading.value = true;
    try {
      final allProducts = await services.getSearchedItem(query);
      var result = allProducts.products.where((e) {
        return e.title.toLowerCase().contains(query.toLowerCase()) ||
            e.description.toLowerCase().contains(query.toLowerCase()) ||
            e.brand.toLowerCase().contains(query.toLowerCase()) ||
            e.category.toLowerCase().contains(query.toLowerCase());
      }).toList();
      searchResults.value = result;
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
