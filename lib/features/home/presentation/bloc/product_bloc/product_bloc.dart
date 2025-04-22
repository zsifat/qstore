import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qstore/features/home/data/model/product_model.dart';
import '../../../data/repository_implementations/product_repository_implementation.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepositoryImplementation productRepository;

  final List<ProductModel> _allProducts = [];
  int _skip = 0;
  final int _limit = 50;
  bool _isFetching = false;
  bool _hasMore = true;

  SortOption? _currentSortOption;

  ProductBloc(this.productRepository) : super(ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
    on<FetchSearchedProducts>(_onFetchSearchedProducts);
    on<SortProducts>(_onSortProducts);
    on<ClearSort>(_onClearSort);
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

      if (_currentSortOption != null) {
        add(SortProducts(_currentSortOption!)); // 👉 Trigger sorting after new data fetched
      } else {
        emit(ProductLoaded(
          ProductResponse(
            products: _allProducts,
            limit: _limit,
            skip: _skip,
            total: _allProducts.length,
          ),
          hasMore: _hasMore,
        ));
      }
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

  void _onSortProducts(SortProducts event, Emitter<ProductState> emit) {
    _currentSortOption = event.sortOption;  // 🆕 Remember sort option
    _emitSortedProducts(emit);
  }

  void _emitSortedProducts(Emitter<ProductState> emit) {
    List<ProductModel> sortedProducts = List.from(_allProducts);

    if (_currentSortOption != null) {
      switch (_currentSortOption!) {
        case SortOption.priceLowToHigh:
          sortedProducts.sort((a, b) => a.price.compareTo(b.price));
          break;
        case SortOption.priceHighToLow:
          sortedProducts.sort((a, b) => b.price.compareTo(a.price));
          break;
        case SortOption.ratingHighToLow:
          sortedProducts.sort((a, b) => b.rating.compareTo(a.rating));
          break;
      }
    }

    emit(ProductLoaded(
      ProductResponse(
        products: sortedProducts,
        limit: _limit,
        skip: _skip,
        total: sortedProducts.length,
      ),
      hasMore: _hasMore,
    ));
  }

  void _onClearSort(ClearSort event, Emitter<ProductState> emit) {
    _currentSortOption = null;
    add(FetchProducts(isRefresh: true));
  }
}
