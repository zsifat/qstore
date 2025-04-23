import 'package:hive_flutter/hive_flutter.dart';
import 'package:qstore/core/services/local_data_services/hive_constants.dart';

import '../../../features/home/data/model/product_model.dart';

class HiveService {
  static final HiveService _instance = HiveService._internal();

  factory HiveService() {
    return _instance;
  }
  HiveService._internal();

  Future<void> initializeHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ProductModelAdapter());
    Hive.registerAdapter(DimensionsAdapter());
    Hive.registerAdapter(ReviewAdapter());
    Hive.registerAdapter(MetaAdapter());
    Hive.registerAdapter(ProductResponseAdapter());
    await Hive.openBox(HiveConstants.productsBox);
  }

  Box<T> getBox<T>(String boxName) {
    return Hive.box<T>(boxName);
  }

  Box get productBox => Hive.box(HiveConstants.productsBox);
}
