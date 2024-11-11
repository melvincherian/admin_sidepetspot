class FoodProductModel {
  final String id;
  final String foodname;
  final String category;
  final String description;
  final double price;
  final int stock;
  final String?image;
  final String foodweight;

  FoodProductModel({
    required this.id,
    required this.foodname,
    required this.category,
    required this.description,
    required this.price,
    required this.stock,
    required this.foodweight,
    this.image
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
      'foodweight':foodweight
    };

  }

}