import '../../domain/repositories/product_repository.dart';
import '../data_sources/local_product_datasource.dart';
import '../data_sources/remote_product_datasource.dart';
import '../model/product_model.dart';

class ProductRepositoryImplementation implements ProductRepository {
  final RemoteProductDataSource remoteDataSource;
  final LocalProductDataSource localDataSource;

  ProductRepositoryImplementation({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<ProductResponse> getProducts(int skip, int limit) async {
    try {
      final result = await remoteDataSource.getProducts(skip, limit);
      await localDataSource.cacheProducts(result);
      return result;
    } catch (e) {
      final cached = localDataSource.getCachedProducts();
      if (cached != null) {
        return cached;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<ProductResponse> getSearchedProducts(String query) async {
    return await remoteDataSource.getSearchedProducts(query);
  }
}
