class CarouselImageModel {
  final List<String>imageUrls;

  CarouselImageModel({
    required this.imageUrls
  });

  factory CarouselImageModel.fromMap(Map<String,dynamic>map,String id){
    return CarouselImageModel(
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      );
  }
  Map<String,dynamic>toMap(){
    return {
    'image':imageUrls,
    };
  }
}