import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petspot_admin_side/bloc/imagepicker_bloc.dart';
import 'package:petspot_admin_side/infrastructure/models/breed_model.dart';

class EditBreed extends StatefulWidget {
  final BreedModel petbreed;

  const EditBreed({super.key,required this.petbreed});

  @override
  State<EditBreed> createState() => _EditBreedState();
}

class _EditBreedState extends State<EditBreed> {
  @override
  Widget build(BuildContext context) {

   final nameController=TextEditingController(text: widget.petbreed.name);
   final categoryController=TextEditingController(text: widget.petbreed.category);
   final descriptionController=TextEditingController(text: widget.petbreed.descriptions.join(','));
   final sizeController=TextEditingController(text: widget.petbreed.size);
   final careController=TextEditingController(text: widget.petbreed.careRequirements);
   final priceController=TextEditingController(text: widget.petbreed.price.toString());



    return  Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Breed',
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
                  labelText: 'Breed Name',
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
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: sizeController,
                decoration: const InputDecoration(
                  labelText: 'Size',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: careController,
                decoration: const InputDecoration(
                  labelText: 'Care requirements',
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
             
              SizedBox(height: 20),
              ElevatedButton(onPressed: ()async{
                  if(nameController.text.isEmpty || categoryController.text.isEmpty || descriptionController.text.isEmpty || sizeController.text.isEmpty ||  priceController.text.isEmpty ){
              ScaffoldMessenger.of(context).showSnackBar(
             const   SnackBar(content: Text('Please enter all fields'))
              );
              return;
            }
           
    //          final updatedBreed = BreedModel(
    //   id: widget.breed.id, // Keep the same ID
    //   b: nameController.text, // Updated name
    //   category: categoryController.text, // Updated category
    //   imageUrls: widget.accessory.imageUrls, // Assume images are unchanged
    //   descriptions: DescriptionController.text.split(',').map((e) => e.trim()).toList(), // Split descriptions back into a list
    //   price: double.tryParse(priceController.text) ?? 0, // Safely parse price
    //   size: SizeController.text, // Updated size
    //   stock: int.tryParse(stockController.text) ?? 0, // Safely parse stock
    //   petType: petTypeController.text, // Updated pet type
    // );
    final updateBreed=BreedModel(
      id: widget.petbreed.id, 
      name: widget.petbreed.name, 
      category: categoryController.text, 
      imageUrls: widget.petbreed.imageUrls, 
      descriptions: descriptionController.text.split(', ').map((e)=>e.trim()).toList(),
      size: sizeController.text, 
      careRequirements: widget.petbreed.careRequirements, 
      price: double.tryParse(priceController.text)??0,
      );
                  try{
                await FirebaseFirestore.instance.collection('foodproducts').doc(widget.petbreed.id).update(updateBreed.toMap());
                       ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text('Breed updated successfully!')),
                  );
              }catch(e){
                 ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Failed to update Breed: $e')),
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