import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProducts extends ProductEvent {
  bool isRefresh;
  FetchProducts({this.isRefresh = false});
  @override
  List<Object> get props => [isRefresh];
}

class FetchSearchedProducts extends ProductEvent {
  final String query;

  FetchSearchedProducts(this.query);

  @override
  List<Object> get props => [query];
}
