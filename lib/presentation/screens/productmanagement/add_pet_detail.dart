import 'package:flutter/material.dart';
import 'package:petspot_admin_side/infrastructure/models/pet_add_model.dart';

class AddPetDetail extends StatelessWidget {
  final petProductModel product;

  const AddPetDetail({super.key, required this.product});
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display Image
            Center(
              child: product.imageUrl != null
                  ? Image.network(product.imageUrl!, height: 200, width: 200, fit: BoxFit.cover)
                  : const Icon(Icons.pets, size: 100, color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // Display each detail
            _buildDetailItem('Category', product.category),
            _buildDetailItem('Price', '\$${product.price.toString()}'),
            _buildDetailItem('Description', product.description),
            _buildDetailItem('Weight', product.weight),
            _buildDetailItem('Color', product.color),
            _buildDetailItem('Breed', product.breed),
            _buildDetailItem('Stock', product.stock.toString()),
            _buildDetailItem('Availability', product.stock > 0 ? 'In Stock' : 'Out of Stock'),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
