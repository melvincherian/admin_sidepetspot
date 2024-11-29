import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petspot_admin_side/infrastructure/models/product_accessories_model.dart';
import 'package:petspot_admin_side/presentation/screens/edit_accessory.dart';

class AccessoryList extends StatelessWidget {
  const AccessoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Accessory List',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 4.0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('accessories').snapshots(),
        builder: (context, snapshot) {
          // Loading Indicator
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error Handling
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // No Data Available
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No accessories available'));
          }

          final accessories = snapshot.data!.docs.map((doc) {
            return ProductAccessoriesModel.fromMap(
              doc.data() as Map<String, dynamic>,
              doc.id,
            );
          }).toList();

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            itemCount: accessories.length,
            itemBuilder: (context, index) {
              final accessory = accessories[index];

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                    leading: accessory.imageUrls.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              accessory.imageUrls.first,
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
                      accessory.accesoryname,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (accessory.category.isNotEmpty)
                          Text(
                            'Category: ${accessory.category}',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black54),
                          ),
                        if (accessory.descriptions.isNotEmpty)
                          Text(
                            'Description: ${accessory.descriptions.join(', ')}',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black54),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        if (accessory.size.isNotEmpty)
                          Text(
                            'Size: ${accessory.size}',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black54),
                          ),
                        Text(
                          'Stock: ${accessory.stock}',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black54),
                        ),
                        Text(
                          'Price: \$${accessory.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black54),
                        ),
                        if (accessory.petType.isNotEmpty)
                          Text(
                            'Pet Type: ${accessory.petType}',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black54),
                          ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditAccessory(
                                  accessory: accessory,
                                ),
                              ),
                            );
                          },
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
                                    .collection('accessories')
                                    .doc(accessory.id)
                                    .delete();

                                // Show success message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Accessory deleted successfully.'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              } catch (error) {
                                // Show error message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Failed to delete accessory: $error'),
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
            },
          );
        },
      ),
    );
  }
}
