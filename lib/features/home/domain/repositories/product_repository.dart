import '../../data/model/product_model.dart';

abstract class ProductRepository {
  Future<ProductResponse> getProducts(int skip, int limit);
  Future<ProductResponse> getSearchedProducts(String query);
}
