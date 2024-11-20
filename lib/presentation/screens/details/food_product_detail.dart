import 'package:flutter/material.dart';
import 'package:petspot_admin_side/infrastructure/models/food_product_model.dart';

class FoodProductDetail extends StatelessWidget {
  final FoodProductModel product;
  
  const FoodProductDetail({super.key, required this.product});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.foodname),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.image != null)
              Center(
                child: Image.network(
                  product.image!,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 20),
            Text('Name: ${product.foodname}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Category: ${product.category}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Description: ${product.description}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Price: \$${product.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Stock: ${product.stock}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Weight: ${product.foodweight}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Packed Date: ${product.packedDate}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('End Date: ${product.endDate}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
