// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petspot_admin_side/bloc/accessories_bloc.dart';
import 'package:petspot_admin_side/bloc/imagepicker_bloc.dart';
import 'package:petspot_admin_side/infrastructure/models/product_accessories_model.dart';

class AccesoryManagement extends StatelessWidget {
  const AccesoryManagement({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final categoryController = TextEditingController();
    final descriptionController = TextEditingController();
    final sizeController = TextEditingController();
    final stockController = TextEditingController();
    final priceController = TextEditingController();
    final petTypeController = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Add Accessories',
      //     style: TextStyle(
      //       fontSize: 24,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   centerTitle: true,
      // ),
      body: BlocListener<AccessoriesBloc, AccessoriesState>(
        listener: (context, state) {
          if (state is AccessoriesSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.green,
                content: Text('Food Product Addedd Successfully')));
          } else if (state is AccessoriesFailure) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.red,
                content: Text('Failed to Add food product')));
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
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
                            return const SizedBox(
                              height: 120,
                              width: 120,
                              child: Icon(
                                Icons.camera_alt,
                                size: 50,
                              ),
                            );
                          }
                        }),
                        // child: CircleAvatar(
                        //   radius: 50,
                        //   backgroundImage: NetworkImage('https://images.all-free-download.com/images/graphiclarge/dog_pet_accessories_icons_3d_colored_design_6834308.jpg'),
                        // ),
                      )
                    ],
                  ),
                  _buildTextField(
                      nameController, 'Accesory name', 'Please Enter name'),
                  _buildTextField(
                      categoryController, 'Category', 'Please Enter category'),
                  _buildTextField(descriptionController, 'Description',
                      'Please Enter Description'),
                  _buildTextField(sizeController, 'Size', 'Please Enter Size'),
                  _buildTextField(
                      stockController, 'Stock', 'Please Enter stock'),
                  _buildTextField(
                      priceController, 'Price', 'Please Enter Price'),
                  _buildTextField(
                      petTypeController, 'PetType', 'Please Enter PetType'),
                  const SizedBox(height: 25),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final accesory = ProductAccessoriesModel(
                              id: 'id',
                              accesoryname: nameController.text,
                              category: categoryController.text,
                              image: '',
                              description: descriptionController.text,
                              price: double.tryParse(priceController.text) ?? 0,
                              size: sizeController.text,
                              stock: int.parse(stockController.text),
                              petType: petTypeController.text);

                          context
                              .read<AccessoriesBloc>()
                              .add(AddAccessoriesevent(accesory));
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
                      ))
                ],
              ),
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
      padding: const EdgeInsets.all(12.0),
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
            borderSide: BorderSide(color: Colors.teal, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.teal, width: 2),
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
