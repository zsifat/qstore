import 'dart:convert';
import '../../../../core/services/local_data_services/hive_constants.dart';
import '../../../../core/services/local_data_services/hive_service.dart';
import '../model/product_model.dart';

class LocalProductDataSource {
  final HiveService hiveService = HiveService();

  Future<void> cacheProducts(ProductResponse response) async {
    try {
      String productJson = json.encode(response.toJson());
      await hiveService.productBox.put(HiveConstants.productListKey, productJson);
      print("Successfully cached products: $productJson");
    } catch (e) {
      throw Exception(e);
    }
  }

  ProductResponse? getCachedProducts() {
    try{
      final data = hiveService.productBox.get(HiveConstants.productListKey);
      if (data != null) {
        try {
          Map<String, dynamic> dataMap = json.decode(data);
          return ProductResponse.fromJson(dataMap);
        } catch (e) {
          throw Exception(e);
        }
      }
      return null;
    }catch(e){
      throw Exception(e);
    }
  }
}
