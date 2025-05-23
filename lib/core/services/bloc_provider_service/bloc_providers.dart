import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qstore/features/home/data/data_sources/local_product_datasource.dart';
import 'package:qstore/features/home/data/data_sources/remote_product_datasource.dart';
import 'package:qstore/features/home/data/repository_implementations/product_repository_implementation.dart';
import 'package:qstore/features/home/presentation/bloc/network_bloc/network_connectivity_bloc.dart';
import 'package:qstore/features/home/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:qstore/features/home/presentation/bloc/product_bloc/product_event.dart';

class BlocProviders {
  static List<BlocProvider> getProviders() {
    return [
      BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(ProductRepositoryImplementation(
              localDataSource: LocalProductDataSource(),
              remoteDataSource: RemoteProductDataSource()))),
      BlocProvider<NetworkConnectivityBloc>(create: (context) => NetworkConnectivityBloc())
    ];
  }
}
