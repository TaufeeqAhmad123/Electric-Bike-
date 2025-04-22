import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import 'package:electric_bike_ui/products/controller/search_controller.dart';
import 'package:shimmer/shimmer.dart' show Shimmer;

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchController());

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 29),
          TextField(
            controller: controller.textController,
            onChanged: controller.performSearch,
            decoration: InputDecoration(
              labelText: 'Search',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  controller.textController.clear();
                  controller.searchResults.clear();
                },
              ),
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          Obx(() {
            if (controller.isLoading.value) {
              return Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildShimmerCard(),
                  ),
                ),
              );
            } else if (controller.searchResults.isEmpty &&
                controller.textController.text.isNotEmpty) {
              return const Text('No results found');
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: controller.searchResults.length,
                  itemBuilder: (context, index) {
                    final product = controller.searchResults[index];
                    return ListTile(
                      leading: Image.network(
                        product.thumbnail,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(product.title),
                      subtitle: Text(product.brand),
                      onTap: () {
                        // Navigate to product detail if needed
                      },
                    );
                  },
                ),
              );
            }
          }),
        ],
      ),
    );
  }

  Widget buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.black.withAlpha(50),
      enabled: true,
      child: ListTile(
        leading: Container(
          width: 110,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        title: Container(
          margin: const EdgeInsets.only(top: 10),
          height: 20,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        subtitle: Container(
          padding: const EdgeInsets.only(top: 10),
          margin: const EdgeInsets.only(top: 10),
          height: 20,
          width: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
