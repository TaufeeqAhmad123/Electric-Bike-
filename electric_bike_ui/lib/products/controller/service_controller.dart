import 'dart:convert';

import 'package:electric_bike_ui/products/model/categoryModel.dart';
import 'package:electric_bike_ui/products/model/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ServiceController extends GetxController {
  
  Future<ProductModel> getProducts() async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/products?limit=100'),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      final List product = data['products'];

      return ProductModel.fromJson(data);
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Failed to load services');
    }
  }

  Future<ProductModel> getSearchedItem(String query) async {
    final reposnse = await http.get(
      Uri.parse('https://dummyjson.com/products/search?q=$query'),
    );
    if (reposnse.statusCode == 200) {
      var data = jsonDecode(reposnse.body);

      return ProductModel.fromJson(data);
    } else if (reposnse.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Failed to load services');
    }
  }

  Future<List<CategoryModel>> getCategory() async {
    final reposnse = await http.get(
      Uri.parse('https://dummyjson.com/products/categories'),
    );
    if (reposnse.statusCode == 200) {
      var data = jsonDecode(reposnse.body);
      if (kDebugMode) print(data);
      List<CategoryModel> categories = [];

      for (var item in data) {
        categories.add(CategoryModel.fromJson(item));
      }
      return categories;
    } else if (reposnse.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Failed to load services');
    }
  }

  Future<ProductModel> getCategoryProduct(String category) async {
    final reposnse = await http.get(
      Uri.parse('https://dummyjson.com/products/category/$category'),
    );
    if (reposnse.statusCode == 200) {
      var data = jsonDecode(reposnse.body);

      return ProductModel.fromJson(data);
    } else if (reposnse.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Failed to load services');
    }
  }

 
}
