class ProductEntity {
  final List<ProductItemEntity> products;
  final int total;
  final int skip;
  final int limit;

  const ProductEntity({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });
}

class ProductItemEntity {
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
  final List<ReviewEntity> reviews;
  final MetaEntity meta;
  final List<String> images;
  final String thumbnail;

  const ProductItemEntity({
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
}

class MetaEntity {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String barcode;
  final String qrCode;

  const MetaEntity({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });
}

class ReviewEntity {
  final int rating;
  final String comment;
  final DateTime date;
  final String reviewerName;
  final String reviewerEmail;

  const ReviewEntity({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });
}
