import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentModel {
  final String id;
  final String userReference;
  final String paymentStatus;
  // final String transactionId;
  final String paymentmethod;
  final String orderId;
  final String createdAt;
  final String orderStatus;
  final double totalAmount;
  final double shippingFee;
  final double taxFee;
  final double delivery;
  final String adrress;

  final List<PaymentItems> payment;

  PaymentModel(
      {required this.id,
      required this.userReference,
      required this.payment,
      required this.paymentStatus,
      // required this.transactionId,
      required this.paymentmethod,
      required this.orderId,
      required this.createdAt,
      required this.orderStatus,
      required this.totalAmount,
      required this.shippingFee,
      required this.taxFee,
      required this.delivery,
      required this.adrress
      });
      // }): totalAmount = payment.fold(0.0, (sum, item) => sum + item.subtotal);

  factory PaymentModel.fromMap(Map<String, dynamic> map, String id) {
    return PaymentModel(
        id: id,
        userReference: map['userReference'] as String,
        payment: List<PaymentItems>.from(
          (map['payment'] as List<dynamic>).map(
            (pay) => PaymentItems.fromMap(pay as Map<String, dynamic>),
          ),
        ),
        paymentStatus: map['paymentStatus'] as String,
        // transactionId: map['transactionId'] as String,
        paymentmethod: map['paymentmethod'] as String,
        createdAt: map['createdAt']?? Timestamp.now(),
        orderStatus: map['orderStatus']as String,
        totalAmount: (map['totalAmount'] as num?)?.toDouble() ?? 0.0,
        shippingFee: (map['shippingFee']as num?)?.toDouble() ?? 0.0,
        taxFee: (map['taxFee']as num?)?.toDouble() ??0.0,
        delivery: (map['delivery']as num?)?.toDouble() ?? 0.0,
        adrress: map['adrress']as String,
        orderId: map['orderId'] as String);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userReference': userReference,
      'payment': payment.map((item) => item.toMap()).toList(),
      'paymentStatus': paymentStatus,
      // 'transactionId': transactionId,
      'paymentmethod': paymentmethod,
      'orderId': orderId,
      'createdAt':createdAt,
      'orderStatus':orderStatus,
      'totalAmount': totalAmount,
      'shippingFee':shippingFee,
      'taxFee':taxFee,
      'delivery':delivery,
      'adrress':adrress
    };
  }
}

class PaymentItems {
  final String productReference;
  final double price;
  final double subtotal;

  PaymentItems({
    required this.productReference,
    required this.price,
    required this.subtotal,
  });

  factory PaymentItems.fromMap(Map<String, dynamic> map) {
    return PaymentItems(
      productReference: map['productReference'] as String,
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      subtotal: (map['subtotal'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productReference': productReference,
      'price': price,
      'subtotal': subtotal,
    };
  }
}
