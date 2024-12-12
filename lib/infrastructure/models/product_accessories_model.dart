class ProductAccessoriesModel {
final String id;
final String accesoryname;
// final String category;
final String categoryId ;

// final String image;
  final List<String> imageUrls;
// final String description;
  final List<String> descriptions;
final String size;
final int stock;
final double price;
final String petType;
  final Map<String, dynamic>? categoryDetails;

ProductAccessoriesModel({
  required this.id,
  required this.accesoryname,
  // required this.category,
   required this.imageUrls,
  // required this.description,
   required this.descriptions,
  required this.price,
  required this.size,
  required this.stock,
  required this.petType,
   required this.categoryId,
   this.categoryDetails

});


// factory ProductAccessoriesModel.fromMap(Map<String, dynamic> map, String id) {
//   return ProductAccessoriesModel(
//     id: id, // Use the document ID passed as a parameter
//     accesoryname: map['accesoryname'] as String? ?? '', // Default to an empty string if null
//     // category: map['category'] as String? ?? '', // Default to an empty string if null
//     imageUrls: List<String>.from(map['imageUrls'] ?? []), // Convert to a list of strings or use an empty list
//     descriptions: List<String>.from(map['descriptions'] ?? []), // Convert to a list of strings or use an empty list
//     price: (map['price'] as num?)?.toDouble() ?? 0.0, // Safely convert price to double, default to 0.0
//     size: map['size'] as String? ?? '', // Default to an empty string if null
//     stock: map['stock'] as int? ?? 0, // Default to 0 if null
//     petType: map['petType'] as String? ?? '',
//     categoryId: map['category'] as String,
//     categoryDetails: map['categoryDetails'] as Map<String, dynamic>?,// Default to an empty string if null
//   );
// }

factory ProductAccessoriesModel.fromMap(Map<String, dynamic> map, String id) {
  return ProductAccessoriesModel(
    id: id, // Use the document ID
    accesoryname: map['accesoryname'] as String? ?? '', // Default to empty string
    imageUrls: List<String>.from(map['imageUrls'] ?? []), // Ensure it's a list or empty
    descriptions: List<String>.from(map['descriptions'] ?? []), // Ensure it's a list or empty
    price: (map['price'] as num?)?.toDouble() ?? 0.0, // Convert to double, default to 0.0
    size: map['size'] as String? ?? '', // Default to empty string
    stock: map['stock'] as int? ?? 0, // Default to 0
    petType: map['petType'] as String? ?? '', // Default to empty string
    categoryId: map['category'] as String? ?? '', // Default to empty string
    categoryDetails: map['categoryDetails'] as Map<String, dynamic>?, // Null if not present
  );
}

Map<String,dynamic>toMap(){
  return{
    'id':id,
    'accesoryname':accesoryname,
    // 'category':category,
      'imageUrls': imageUrls,
    // 'description':description,
     'descriptions': descriptions, 
    'price':price,
    'size':size,
    'stock':stock,
    'petType':petType,
    'categoryId':categoryId,
    'categotDetails':categoryDetails
  };
}

}