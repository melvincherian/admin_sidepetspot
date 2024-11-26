import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petspot_admin_side/bloc/accessories_bloc.dart';
import 'package:petspot_admin_side/bloc/multipleimage_bloc.dart';
import 'package:petspot_admin_side/infrastructure/models/product_accessories_model.dart';
import 'package:petspot_admin_side/presentation/widgets/pet_add_widget.dart';
import 'package:petspot_admin_side/services/image_store.dart';

class AccesoryManagement extends StatefulWidget {
  const AccesoryManagement({super.key});

  @override
  State<AccesoryManagement> createState() => _AccesoryManagementState();
}

class _AccesoryManagementState extends State<AccesoryManagement> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final sizeController = TextEditingController();
  final stockController = TextEditingController();
  final priceController = TextEditingController();
  final petTypeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? selectedCategory;
  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('categories').get();
      setState(() {
        categories = snapshot.docs.map((doc) => doc['name'] as String).toList();
      });
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AccessoriesBloc, AccessoriesState>(
        listener: (context, state) {
          if (state is AccessoriesSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.green,
                content: Text('Accessory Added Successfully')));
            nameController.clear();
            descriptionController.clear();
            sizeController.clear();
            stockController.clear();
            priceController.clear();
            petTypeController.clear();
            setState(() {
              selectedCategory = null;
            });
          } else if (state is AccessoriesFailure) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.red,
                content: Text('Failed to Add Accessory')));
          }
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 45),
                  const Text(
                    'Add Accessories',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal),
                  ),
                  const SizedBox(height: 20),

                  // Image Picker

                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => context
                        .read<MultipleimageBloc>()
                        .add(MultiPickImageEvent()),
                    child: BlocBuilder<MultipleimageBloc, MultipleimageState>(
                      builder: (context, state) {
                        if (state is MultipleImagesuccess) {
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
                        } else if (state is MultipleImageFailure) {
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
                  CustomTextField(
                      controller: nameController,
                      label: 'Accessory Name',
                      validationMessage: 'Please Enter Accessory name'),

                  // Category Dropdown
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: DropdownButtonFormField<String>(
                      value: selectedCategory,
                      items: categories
                          .map((category) => DropdownMenuItem<String>(
                                value: category,
                                child: Text(category),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value!;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please select a category'
                          : null,
                    ),
                  ),

                  CustomTextField(
                      controller: descriptionController,
                      label: 'Description',
                      validationMessage: 'Please Enter Description'),
                  CustomTextField(
                      controller: sizeController,
                      label: 'Size',
                      validationMessage: 'Please Enter Size'),
                  CustomTextField(
                      controller: stockController,
                      label: 'Stock',
                      validationMessage: 'Please Enter the stock'),
                  CustomTextField(
                      controller: priceController,
                      label: 'Price',
                      validationMessage: 'Please Enter price'),
                  CustomTextField(
                      controller: petTypeController,
                      label: 'Pet Type',
                      validationMessage: 'Please Enter Pet Type'),

                  const SizedBox(height: 25),

                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final multipleImageBloc =
                              context.read<MultipleimageBloc>();
                          final imageState = multipleImageBloc.state;
 
                          List<String> imageUrls = [];

                          if (imageState is MultipleImagesuccess) {
                            // Loop through each selected image and upload it to Cloudinary
                            for (var image in imageState.images) {
                              final imageUrl =
                                  await CloudinaryService.uploadImage(image);
                              if (imageUrl != null) {
                                imageUrls.add(imageUrl);
                              }
                            }
                          }

                          final accessory = ProductAccessoriesModel(
                            id: 'id', // Generate a unique ID here
                            accesoryname: nameController.text,
                            category: selectedCategory!,
                            imageUrls:
                                imageUrls, // Add logic to handle image URL
                            description: descriptionController.text,
                            price: double.tryParse(priceController.text) ?? 0,
                            size: sizeController.text,
                            stock: int.parse(stockController.text),
                            petType: petTypeController.text,
                          );

                          context
                              .read<AccessoriesBloc>()
                              .add(AddAccessoriesevent(accessory));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
