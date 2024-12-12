// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petspot_admin_side/bloc/foodimage_bloc.dart';
import 'package:petspot_admin_side/bloc/foodproduct_bloc.dart';

import 'package:petspot_admin_side/infrastructure/models/food_product_model.dart';
import 'package:petspot_admin_side/presentation/screens/productmanagement/product_view.dart';

import 'package:petspot_admin_side/presentation/widgets/pet_add_widget.dart';
import 'package:petspot_admin_side/presentation/widgets/pet_textfield_desc.dart';
import 'package:petspot_admin_side/services/image_store.dart';

class FoodManagement extends StatefulWidget {
  const FoodManagement({super.key});

  @override
  State<FoodManagement> createState() => _FoodManagementState();
}

class _FoodManagementState extends State<FoodManagement> {
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

  Future<String?> _fetchCategoryId(String categoryName) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('categories')
          .where('name', isEqualTo: categoryName)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      }
      return null;
    } catch (e) {
      print('Error fetching category ID: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final categoryController = TextEditingController();
    final descriptionController = TextEditingController();
    final priceController = TextEditingController();
    final stockController = TextEditingController();
    final weightController = TextEditingController();
    final startdateConroller = TextEditingController();
    final enddateConroller = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: BlocListener<FoodproductBloc, FoodproductState>(
        listener: (context, state) {
          if (state is FoodProductSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.green,
                content: Text('Food Product Addedd Successfully')));

            nameController.clear();
            categoryController.clear();
            descriptionController.clear();
            priceController.clear();
            stockController.clear();
            weightController.clear();
            startdateConroller.clear();
            enddateConroller.clear();
          } else if (state is FoodProductFailure) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.red,
                content: Text('Failed to Add food product')));
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Text(
                  'Add Food Product',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade700,
                  ),
                ),
                const SizedBox(height: 30),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => context
                      .read<FoodimageBloc>()
                      .add(FoodImagePicker()),
                  child: BlocBuilder<FoodimageBloc, FoodimageState>(
                    builder: (context, state) {
                      if (state is FoodImageSuccess) {
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
                      } else if (state is FoodImageFailure) {
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
                // Image Upload Section

                const SizedBox(height: 20),

                // Text Fields
                CustomTextField(
                    controller: nameController,
                    label: 'name',
                    validationMessage: 'Please Enter food name'),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 17.0),
                  child: DropdownButtonFormField<String>(
                    value: selectedCategory,
                    items: categories
                        .map((category) => DropdownMenuItem<String>(
                              value: category,
                              child: Text(category),
                            ))
                        .toList(),
                    onChanged: (value) {
                      selectedCategory = value!;
                      // setState(() {
                      //   selectedCategory = value!;
                      // });
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

                // CustomTextField(
                //     controller: categoryController,
                //     label: 'Category',
                //     validationMessage: 'Please Enter Category'),
                // CustomTextField(
                //     controller: descriptionController,
                //     label: 'Description',
                //     validationMessage: 'Please Enter Description'),
                CustomDescriptionTextField(
                    controller: descriptionController,
                    label: 'Description',
                    validationMessage: 'Please Enter Description',
                    keyboardType: TextInputType.multiline),
                CustomTextField(
                    controller: priceController,
                    label: 'Price',
                    validationMessage: 'Please Enter Price',
                    keyboardType: TextInputType.number),
                CustomTextField(
                    controller: stockController,
                    label: 'Stock',
                    validationMessage: 'Please Enter a Stock detail'),
                CustomTextField(
                    controller: weightController,
                    label: 'Weight',
                    validationMessage: 'Please Enter Weight'),
                CustomTextField(
                    controller: startdateConroller,
                    label: 'Startdate',
                    validationMessage: 'Please Enter the start date'),
                CustomTextField(
                    controller: enddateConroller,
                    label: 'Endate',
                    validationMessage: 'Please Enter the end date'),
                SizedBox(height: 15),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final foodimage =
                            context.read<FoodimageBloc>();
                        final imageState = foodimage.state;

                        List<String> imageUrls = [];

                        if (imageState is FoodImageSuccess) {
                          // Loop through each selected image and upload it to Cloudinary
                          for (var image in imageState.images) {
                            final imageUrl =
                                await CloudinaryService.uploadImage(image);
                            if (imageUrl != null) {
                              imageUrls.add(imageUrl);
                            }
                          }
                        }

                        final categoryId =
                            await _fetchCategoryId(selectedCategory!);
                        final categorySnapshot = await FirebaseFirestore
                            .instance
                            .collection('categories')
                            .doc(categoryId)
                            .get();

                        final product = FoodProductModel(
                          id:  DateTime.now()
                              .millisecondsSinceEpoch
                              .toString(),
                          foodname: nameController.text,
                          // category: selectedCategory ?? '',
                          // description: descriptionController.text,
                          descriptions: [descriptionController.text],
                          price: double.tryParse(priceController.text) ?? 0,
                          stock: int.parse(stockController.text),
                          foodweight: weightController.text,
                          packedDate: startdateConroller.text,
                          endDate: enddateConroller.text,
                          imageUrls: imageUrls,
                          categoryId: categoryId ?? '',
                          categoryDetails: {
                            'id': categoryId,
                            'name': categorySnapshot.data()?['name'],
                          },
                        );
                        context
                            .read<FoodproductBloc>()
                            .add(AddfoodEvent(product));

                            foodimage.add(ClearImagesEvent());
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductView()));
                            

                        // FoodimageBloc.add(ClearImagesEvent());

                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>FoodProductDetailsScreen(foodProduct: product)));
                      }
                    
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
