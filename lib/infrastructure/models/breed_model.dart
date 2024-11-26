class BreedModel {
  final String id;
  final String name;
  final String category;
  final String? popularity;
  final String? ratings;
  final String?reviews;
    final List<String> imageUrls;
  final String? description;
  final String? size;
  final String? careRequirements;
  final String? priceRange;
  final bool? isAvailable;

  BreedModel({
    required this.id,
    required this.name,
    required this.category,
    this.popularity,
    this.reviews,
    this.ratings,
     required this.imageUrls,
    this.description,
    this.size,
    this.careRequirements,
    this.priceRange,
    this.isAvailable,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'popularity': popularity,
      'ratings': ratings,
        'imageUrls': imageUrls,
      'description': description,
      'size': size,
      'careRequirements': careRequirements,
      'priceRange': priceRange,
      'isAvailable': isAvailable,
      'reviews': reviews
    };
  }

  factory BreedModel.fromJson(Map<String, dynamic> json, String id) {
    return BreedModel(
      id: id,
      name: json['name'] as String,
      category: json['category'] as String,
      popularity: json['popularity'] as String,
      ratings: json['ratings'] as String,
       imageUrls: List<String>.from(json['imageUrls'] ?? []),
      description: json['description'] as String?,
      size: json['size'] as String?,
      careRequirements: json['careRequirements'] as String?,
      priceRange: json['priceRange'] as String?,
      isAvailable: json['isAvailable'] as bool?,
      reviews: json['review'] as String,
    );
  }
}
