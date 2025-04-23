import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:qstore/features/home/data/model/product_model.dart';
import 'package:qstore/features/home/data/repository_implementations/product_repository_implementation.dart';
import '../mocks.mocks.dart';

void main() {
  late MockRemoteProductDataSource remote;
  late MockLocalProductDataSource local;
  late ProductRepositoryImplementation repository;

  setUp(() {
    remote = MockRemoteProductDataSource();
    local = MockLocalProductDataSource();
    repository = ProductRepositoryImplementation(
      remoteDataSource: remote,
      localDataSource: local,
    );
  });

  group('getProducts', () {
    final response = ProductResponse(products: [], total: 0, skip: 0, limit: 10);

    test('returns remote data and caches it locally', () async {
      when(remote.getProducts(0, 10)).thenAnswer((_) async => response);
      when(local.cacheProducts(response)).thenAnswer((_) async => {});

      final result = await repository.getProducts(0, 10);

      expect(result, response);
      verify(remote.getProducts(0, 10)).called(1);
      verify(local.cacheProducts(response)).called(1);
    });

    test('returns cached data when remote fails', () async {
      when(remote.getProducts(0, 10)).thenThrow(Exception('No internet'));
      when(local.getCachedProducts()).thenReturn(response);

      final result = await repository.getProducts(0, 10);

      expect(result, response);
      verify(remote.getProducts(0, 10)).called(1);
      verify(local.getCachedProducts()).called(1);
    });

    test('rethrows if no cached data exists', () async {
      when(remote.getProducts(0, 10)).thenThrow(Exception('No internet'));
      when(local.getCachedProducts()).thenReturn(null);

      expect(
            () async => await repository.getProducts(0, 10),
        throwsException,
      );
    });
  });

  group('getSearchedProducts', () {
    final response = ProductResponse(products: [], total: 0, skip: 0, limit: 10);

    test('returns remote search results', () async {
      when(remote.getSearchedProducts('test')).thenAnswer((_) async => response);

      final result = await repository.getSearchedProducts('test');

      expect(result, response);
      verify(remote.getSearchedProducts('test')).called(1);
    });
  });
}
