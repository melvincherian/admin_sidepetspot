// ignore_for_file: avoid_print, unnecessary_cast

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petspot_admin_side/infrastructure/models/pet_add_model.dart';

class ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addProduct(petProductModel product) async {
    try {
      await _firestore.collection('products').doc().set(product.toJson());
    } catch (e) {
      print('Error adding product :$e');
    }
  }

  Stream<List<petProductModel>> fetchProducts() {
    return _firestore.collection('products').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) =>
              petProductModel.fromMap(doc.data() as Map<String, dynamic>,doc.id))
          .toList();
    });
  }

  Future<petProductModel?> getProductById(String productId) async {
    try {
      var doc = await _firestore.collection('products').doc(productId).get();
      if (doc.exists) {
        return petProductModel.fromMap(doc.data() as Map<String, dynamic>,doc.id);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching products $e');
      return null;
    }
  }

  // Future<void> updateProduct(
  //     String productId, petProductModel updateProduct) async {
  //   try {
  //     await _firestore
  //         .collection('products')
  //         .doc(productId)
  //         .update(updateProduct.toJson());
  //   } catch (e) {
  //     print('Error updating product: $e');
  //   }
  // }
   Future<void> updateProduct(petProductModel productId) async {
    final docRef = FirebaseFirestore.instance.collection('products').doc(productId.id);
    await docRef.update(productId.toJson()); // Update existing product
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _firestore.collection('products').doc(productId).delete();
    } catch (e) {
      print('Error deleting product: $e');
    }
  }
}
