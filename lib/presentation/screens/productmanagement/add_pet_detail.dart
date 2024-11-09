import 'package:flutter/material.dart';
import 'package:petspot_admin_side/infrastructure/models/pet_add_model.dart';

class AddPetDetail extends StatelessWidget {
  final petProductModel product;

  const AddPetDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Center(
              child: product.imageUrl != null
                  ? Image.network(
                      product.imageUrl!,
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 200,
                      width: 200,
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.image,
                        size: 50,
                      ),
                    ),
            ),
            const SizedBox(height: 16),

            // Category
            _buildDetailRow('Category', product.category),

            // Price
            _buildDetailRow('Price', '\$${product.price.toStringAsFixed(2)}'),

            // Description
            _buildDetailRow('Description', product.description),

            // Quantity
   

            // Weight
            _buildDetailRow('Weight', product.weight),

            // Color
            _buildDetailRow('Color', product.color),

            // Pet Type
            // Breed
            _buildDetailRow('Breed', product.breed),

            // Stock
            _buildDetailRow('Stock', product.stock.toString()),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
