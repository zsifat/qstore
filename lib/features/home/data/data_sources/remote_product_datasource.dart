import '../../../../core/services/network_services/api_client.dart';
import '../../../../core/services/network_services/api_constants.dart';
import '../../domain/repositories/product_repository.dart';
import '../model/product_model.dart';

class RemoteProductDataSource extends ProductRepository {

  Future<ProductResponse> getProducts(int skip, int limit) async {
    try {
      final response = await ApiClient.instance.get(
        ApiConstants.getProducts(),
        queryParameters: {
          'skip': skip,
          'limit': limit,
        },
      );
      return ProductResponse.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }


  @override
  Future<ProductResponse> getSearchedProducts(String query) async {
    try {
      final response = await ApiClient.instance.get(
        ApiConstants.searchProducts(),
        queryParameters: {
          'q': query,
        },
      );
      return ProductResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
