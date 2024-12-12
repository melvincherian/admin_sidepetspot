// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petspot_admin_side/bloc/editaccesoryimage_bloc.dart';
import 'package:petspot_admin_side/infrastructure/models/product_accessories_model.dart';
import 'package:petspot_admin_side/services/image_store.dart';

class EditAccessory extends StatefulWidget {
  final ProductAccessoriesModel accessory;
  const EditAccessory({super.key, required this.accessory});

  @override
  State<EditAccessory> createState() => _EditAccessoryState();
}

class _EditAccessoryState extends State<EditAccessory> {
  @override
  Widget build(BuildContext context) {
    final nameController =
        TextEditingController(text: widget.accessory.accesoryname);
    final categoryController =
        TextEditingController(text: widget.accessory.categoryId);
    final DescriptionController =
        TextEditingController(text: widget.accessory.descriptions.join(','));
    final SizeController = TextEditingController(text: widget.accessory.size);
    final stockController =
        TextEditingController(text: widget.accessory.stock.toString());
    final priceController =
        TextEditingController(text: widget.accessory.price.toString());
    final petTypeController =
        TextEditingController(text: widget.accessory.petType);

//         Future<String?> _fetchCategoryId(String categoryName) async {
//   try {
//     final querySnapshot = await FirebaseFirestore.instance
//         .collection('categories')
//         .where('name', isEqualTo: categoryName)
//         .limit(1)
//         .get();

//     if (querySnapshot.docs.isNotEmpty) {
//       return querySnapshot.docs.first.id;
//     }
//     return null;
//   } catch (e) {
//     print('Error fetching category ID: $e');
//     return null;
//   }
// }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Accessory',
          style: TextStyle(
              fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () => context
                    .read<EditaccesoryimageBloc>()
                    .add(EditAccessoryImagePicker()),
                child: BlocBuilder<EditaccesoryimageBloc, EditaccesoryimageState>(
                  builder: (context, state) {
                    if (state is EditaccessoryImageSuccess) {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // Number of images per row
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: state.images.length,
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              state.images[index],
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      );
                    } else if (state is EditaccessoryImageFailure) {
                      return Text(
                        state.errormessage,
                        style: const TextStyle(color: Colors.red),
                      );
                    } else {
                      return const CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                          'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/461fed23287735.599f500689d80.jpg',
                        ),
                        backgroundColor: Colors.grey,
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Acccesory Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: DescriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: SizeController,
                decoration: const InputDecoration(
                  labelText: 'Size',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: stockController,
                decoration: const InputDecoration(
                  labelText: 'Stock',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: petTypeController,
                decoration: const InputDecoration(
                  labelText: 'PetType',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () async {
                       final breedimage =
                            context.read<EditaccesoryimageBloc>();
                        final imageState = breedimage.state;

                        List<String> imageUrls = [];

                        if (imageState is EditaccessoryImageSuccess) {
                          // Loop through each selected image and upload it to Cloudinary
                          for (var image in imageState.images) {
                            final imageUrl =
                                await CloudinaryService.uploadImage(image);
                            if (imageUrl != null) {
                              imageUrls.add(imageUrl);
                            }
                          }
                        }



                    if (nameController.text.isEmpty ||
                        categoryController.text.isEmpty ||
                        DescriptionController.text.isEmpty ||
                        SizeController.text.isEmpty ||
                        stockController.text.isEmpty ||
                        priceController.text.isEmpty ||
                        petTypeController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please enter all fields')));
                      return;
                    }
                    //  final updatedAccesoy=ProductAccessoriesModel(
                    //   id: widget.accessory.id,
                    //   accesoryname: widget.accessory.accesoryname,
                    //   category: widget.accessory.category,
                    //   imageUrls: widget.accessory.imageUrls,
                    //   descriptions: widget.accessory.descriptions,
                    //   price: widget.accessory.price,
                    //   size: widget.accessory.size,
                    //   stock: widget.accessory.stock,
                    //   petType: widget.accessory.petType,

                    //   );

                    //                                                        final categoryId = await _fetchCategoryId(categoryController.text);
                    //                           final categorySnapshot = await FirebaseFirestore.instance
                    // .collection('categories')
                    // .doc(categoryId)
                    // .get();

                    final updatedAccessory = ProductAccessoriesModel(
                      id: widget.accessory.id, // Keep the same ID
                      accesoryname: nameController.text, // Updated name
                      // category: categoryController.text, // Updated category
                     imageUrls: imageUrls,// Assume images are unchanged
                      descriptions: DescriptionController.text
                          .split(',')
                          .map((e) => e.trim())
                          .toList(), // Split descriptions back into a list
                      price: double.tryParse(priceController.text) ??
                          0, // Safely parse price
                      size: SizeController.text, // Updated size
                      stock: int.tryParse(stockController.text) ??
                          0, // Safely parse stock
                      petType: petTypeController.text,
                      categoryId: categoryController.text,

                      // Updated pet type
                    );
                    try {
                      await FirebaseFirestore.instance
                          .collection('accessories')
                          .doc(widget.accessory.id)
                          .update(updatedAccessory.toMap());
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('Accessory updated successfully!')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('Failed to update Accessories: $e')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
