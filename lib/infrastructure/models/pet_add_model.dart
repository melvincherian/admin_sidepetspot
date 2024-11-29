// ignore_for_file: camel_case_types

class petProductModel{
  final String id;
  final String category;
  final double price;
  // final String description;
  final List<String> descriptions;
  final String weight;
  // final String color;
  final String breed;
  final int stock;
  // final String?imageUrl;
  final List<String> imageUrls;
  

  petProductModel({
    required this.id,
    required this.category,
    required this.price,
    // required this.description,
     required this.descriptions,
    required this.weight,
    // required this.color,
    required this.breed,
    required this.stock,
    // this.imageUrl
        required this.imageUrls,
    

  });

  // factory petProductModel.fromMap(Map<String,dynamic>map,String id){
  //   return petProductModel(
  //     id: map['id'],
  //     category: map['category'], 
  //     price: map['price'], 
  //     // description: json['description'], 
  //     descriptions: List<String>.from(map['descriptions'] ?? []),
  //     weight: map['weight'], 
  //     // color: json['color'], 
  //     breed: map['breed'], 
  //     stock: map['stock'],
  //    imageUrls: List<String>.from(map['imageUrls'] ?? []),
  //     );
  // }
   factory petProductModel.fromMap(Map<String, dynamic> map, String id) {
    return petProductModel(
      id: id,
      category: map['category'] as String? ?? 'Unknown',
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      descriptions: List<String>.from(map['descriptions'] ?? []),
      weight: map['weight'] as String? ?? 'Unknown',
      breed: map['breed'] as String? ?? 'Unknown',
      stock: map['stock'] as int? ?? 0,
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'price': price,
      // 'description': description,
       'descriptions': descriptions, 
      'weight': weight,
      // 'color': color,
      'breed': breed,
      'stock': stock,
       'imageUrls': imageUrls,
    };
  }

}