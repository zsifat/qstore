class ApiConstants {
  // Base URL
  static const String baseUrl = 'https://dummyjson.com';

  // Get all products with limit
  static String getProducts() => '$baseUrl/products';

  // Search products by query
  static String searchProducts() => '$baseUrl/products/search';
}
