class ProductAccessoriesModel {
final String id;
final String accesoryname;
final String category;
// final String image;
  final List<String> imageUrls;
// final String description;
  final List<String> descriptions;
final String size;
final int stock;
final double price;
final String petType;

ProductAccessoriesModel({
  required this.id,
  required this.accesoryname,
  required this.category,
   required this.imageUrls,
  // required this.description,
   required this.descriptions,
  required this.price,
  required this.size,
  required this.stock,
  required this.petType
});

// factory ProductAccessoriesModel.fromJson(Map<String,dynamic>json){
//   return ProductAccessoriesModel(
//     id: json['id'], 
//     accesoryname: json['accesoryname'], 
//     category: json['category'], 
//     imageUrls: List<String>.from(json['imageUrls'] ?? []),
//     // description: json['description'],
//     descriptions: List<String>.from(json['descriptions'] ?? []),
//     price: json['price'], 
//     size: json['size'], 
//     stock: json['stock'], 
//     petType: json['petType']
//     );
// }


// factory ProductAccessoriesModel.fromMap(Map<String,dynamic>map,String id){
//   return ProductAccessoriesModel(
//     id: id,
//     accesoryname:map['accesoryname']as String,
//      category: map['category']as String,

//     );
// }

factory ProductAccessoriesModel.fromMap(Map<String, dynamic> map, String id) {
  return ProductAccessoriesModel(
    id: id, // Use the document ID passed as a parameter
    accesoryname: map['accesoryname'] as String? ?? '', // Default to an empty string if null
    category: map['category'] as String? ?? '', // Default to an empty string if null
    imageUrls: List<String>.from(map['imageUrls'] ?? []), // Convert to a list of strings or use an empty list
    descriptions: List<String>.from(map['descriptions'] ?? []), // Convert to a list of strings or use an empty list
    price: (map['price'] as num?)?.toDouble() ?? 0.0, // Safely convert price to double, default to 0.0
    size: map['size'] as String? ?? '', // Default to an empty string if null
    stock: map['stock'] as int? ?? 0, // Default to 0 if null
    petType: map['petType'] as String? ?? '', // Default to an empty string if null
  );
}

Map<String,dynamic>toMap(){
  return{
    'id':id,
    'accesoryname':accesoryname,
    'category':category,
      'imageUrls': imageUrls,
    // 'description':description,
     'descriptions': descriptions, 
    'price':price,
    'size':size,
    'stock':stock,
    'petType':petType
  };
}

}