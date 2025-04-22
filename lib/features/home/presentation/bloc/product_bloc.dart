import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qstore/features/home/data/model/product_model.dart';
import '../../data/repository_implementations/product_repository_implementation.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepositoryImplementation productRepository;

  final List<ProductModel> _allProducts = [];
  int _skip = 0;
  final int _limit = 20;
  bool _isFetching = false;
  bool _hasMore = true;

  ProductBloc(this.productRepository) : super(ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
    on<FetchSearchedProducts>(_onFetchSearchedProducts);
  }

  Future<void> _onFetchProducts(FetchProducts event, Emitter<ProductState> emit) async {
    if (_isFetching || !_hasMore) return;

    if (event.isRefresh) {
      emit(ProductLoading());
      _resetPagination();
    }

    _isFetching = true;

    try {
      final productsResponse = await productRepository.getProducts(_skip, _limit);

      _skip += _limit;
      _allProducts.addAll(productsResponse.products);

      _hasMore = productsResponse.total > _allProducts.length;

      emit(
        ProductLoaded(
          ProductResponse(
            products: _allProducts,
            limit: productsResponse.limit,
            skip: productsResponse.skip,
            total: productsResponse.total,
          ),
          hasMore: _hasMore,
        ),
      );
    } catch (error) {
      emit(ProductError(error.toString()));
    } finally {
      _isFetching = false;
    }
  }

  Future<void> _onFetchSearchedProducts(
      FetchSearchedProducts event, Emitter<ProductState> emit) async {
    if(event.query.isNotEmpty){
      emit(ProductLoading());
      try {
        final searchResponse = await productRepository.getSearchedProducts(event.query);

        emit(ProductLoaded(searchResponse));
      } catch (error) {
        emit(ProductError(error.toString()));
      }
    }
  }

  void _resetPagination() {
    _skip = 0;
    _allProducts.clear();
    _hasMore = true;
  }
}
