import 'package:equatable/equatable.dart';

import '../../../data/model/product_model.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class MoreProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final ProductResponse productResponse;
  final bool hasMore;

  ProductLoaded(this.productResponse, {this.hasMore = true});

  @override
  List<Object> get props => [productResponse, hasMore];
}

class ProductError extends ProductState {
  final String error;

  ProductError(this.error);

  @override
  List<Object> get props => [error];
}
