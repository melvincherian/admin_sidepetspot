import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petspot_admin_side/bloc/addpetproduct_bloc.dart';
import 'package:petspot_admin_side/bloc/imagepicker_bloc.dart';
import 'package:petspot_admin_side/infrastructure/models/pet_add_model.dart';
import 'package:petspot_admin_side/presentation/widgets/pet_add_widget.dart';


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
          
             categoryController.clear();
             priceController.clear();
             descriptionController.clear();
             weightController.clear();
             colorController.clear();
             breedController.clear();
             stockController.clear();

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
                CustomTextField(controller: categoryController, label: 'category', validationMessage: 'Please Enter Category'),
                CustomTextField(controller: priceController, label: 'price', validationMessage: 'Please Eneter Price',keyboardType: TextInputType.number),
                CustomTextField(controller: descriptionController, label: 'Description', validationMessage: 'Please Enter Description'),
                CustomTextField(controller: weightController, label: 'Weight', validationMessage: 'Please Enter Weight'),
                CustomTextField(controller: colorController, label: 'Color', validationMessage: 'Please Enter the color of the pet'),
                // DropdownButtonFormField<String>(
                //   value: "In Stock",
                //   decoration: const InputDecoration(
                //     labelText: 'Availability Status',
                //     border: OutlineInputBorder(),
                //   ),
                //   items: ['In Stock', 'Out of Stock'].map((status) {
                //     return DropdownMenuItem(
                //       value: status,
                //       child: Text(status),
                //     );
                //   }).toList(),
                //   onChanged: (value) {},
                // ),
                const SizedBox(height: 15),
                CustomTextField(controller: breedController, label: 'Breed', validationMessage: 'Please Enter Compatible breeds'),
                CustomTextField(controller: stockController, label: 'Stock', validationMessage: 'Please Enter Stock',keyboardType: TextInputType.number,),
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

}
