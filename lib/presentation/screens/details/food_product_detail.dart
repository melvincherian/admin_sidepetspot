import 'package:flutter/material.dart';
import 'package:petspot_admin_side/infrastructure/models/food_product_model.dart';

class FoodProductDetailsScreen extends StatelessWidget {
  final FoodProductModel foodProduct;

  const FoodProductDetailsScreen({super.key, required this.foodProduct});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Product Details'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Food Name: ${foodProduct.foodname}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Category: ${foodProduct.category}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Description: ${foodProduct.description}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Price: \$${foodProduct.price}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Stock: ${foodProduct.stock}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Weight: ${foodProduct.foodweight}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Packed Date: ${foodProduct.packedDate}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'End Date: ${foodProduct.endDate}',
              style: const TextStyle(fontSize: 16),
            ),
            // You can also display the image if available.
            // if (foodProduct.image != null)
            //   Image.file(foodProduct.image, height: 120, width: 120),
          ],
        ),
      ),
    );
  }
}
