// ignore_for_file: depend_on_referenced_packages, use_super_parameters, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petspot_admin_side/bloc/breed_bloc.dart';
import 'package:petspot_admin_side/bloc/multipleimage_bloc.dart';
import 'package:petspot_admin_side/infrastructure/models/breed_model.dart';
import 'package:petspot_admin_side/presentation/widgets/breed_textfield.dart';
import 'package:petspot_admin_side/services/image_store.dart';
// Adjust import based on your project structure

class PetBreed extends StatefulWidget {
  const PetBreed({Key? key}) : super(key: key);

  @override
  State<PetBreed> createState() => _PetBreedState();
}

class _PetBreedState extends State<PetBreed> {
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
    final nameController = TextEditingController();
    final categoryController = TextEditingController();
    final descriptionController = TextEditingController();
    final sizeController = TextEditingController();
    final careController = TextEditingController();
    final priceController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Form(
        key: _formKey,
        child: BlocListener<BreedBloc, BreedState>(
          listener: (context, state) {
            if (state is BreedSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('Breed Added Successfully'),
                ),
              );
              nameController.clear();
              categoryController.clear();
              descriptionController.clear();
              sizeController.clear();
              careController.clear();
              priceController.clear();
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Breed Session',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
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
                  const SizedBox(height: 20),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          BreedTextField(
                            controller: nameController,
                            label: 'Breed Name',
                            validationMessage: 'Please Enter Breed name',
                          ),
                          const SizedBox(height: 16),
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
                                // selectedCategory=value!;
                                // setState(() {
                                //   selectedCategory = value!;
                                // });
                              },
                              decoration: const InputDecoration(
                                labelText: 'Category',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'Please select a category'
                                      : null,
                            ),
                          ),
                          // BreedTextField(
                          //   controller: categoryController,
                          //   label: 'Category',
                          //   validationMessage: 'Please Enter Category',
                          // ),
                          const SizedBox(height: 16),
                          BreedTextField(
                            controller: descriptionController,
                            label: 'Description',
                            validationMessage: 'Please Enter Description',
                          ),
                          const SizedBox(height: 16),
                          BreedTextField(
                            controller: sizeController,
                            label: 'Size',
                            validationMessage: 'Please Enter Size',
                          ),
                          const SizedBox(height: 16),
                          BreedTextField(
                            controller: careController,
                            label: 'Care Requirement',
                            validationMessage: 'Please Enter requirement',
                          ),
                          const SizedBox(height: 16),
                          BreedTextField(
                            controller: priceController,
                            label: 'Price',
                            validationMessage: 'Please Enter Price',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: ()async {
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

                        final breedModel = BreedModel(
                          id: '', // Replace with a unique ID if needed
                          name: nameController.text,
                          category: selectedCategory??'',
                          description: descriptionController.text,
                          size: sizeController.text,
                          careRequirements: careController.text,
                          priceRange: priceController.text,
                          imageUrls: imageUrls,
                              // Update to include image URLs when saving to Firebase
                        );
                        context
                            .read<BreedBloc>()
                            .add(AddBreedEvent(breedModel));
                        // Handle form submission
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
