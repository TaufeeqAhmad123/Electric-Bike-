import 'package:electric_bike_ui/products/controller/service_controller.dart';
import 'package:electric_bike_ui/products/model/categoryModel.dart';
import 'package:electric_bike_ui/products/model/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final _controller = Get.put(ServiceController());
  late Future<ProductModel> productFuture;
  late Future<List<CategoryModel>> categoryList;

  String selectedCategory = 'all';
  @override
  void onInit() {
    
    categoryList = _controller.getCategory();
    getAllProductData();
    fetchcategoryData(selectedCategory);
    super.onInit();
  }

  Future<void> getAllProductData()async{
    productFuture = _controller.getProducts();
    update(); // notify listeners
  }

  void fetchcategoryData(String category) {
    selectedCategory = category.toLowerCase();
    if (selectedCategory == 'all') {
      productFuture = _controller.getProducts();
    } else {
      productFuture = _controller.getCategoryProduct(selectedCategory);
    }
    update(); // notify listeners
  }
}
