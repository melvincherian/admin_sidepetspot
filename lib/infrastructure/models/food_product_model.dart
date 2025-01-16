class FoodProductModel {
  final String id;
  final String foodname;
  // final String category;
  final String categoryId;
  // final String description;
  final List<String> descriptions;
  final double price;
  final int stock;
  final List<String> imageUrls;
  // final String?image;
  final String foodweight;
  final String packedDate;
  final String endDate;
  final Map<String, dynamic>? categoryDetails;

  FoodProductModel(
      {required this.id,
      required this.foodname,
      required this.descriptions,
      // required this.description,
      required this.price,
      required this.stock,
      required this.foodweight,
      required this.imageUrls,
      required this.packedDate,
      required this.endDate,
      required this.categoryId,
      this.categoryDetails});

  factory FoodProductModel.froMap(Map<String, dynamic> map, String id) {
    return FoodProductModel(
      id: id,
      foodname: map['foodname'],

      // description: json['description'],
      descriptions: List<String>.from(map['descriptions'] ?? []),
      price: map['price'],
      stock: map['stock'],
      foodweight: map['foodweight'],
      packedDate: map['packedDate'],
      endDate: map['endDate'],
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      categoryId: map['category'] as String? ?? '', // Default to empty string
      categoryDetails: map['categoryDetails'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'foodname': foodname,

      'descriptions': descriptions,
      // 'description':description,
      'price': price,
      'stock': stock,
      'foodweight': foodweight,
      'packedDate': packedDate,
      'endDate': endDate,
      'imageUrls': imageUrls,
      'categoryId': categoryId,
      'categotDetails': categoryDetails
    };
  }
}
