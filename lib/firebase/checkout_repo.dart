// ignore_for_file: unnecessary_null_comparison, prefer_final_fields, unnecessary_cast

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petspot_admin_side/infrastructure/models/payment_model.dart';


class CheckoutRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

 Future<void> addPayment(PaymentModel payment) async {
  if (payment.userReference.isEmpty) {
    throw ArgumentError('User reference cannot be empty');
  }

  try {
    final paymentCollectionPath = 'users/${payment.userReference}/payments/${payment.id}';
    final paymentCollectionRef = _firestore.doc(paymentCollectionPath);

    print('Writing to Firestore path: $paymentCollectionPath');
    await paymentCollectionRef.set(payment.toMap());
    await _firestore.collection('payment').add(payment.toMap());
    print('Payment successfully added.');
  } catch (e) {
    print('Error adding payment: $e');
    throw Exception('Failed to add payment');
  }
  
}


 


  Stream<List<PaymentModel>> fetchPayments(String userId) {
  return _firestore
      .collection('users')
      .doc(userId)
      .collection('payments')
      .snapshots()
      .map((snapshot) {
    try {
      return snapshot.docs.map((doc) {
        return PaymentModel.fromMap(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();
    } catch (e) {
      print('Error parsing payments: $e');
      return [];
    }
  });
}

}
