import 'package:cloud_firestore/cloud_firestore.dart';

class CarouselImageRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  
  CollectionReference get _carouselCollection =>
      _firestore.collection('carousel_images');


  Future<void> addImageUrls(List<String> imageUrls) async {
    try {
      await _carouselCollection.add({
        'imageUrls': imageUrls,
        // 'createdAt': FieldValue.serverTimestamp(), // Optional: Add a timestamp
      });
    } catch (e) {
      throw Exception('Error adding image URLs: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchAllImages() async {
    try {
      QuerySnapshot snapshot = await _carouselCollection.get();
      return snapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
          .toList();
    } catch (e) {
      throw Exception('Error fetching images: $e');
    }
  }

  Future<void> deleteImageSet(String documentId) async {
    try {
      await _carouselCollection.doc(documentId).delete();
    } catch (e) {
      throw Exception('Error deleting image set: $e');
    }
  }
}
