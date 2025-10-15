/// Base Entity
/// جميع الـ Entities يجب أن ترث من هذا الـ Class
abstract class BaseEntity {
  const BaseEntity();
}

/// Base Model
/// جميع الـ Models يجب أن ترث من هذا الـ Class
abstract class BaseModel {
  const BaseModel();

  /// Convert Model to Entity
  BaseEntity toEntity();

  /// Convert Model to JSON
  Map<String, dynamic> toJson();
}

/// Converter interface
abstract class EntityModelConverter<E extends BaseEntity, M extends BaseModel> {
  /// Convert Model to Entity
  E toEntity(M model);

  /// Convert Entity to Model
  M toModel(E entity);
}

/// Example Implementation:
/// 
/// ```dart
/// // Domain Layer - Entity
/// class ProductEntity extends BaseEntity {
///   final int id;
///   final String name;
///   final String description;
///   final double price;
///   final String image;
///   final double rating;
/// 
///   const ProductEntity({
///     required this.id,
///     required this.name,
///     required this.description,
///     required this.price,
///     required this.image,
///     required this.rating,
///   });
/// }
/// 
/// // Data Layer - Model
/// class ProductModel extends BaseModel {
///   final int id;
///   final String name;
///   final String description;
///   final double price;
///   final String image;
///   final double rating;
/// 
///   const ProductModel({
///     required this.id,
///     required this.name,
///     required this.description,
///     required this.price,
///     required this.image,
///     required this.rating,
///   });
/// 
///   @override
///   ProductEntity toEntity() {
///     return ProductEntity(
///       id: id,
///       name: name,
///       description: description,
///       price: price,
///       image: image,
///       rating: rating,
///     );
///   }
/// 
///   factory ProductModel.fromJson(Map<String, dynamic> json) {
///     return ProductModel(
///       id: json['id'],
///       name: json['name'],
///       description: json['description'],
///       price: (json['price'] as num).toDouble(),
///       image: json['image'],
///       rating: (json['rating'] as num).toDouble(),
///     );
///   }
/// 
///   @override
///   Map<String, dynamic> toJson() {
///     return {
///       'id': id,
///       'name': name,
///       'description': description,
///       'price': price,
///       'image': image,
///       'rating': rating,
///     };
///   }
/// 
///   factory ProductModel.fromEntity(ProductEntity entity) {
///     return ProductModel(
///       id: entity.id,
///       name: entity.name,
///       description: entity.description,
///       price: entity.price,
///       image: entity.image,
///       rating: entity.rating,
///     );
///   }
/// }
/// ```
