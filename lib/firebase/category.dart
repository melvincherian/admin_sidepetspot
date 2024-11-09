import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petspot_admin_side/infrastructure/category_model.dart';

class CategoryRepository{
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  Future<void>addCategory(Category category)async{
    await _firestore.collection('categories').doc(category.id).set(category.toMap());
  }

  Stream<List<Category>>fetchCategories(){
    return _firestore.collection('categories').snapshots().map((snapshot)=>
    snapshot.docs.map((doc)=>Category.fromMap(doc.data(),doc.id)).toList());
    
  }

}