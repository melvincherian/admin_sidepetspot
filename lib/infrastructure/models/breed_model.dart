class BreedModel {
  final String id;
  final String name;
  final String category;
  // final String? popularity;
  // final String? ratings;
  // final String?reviews;
    final List<String> imageUrls;
  // final String? description;
    final List<String> descriptions;
  final String  size;
  final String  careRequirements;
 final double price;
  // final bool? isAvailable;

  BreedModel({
    required this.id,
    required this.name,
    required this.category,
    // this.popularity,
    // this.reviews,
    // this.ratings,
     required this.imageUrls,
    // this.description,
    required this.descriptions,
    required this.size,
     required this.careRequirements,
     required this.price,
    // this.isAvailable,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      // 'popularity': popularity,
      // 'ratings': ratings,
        'imageUrls': imageUrls,
      // 'description': description,
       'descriptions': descriptions,
      'size': size,
      'careRequirements': careRequirements,
       'price':price,
      // 'isAvailable': isAvailable,
      // 'reviews': reviews
    };
  }

  factory BreedModel.fromMap(Map<String, dynamic> map, String id) {
    return BreedModel(
      id: id,
      name: map['name'] as String,
      category: map['category'] as String,
      // popularity: map['popularity'] as String,
      // ratings: map['ratings'] as String,
       imageUrls: List<String>.from(map['imageUrls'] ?? []),
      // description: json['description'] as String?,
         descriptions: List<String>.from(map['descriptions'] ?? []),
      size: map['size'] as String,
      careRequirements: map['careRequirements'] as String,
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      // isAvailable: map['isAvailable'] as bool?,
      // reviews: map['review'] as String,
    );
  }
}
