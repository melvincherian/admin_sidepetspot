// ignore_for_file: camel_case_types

class petProductModel{
  final String id;
  final String category;
  final double price;
  final String description;
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
    required this.description,
    required this.weight,
    // required this.color,
    required this.breed,
    required this.stock,
    // this.imageUrl
        required this.imageUrls,
    

  });

  factory petProductModel.fromJson(Map<String,dynamic>json){
    return petProductModel(
      id: json['id'],
      category: json['category'], 
      price: json['price'], 
      description: json['description'], 
      weight: json['weight'], 
      // color: json['color'], 
      breed: json['breed'], 
      stock: json['stock'],
     imageUrls: List<String>.from(json['imageUrls'] ?? []),
      );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'price': price,
      'description': description,
      'weight': weight,
      // 'color': color,
      'breed': breed,
      'stock': stock,
       'imageUrls': imageUrls,
    };
  }

}