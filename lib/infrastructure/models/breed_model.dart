class BreedModel {
  final String id;
  final String name;
  final String categoryId;
  // final String? popularity;
  // final String? ratings;
  // final String?reviews;
  final List<String> imageUrls;
  // final String? description;
  final List<String> descriptions;
  final String size;
  final String careRequirements;
  final double price;
  final Map<String, dynamic>? categoryDetails;
  final int age;
  final int stock;
  // final int year;
  final String gender;

  // final bool? isAvailable;

  BreedModel(
      {required this.id,
      required this.name,
      required this.categoryId,
      // this.popularity,
      // this.reviews,
      // this.ratings,
      required this.imageUrls,
      // this.description,
      required this.descriptions,
      required this.size,
      required this.careRequirements,
      required this.price,
      this.categoryDetails,
      required this.age,
      required this.stock,
      // required this.year,
      required this.gender
      // this.isAvailable,
      });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': categoryId,
      // 'popularity': popularity,
      // 'ratings': ratings,
      'imageUrls': imageUrls,
      // 'description': description,
      'descriptions': descriptions,
      'size': size,
      'careRequirements': careRequirements,
      'price': price,
      'categotDetails': categoryDetails,
      'month': age,
      // 'year': year,
      'gender': gender,
      'stock':stock

      // 'isAvailable': isAvailable,
      // 'reviews': reviews
    };
  }

  factory BreedModel.fromMap(Map<String, dynamic> map, String id) {
    return BreedModel(
        id: id,
        name: map['name'] as String,
         stock: map['stock']as int? ??0,
        categoryId: map['category'] as String,
        // popularity: map['popularity'] as String,
        // ratings: map['ratings'] as String,
        imageUrls: List<String>.from(map['imageUrls'] ?? []),
        // description: json['description'] as String?,
        descriptions: List<String>.from(map['descriptions'] ?? []),
        size: map['size'] as String,
        careRequirements: map['careRequirements'] as String,
        price: (map['price'] as num?)?.toDouble() ?? 0.0,
        categoryDetails: map['categoryDetails'] as Map<String, dynamic>?,
        age: map['month'] as int? ?? 0,
        // year: map['year'] as int? ?? 0,
         gender: map['gender'] as String? ?? '',
        // isAvailable: map['isAvailable'] as bool?,
        // reviews: map['review'] as String,
        );
  }
}
