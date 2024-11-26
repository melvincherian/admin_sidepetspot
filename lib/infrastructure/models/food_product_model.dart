class FoodProductModel {
  final String id;
  final String foodname;
  final String category;
  final String description;
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
    required this.description,
    required this.price,
    required this.stock,
    required this.foodweight,
       required this.imageUrls,
    required this.packedDate,
    required this.endDate

  });

  factory FoodProductModel.fromJson(Map<String,dynamic>json){
    return FoodProductModel(
      id: json['id'],
      foodname: json['foodname'], 
      category: json['category'], 
      description: json['description'], 
      price: json['price'], 
      stock: json['stock'], 
      foodweight: json['foodweight'],
      packedDate: json['packedDate'],
      endDate: json['endDate'],
        imageUrls: List<String>.from(json['imageUrls'] ?? []),
      
      );
  }

  Map<String,dynamic>toJson(){
    return {
      'id':id,
      'foodname':foodname,
      'category':category,
      'description':description,
      'price':price,
      'stock':stock,
      'foodweight':foodweight,
      'packedDate':packedDate,
      'endDate':endDate,
       'imageUrls': imageUrls,
    };

  }

}