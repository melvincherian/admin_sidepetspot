// ignore_for_file: unnecessary_cast

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petspot_admin_side/infrastructure/models/breed_model.dart';

class BreedRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addBreed(BreedModel breed) async {
    try {
      await _firestore.collection('breed').doc().set(breed.toJson());
    } catch (e) {
      print('Error adding breeds $e');
    }
  }

  Stream<List<BreedModel>> fetchBreeds() {
    return _firestore.collection('breed').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) =>
              BreedModel.fromJson(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }

  Future<void> updateBreed(BreedModel breedmodel) async {
    try {
      await _firestore
          .collection('breed')
          .doc(breedmodel.id)
          .update(breedmodel.toJson());
    } catch (e) {
      print('Error updating breeds $e');
    }
  }

  Future<void> deleteBreed(String id) async {
    try {
      await _firestore.collection('breed').doc(id).delete();
    } catch (e) {
      print('Error deleting Breed$e');
    }
  }
}
