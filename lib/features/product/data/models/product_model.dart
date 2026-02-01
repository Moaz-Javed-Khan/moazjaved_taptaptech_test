import 'dart:convert';

import '../../domain/entities/product_entity.dart';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  final List<Product> products;
  final int total;
  final int skip;
  final int limit;

  ProductModel({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  ProductModel copyWith({
    List<Product>? products,
    int? total,
    int? skip,
    int? limit,
  }) => ProductModel(
    products: products ?? this.products,
    total: total ?? this.total,
    skip: skip ?? this.skip,
    limit: limit ?? this.limit,
  );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    products: (json["products"] as List? ?? [])
        .map((x) => Product.fromJson(x ?? {}))
        .toList(),
    total: json["total"] ?? 0,
    skip: json["skip"] ?? 0,
    limit: json["limit"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
    "total": total,
    "skip": skip,
    "limit": limit,
  };

  ProductEntity toEntity() {
    return ProductEntity(
      products: products.map((e) => e.toEntity()).toList(),
      total: total,
      skip: skip,
      limit: limit,
    );
  }
}

class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String brand;
  final List<Review> reviews;
  final Meta meta;
  final List<String> images;
  final String thumbnail;

  Product({
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
    required this.reviews,
    required this.meta,
    required this.images,
    required this.thumbnail,
  });

  Product copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    double? price,
    double? discountPercentage,
    double? rating,
    int? stock,
    List<String>? tags,
    String? brand,
    List<Review>? reviews,
    Meta? meta,
    List<String>? images,
    String? thumbnail,
  }) => Product(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    category: category ?? this.category,
    price: price ?? this.price,
    discountPercentage: discountPercentage ?? this.discountPercentage,
    rating: rating ?? this.rating,
    stock: stock ?? this.stock,
    tags: tags ?? this.tags,
    brand: brand ?? this.brand,
    reviews: reviews ?? this.reviews,
    meta: meta ?? this.meta,
    images: images ?? this.images,
    thumbnail: thumbnail ?? this.thumbnail,
  );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"] ?? 0,
    title: json["title"] ?? "",
    description: json["description"] ?? "",
    category: json["category"] ?? "",
    price: (json["price"] ?? 0).toDouble(),
    discountPercentage: (json["discountPercentage"] ?? 0).toDouble(),
    rating: (json["rating"] ?? 0).toDouble(),
    stock: json["stock"] ?? 0,

    tags: (json["tags"] as List? ?? [])
        .map((x) => x?.toString() ?? "")
        .toList(),

    brand: json["brand"] ?? "",

    reviews: (json["reviews"] as List? ?? [])
        .map((x) => Review.fromJson(x ?? {}))
        .toList(),

    meta: Meta.fromJson(json["meta"] ?? {}),

    images: (json["images"] as List? ?? [])
        .map((x) => x?.toString() ?? "")
        .toList(),

    thumbnail: json["thumbnail"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "category": category,
    "price": price,
    "discountPercentage": discountPercentage,
    "rating": rating,
    "stock": stock,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "brand": brand,
    "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
    "meta": meta.toJson(),
    "images": List<dynamic>.from(images.map((x) => x)),
    "thumbnail": thumbnail,
  };

  ProductItemEntity toEntity() {
    return ProductItemEntity(
      id: id,
      title: title,
      description: description,
      category: category,
      price: price,
      discountPercentage: discountPercentage,
      rating: rating,
      stock: stock,
      tags: tags,
      brand: brand,
      reviews: reviews.map((e) => e.toEntity()).toList(),
      meta: meta.toEntity(),
      images: images,
      thumbnail: thumbnail,
    );
  }
}

class Meta {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String barcode;
  final String qrCode;

  Meta({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });

  Meta copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? barcode,
    String? qrCode,
  }) => Meta(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    barcode: barcode ?? this.barcode,
    qrCode: qrCode ?? this.qrCode,
  );

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    createdAt: DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
    updatedAt: DateTime.tryParse(json["updatedAt"] ?? "") ?? DateTime.now(),
    barcode: json["barcode"] ?? "",
    qrCode: json["qrCode"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "barcode": barcode,
    "qrCode": qrCode,
  };

  MetaEntity toEntity() {
    return MetaEntity(
      createdAt: createdAt,
      updatedAt: updatedAt,
      barcode: barcode,
      qrCode: qrCode,
    );
  }
}

class Review {
  final int rating;
  final String comment;
  final DateTime date;
  final String reviewerName;
  final String reviewerEmail;

  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  Review copyWith({
    int? rating,
    String? comment,
    DateTime? date,
    String? reviewerName,
    String? reviewerEmail,
  }) => Review(
    rating: rating ?? this.rating,
    comment: comment ?? this.comment,
    date: date ?? this.date,
    reviewerName: reviewerName ?? this.reviewerName,
    reviewerEmail: reviewerEmail ?? this.reviewerEmail,
  );

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    rating: json["rating"] ?? 0,
    comment: json["comment"] ?? "",
    date: DateTime.tryParse(json["date"] ?? "") ?? DateTime.now(),
    reviewerName: json["reviewerName"] ?? "",
    reviewerEmail: json["reviewerEmail"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "rating": rating,
    "comment": comment,
    "date": date.toIso8601String(),
    "reviewerName": reviewerName,
    "reviewerEmail": reviewerEmail,
  };

  ReviewEntity toEntity() {
    return ReviewEntity(
      rating: rating,
      comment: comment,
      date: date,
      reviewerName: reviewerName,
      reviewerEmail: reviewerEmail,
    );
  }
}
