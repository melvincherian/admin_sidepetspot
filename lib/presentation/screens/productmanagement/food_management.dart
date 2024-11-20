// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petspot_admin_side/bloc/foodproduct_bloc.dart';
import 'package:petspot_admin_side/bloc/imagepicker_bloc.dart';
import 'package:petspot_admin_side/infrastructure/models/food_product_model.dart';


class FoodManagement extends StatelessWidget {
  const FoodManagement({super.key});

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

                // Image Upload Section
                Stack(
                  alignment: Alignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSQRctzYQ1Vrb313CJ1nCqyE9EqF_DeJE5-A&s'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 10,
                      child: GestureDetector(
                        onTap: () => context
                            .read<ImagepickerBloc>()
                            .add(PickImageEvent()),
                        child: BlocBuilder<ImagepickerBloc, ImagepickerState>(
                            builder: (context, state) {
                          if (state is ImagepickerSuccess) {
                            return Image.file(
                              state.imageFile,
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            );
                          } else {
                            return const CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.teal,
                              child: Icon(
                                Icons.camera_alt,
                                size: 18,
                              ),
                            );
                          }
                        }),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Text Fields
                _buildTextField(
                    nameController, 'Food Name', 'Please enter food name'),
                _buildTextField(
                    categoryController, 'Category', 'Please enter category'),
                _buildTextField(descriptionController, 'Description',
                    'Please enter description'),
                _buildTextField(
                  priceController,
                  'Price',
                  'Please enter price',
                  keyboardType: TextInputType.number,
                ),
                _buildTextField(
                    stockController, 'Stock', 'Please enter stock quantity'),
                _buildTextField(weightController, 'Weight',
                    'Please enter weight (e.g., grams)',
                    keyboardType: TextInputType.number),
                _buildTextField(startdateConroller, 'Start date',
                    'Please Enter start date'),
                _buildTextField(
                    enddateConroller, 'End date', 'Please Enter End date'),
                const SizedBox(height: 30),

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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final product = FoodProductModel(
                          id: 'id',
                          foodname: nameController.text,
                          category: categoryController.text,
                          description: descriptionController.text,
                          price: double.tryParse(priceController.text) ?? 0,
                          stock: int.parse(stockController.text),
                          foodweight: weightController.text,
                          packedDate: startdateConroller.text,
                          endDate: enddateConroller.text,
                        );
                        context
                            .read<FoodproductBloc>()
                            .add(AddfoodEvent(product));

                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>FoodDetailsScreen(foodProduct: product)));
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

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    String validationMessage, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          // labelStyle: TextStyle(color: Colors.teal.shade700),
          filled: true,
          // fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.teal, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.teal, width: 2),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validationMessage;
          }
          return null;
        },
      ),
    );
  }
}
