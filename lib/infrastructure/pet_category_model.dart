class Category {

final String id;
final String name;
final String description;
final String ?image;

Category({
  required this.id,
  required this.name,
  required this.description,
  required this.image
  

});

Map<String,dynamic>toMap(){
  return {
    'id':id,
    'name':name,
    'description':description,
    'image':image
  };
}

 factory Category.fromMap(Map<String, dynamic> map, String id) {
    return Category(
      id: id,
      name: map['name'] as String,
      description: map['description'] as String,
      image: map['image'],
    );
  }

}