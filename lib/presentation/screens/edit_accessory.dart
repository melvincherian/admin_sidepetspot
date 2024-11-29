// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petspot_admin_side/bloc/imagepicker_bloc.dart';
import 'package:petspot_admin_side/infrastructure/models/product_accessories_model.dart';

class EditAccessory extends StatefulWidget {
  final ProductAccessoriesModel accessory;
  const EditAccessory({super.key, required this.accessory});

  @override
  State<EditAccessory> createState() => _EditAccessoryState();
}

class _EditAccessoryState extends State<EditAccessory> {
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text:widget.accessory.accesoryname );
    final categoryController = TextEditingController(text:widget.accessory.category);
    final DescriptionController = TextEditingController(text: widget.accessory.descriptions.join(','));
    final SizeController = TextEditingController(text: widget.accessory.size);
    final stockController = TextEditingController(text: widget.accessory.stock.toString());
    final priceController = TextEditingController(text: widget.accessory.price.toString());
    final petTypeController = TextEditingController(text: widget.accessory.petType);
    
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
                  onTap: () =>
                      context.read<ImagepickerBloc>().add(PickImageEvent()),
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
                        child: const Icon(Icons.camera_alt_outlined),
                      );
                    }
                  })),
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
              ElevatedButton(onPressed: ()async{
                  if(nameController.text.isEmpty || categoryController.text.isEmpty || DescriptionController.text.isEmpty || SizeController.text.isEmpty || stockController.text.isEmpty || priceController.text.isEmpty || petTypeController.text.isEmpty){
              ScaffoldMessenger.of(context).showSnackBar(
             const   SnackBar(content: Text('Please enter all fields'))
              );
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
             final updatedAccessory = ProductAccessoriesModel(
      id: widget.accessory.id, // Keep the same ID
      accesoryname: nameController.text, // Updated name
      category: categoryController.text, // Updated category
      imageUrls: widget.accessory.imageUrls, // Assume images are unchanged
      descriptions: DescriptionController.text.split(',').map((e) => e.trim()).toList(), // Split descriptions back into a list
      price: double.tryParse(priceController.text) ?? 0, // Safely parse price
      size: SizeController.text, // Updated size
      stock: int.tryParse(stockController.text) ?? 0, // Safely parse stock
      petType: petTypeController.text, // Updated pet type
    );
                  try{
                await FirebaseFirestore.instance.collection('accessories').doc(widget.accessory.id).update(updatedAccessory.toMap());
                       ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text('Accessory updated successfully!')),
                  );
              }catch(e){
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
          
          child:const Text('Update',
          style: TextStyle(color: Colors.white,fontSize: 18),
          ))
             
            ],
          ),
        ),
      ),
    );
  }
}
