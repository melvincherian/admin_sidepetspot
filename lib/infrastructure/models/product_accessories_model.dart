class ProductAccessoriesModel {
final String id;
final String accesoryname;
final String category;
final String image;
final String description;
final String size;
final int stock;
final double price;
final String petType;

ProductAccessoriesModel({
  required this.id,
  required this.accesoryname,
  required this.category,
  required this.image,
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
    image: json['image'], 
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
    'image':image,
    'description':description,
    'price':price,
    'size':size,
    'stock':stock,
    'petType':petType
  };
}

}