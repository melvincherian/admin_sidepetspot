class FoodProductModel {
  final String id;
  final String foodname;
  final String category;
  // final String description;
  final List<String> descriptions;
  final double price;
  final int stock;
   final List<String> imageUrls;
  // final String?image;
  final String foodweight;
  final String packedDate;
  final String endDate;

  FoodProductModel({
    required this.id,
    required this.foodname,
    required this.category,
     required this.descriptions,
    // required this.description,
    required this.price,
    required this.stock,
    required this.foodweight,
       required this.imageUrls,
    required this.packedDate,
    required this.endDate

  });

  factory FoodProductModel.froMap(Map<String,dynamic>map,String id){
    return FoodProductModel(
      id: map['id'],
      foodname: map['foodname'], 
      category: map['category'], 
      // description: json['description'],
       descriptions: List<String>.from(map['descriptions'] ?? []),
      price: map['price'], 
      stock: map['stock'], 
      foodweight: map['foodweight'],
      packedDate: map['packedDate'],
      endDate: map['endDate'],
        imageUrls: List<String>.from(map['imageUrls'] ?? []),
      
      );
  }

  Map<String,dynamic>toJson(){
    return {
      'id':id,
      'foodname':foodname,
      'category':category,
      'descriptions': descriptions, 
      // 'description':description,
      'price':price,
      'stock':stock,
      'foodweight':foodweight,
      'packedDate':packedDate,
      'endDate':endDate,
       'imageUrls': imageUrls,
    };

  }

}