// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petspot_admin_side/infrastructure/models/food_product_model.dart';

class FoodProductDetail extends StatelessWidget {
  const FoodProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          'Food Details',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 4.0,
        backgroundColor: Colors.teal,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('foodproducts').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No accessories available'));
            }

            final food = snapshot.data!.docs.map((doc) {
              return FoodProductModel.froMap(
                doc.data() as Map<String, dynamic>,
                doc.id,
              );
            }).toList();

             return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                itemCount: food.length,
                itemBuilder: (context, index) {
                  final foods = food[index];

                  return Padding(
                    padding:
                    const    EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16.0),
                        leading: foods.imageUrls.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  foods.imageUrls.first,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, progress) {
                                    if (progress == null) return child;
                                    return CircularProgressIndicator(
                                      value: progress.expectedTotalBytes != null
                                          ? progress.cumulativeBytesLoaded /
                                              (progress.expectedTotalBytes ?? 1)
                                          : null,
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.broken_image,
                                      size: 50,
                                      color: Colors.grey,
                                    );
                                  },
                                ),
                              )
                            : const Icon(
                                Icons.image,
                                size: 50,
                                color: Colors.grey,
                              ),
                        title: Text(
                          foods.foodname,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (foods.category.isNotEmpty)
                              Text(
                                'Category: ${foods.category}',
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black54),
                              ),
                                if (foods.descriptions.isNotEmpty)
                              Text(
                                'Description: ${foods.descriptions.join(', ')}',
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black54),
                              ),
                            // if (breeds.descriptions.isNotEmpty)
                              Text(
                                'Price: ${foods.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black54),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            // if (foods.stock.isNotEmpty)
                              Text(
                                'Stock: ${foods.stock}',
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black54),
                              ),
                            Text(
                              'Foodweight: ${foods.foodweight}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black54),
                            ),
                            Text(
                              'Start Date: \$${foods.packedDate}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black54),
                            ),
                            Text(
                              'End Date: \$${foods.endDate}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black54),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () async {
                                final shouldDelete = await showDialog<bool>(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Delete Accessory'),
                                      content: const Text(
                                          'Are you sure you want to delete this accessory?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(true),
                                          child: const Text('Delete'),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                if (shouldDelete == true) {
                                  try {
                                    await FirebaseFirestore.instance
                                        .collection('foodproducts')
                                        .doc(foods.id)
                                        .delete();

                                   
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Foods deleted successfully.'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } catch (error) {
                                    // Show error message
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Failed to delete foods: $error'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
