import 'package:hive/hive.dart';

part 'product_model.g.dart'; // Add this line

@HiveType(typeId: 0)
class ProductModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String category;

  @HiveField(4)
  final double price;

  @HiveField(5)
  final double discountPercentage;

  @HiveField(6)
  final double rating;

  @HiveField(7)
  final int stock;

  @HiveField(8)
  final List<String> tags;

  @HiveField(9)
  final String brand;

  @HiveField(10)
  final String sku;

  @HiveField(11)
  final double weight;

  @HiveField(12)
  final Dimensions dimensions;

  @HiveField(13)
  final String warrantyInformation;

  @HiveField(14)
  final String shippingInformation;

  @HiveField(15)
  final String availabilityStatus;

  @HiveField(16)
  final List<Review> reviews;

  @HiveField(17)
  final String returnPolicy;

  @HiveField(18)
  final int minimumOrderQuantity;

  @HiveField(19)
  final Meta meta;

  @HiveField(20)
  final List<String> images;

  @HiveField(21)
  final String thumbnail;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.images,
    required this.thumbnail,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      discountPercentage: (json['discountPercentage'] ?? 0.0).toDouble(),
      rating: (json['rating'] ?? 0.0).toDouble(),
      stock: json['stock'] ?? 0,
      tags: List<String>.from(json['tags'] ?? []),
      brand: json['brand'] ?? '',
      sku: json['sku'] ?? '',
      weight: (json['weight'] ?? 0.0).toDouble(),
      dimensions: json['dimensions'] != null
          ? Dimensions.fromJson(json['dimensions'])
          : Dimensions(width: 0.0, height: 0.0, depth: 0.0),
      warrantyInformation: json['warrantyInformation'] ?? '',
      shippingInformation: json['shippingInformation'] ?? '',
      availabilityStatus: json['availabilityStatus'] ?? '',
      reviews: (json['reviews'] as List? ?? [])
          .map((e) => Review.fromJson(e))
          .toList(),
      returnPolicy: json['returnPolicy'] ?? '',
      minimumOrderQuantity: json['minimumOrderQuantity'] ?? 0,
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : Meta(createdAt: '', updatedAt: '', barcode: '', qrCode: ''),
      images: List<String>.from(json['images'] ?? []),
      thumbnail: json['thumbnail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'tags': tags,
      'brand': brand,
      'sku': sku,
      'weight': weight,
      'dimensions': dimensions.toJson(),
      'warrantyInformation': warrantyInformation,
      'shippingInformation': shippingInformation,
      'availabilityStatus': availabilityStatus,
      'reviews': reviews.map((e) => e.toJson()).toList(),
      'returnPolicy': returnPolicy,
      'minimumOrderQuantity': minimumOrderQuantity,
      'meta': meta.toJson(),
      'images': images,
      'thumbnail': thumbnail,
    };
  }
}

@HiveType(typeId: 1)
class Dimensions {
  @HiveField(0)
  final double width;

  @HiveField(1)
  final double height;

  @HiveField(2)
  final double depth;

  Dimensions({
    required this.width,
    required this.height,
    required this.depth,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) {
    return Dimensions(
      width: (json['width'] ?? 0.0).toDouble(),
      height: (json['height'] ?? 0.0).toDouble(),
      depth: (json['depth'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'width': width,
    'height': height,
    'depth': depth,
  };
}

@HiveType(typeId: 2)
class Review {
  @HiveField(0)
  final double rating;

  @HiveField(1)
  final String comment;

  @HiveField(2)
  final String date;

  @HiveField(3)
  final String reviewerName;

  @HiveField(4)
  final String reviewerEmail;

  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: (json['rating'] ?? 0.0).toDouble(),
      comment: json['comment'] ?? '',
      date: json['date'] ?? '',
      reviewerName: json['reviewerName'] ?? '',
      reviewerEmail: json['reviewerEmail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'rating': rating,
    'comment': comment,
    'date': date,
    'reviewerName': reviewerName,
    'reviewerEmail': reviewerEmail
  };
}

@HiveType(typeId: 3)
class Meta {
  @HiveField(0)
  final String createdAt;

  @HiveField(1)
  final String updatedAt;

  @HiveField(2)
  final String barcode;

  @HiveField(3)
  final String qrCode;

  Meta({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      barcode: json['barcode'] ?? '',
      qrCode: json['qrCode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'barcode': barcode,
    'qrCode': qrCode,
  };
}

@HiveType(typeId: 4)
class ProductResponse {
  @HiveField(0)
  final List<ProductModel> products;

  @HiveField(1)
  final int total;

  @HiveField(2)
  final int skip;

  @HiveField(3)
  final int limit;

  ProductResponse({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      products: (json['products'] as List? ?? [])
          .map((e) => ProductModel.fromJson(e))
          .toList(),
      total: json['total'] ?? 0,
      skip: json['skip'] ?? 0,
      limit: json['limit'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products.map((e) => e.toJson()).toList(),
      'total': total,
      'skip': skip,
      'limit': limit,
    };
  }
}