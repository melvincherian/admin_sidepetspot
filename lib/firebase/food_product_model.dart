// ignore_for_file: avoid_print, unnecessary_cast

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petspot_admin_side/infrastructure/models/food_product_model.dart';

class Foodrepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void>addFoodproduct(FoodProductModel product) async {
  try {
    await _firestore.collection('foodproducts').add(product.toMap());
  } catch (e) {
    print('Error adding Food accessories $e');
  }
}

  Stream<List<FoodProductModel>> fetchFoodproducts() {
    return _firestore.collection('foodproducts').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) =>
              FoodProductModel.froMap(doc.data() as Map<String, dynamic>,doc.id))
          .toList();
    });
  }

  Future<void> updateFoodproduct(FoodProductModel foodproduct) async {
    try {
      await _firestore
          .collection('foodproducts')
          .doc(foodproduct.id)
          .update(foodproduct.toMap());
    } catch (e) {
      print('Error updating food products$e');
    }
  }

  Future<void> deleteFoodproduct(String id) async {
    try {
      await _firestore.collection('foodproducts').doc(id).delete();
    } catch (e) {
      print('Error deleting food products $e');
    }
  }
}
