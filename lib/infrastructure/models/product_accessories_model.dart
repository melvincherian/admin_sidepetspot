class ProductAccessoriesModel {
final String id;
final String accesoryname;
final String category;
// final String image;
  final List<String> imageUrls;
final String description;
final String size;
final int stock;
final double price;
final String petType;

ProductAccessoriesModel({
  required this.id,
  required this.accesoryname,
  required this.category,
   required this.imageUrls,
  required this.description,
  required this.price,
  required this.size,
  required this.stock,
  required this.petType
});

factory ProductAccessoriesModel.fromJson(Map<String,dynamic>json){
  return ProductAccessoriesModel(
    id: json['id'], 
    accesoryname: json['accesoryname'], 
    category: json['category'], 
    imageUrls: List<String>.from(json['imageUrls'] ?? []),
    description: json['description'], 
    price: json['price'], 
    size: json['size'], 
    stock: json['stock'], 
    petType: json['petType']
    );
}

Map<String,dynamic>toMap(){
  return{
    'id':id,
    'accesoryname':accesoryname,
    'category':category,
      'imageUrls': imageUrls,
    'description':description,
    'price':price,
    'size':size,
    'stock':stock,
    'petType':petType
  };
}

}