import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petspot_admin_side/bloc/addpetproduct_bloc.dart';
import 'package:petspot_admin_side/bloc/imagepicker_bloc.dart';
import 'package:petspot_admin_side/infrastructure/models/pet_add_model.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final categoryController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final weightController = TextEditingController();
  final colorController = TextEditingController();
  final breedController = TextEditingController();
  final stockController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ADD PET',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocListener<AddpetproductBloc, AddpetproductState>(
        listener: (context, state) {
          if (state is AddpetproductSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                content: Text('Product added successfully')),
            );
          } else if (state is ProductError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to add product: ${state.errormessage}')),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => context.read<ImagepickerBloc>().add(PickImageEvent()),
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
                        return Container(
                          height: 150,
                          width: 150,
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            size: 50,
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 16),
                _buildTextField(categoryController, 'Category', 'Please Enter Category'),
                _buildTextField(priceController, 'Price', 'Please Enter Price', keyboardType: TextInputType.number),
                _buildTextField(descriptionController, 'Description', 'Please Enter Description'),
                _buildTextField(weightController, 'Weight', 'Please Enter Weight'),
                _buildTextField(colorController, 'Color', 'Please Enter Color'),
                DropdownButtonFormField<String>(
                  value: "In Stock",
                  decoration: const InputDecoration(
                    labelText: 'Availability Status',
                    border: OutlineInputBorder(),
                  ),
                  items: ['In Stock', 'Out of Stock'].map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  onChanged: (value) {},
                ),
                const SizedBox(height: 15),
                _buildTextField(breedController, 'Breed', 'Please Enter Compatible Breeds'),
                _buildTextField(stockController, 'Stock', 'Please Enter Stock', keyboardType: TextInputType.number),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final petProduct = petProductModel(
                        id: 'unique-product-id',
                        category: categoryController.text,
                        price: double.tryParse(priceController.text) ?? 0,
                        description: descriptionController.text,
                        weight: weightController.text,
                        color: colorController.text,
                        breed: breedController.text,
                        stock: int.tryParse(stockController.text) ?? 0,
                      );

                      context.read<AddpetproductBloc>().add(AddproductEvent(petProduct));
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
                    'Save',
                    style: TextStyle(color: Colors.white),
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
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
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
