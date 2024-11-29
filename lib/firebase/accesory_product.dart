// ignore_for_file: avoid_print, unnecessary_cast

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petspot_admin_side/infrastructure/models/product_accessories_model.dart';

class AccessoryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addAccessories(ProductAccessoriesModel accessory) async {
  try {
    await _firestore.collection('accessories').add(accessory.toMap());
  } catch (e) {
    print('Error adding Food accessories $e');
  }
}

  Stream<List<ProductAccessoriesModel>> fetchAccesories() {
    return _firestore
        .collection('accessories')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ProductAccessoriesModel.fromMap(
              doc.data() as Map<String, dynamic>,doc.id))
          .toList();
    });
  }

  Future<void> updateAccessories(
      ProductAccessoriesModel accesories) async {
    try {
      await _firestore
          .collection('accessories')
          .doc(accesories.id)
          .update(accesories.toMap());
    } catch (e) {
      print('Error updating accessories$e');
    }
  }

  Future<void> deleteAccessories(String id) async {
    try {
      await _firestore.collection('accessories').doc(id).delete();
    } catch (e) {
      print('Error deleting Accessories$e');
    }
  }
}
