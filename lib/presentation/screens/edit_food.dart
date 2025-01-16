// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petspot_admin_side/bloc/foodeditimage_bloc.dart';
import 'package:petspot_admin_side/bloc/foodproduct_bloc.dart';

import 'package:petspot_admin_side/infrastructure/models/food_product_model.dart';
import 'package:petspot_admin_side/services/image_store.dart';

class EditFood extends StatefulWidget {
  final FoodProductModel foodproduct;

  const EditFood({super.key,required this.foodproduct});

  @override
  State<EditFood> createState() => _EditFoodState();
}

class _EditFoodState extends State<EditFood> {

    List<String> categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('categories').get();
      setState(() {
        categories = snapshot.docs.map((doc) => doc['name'] as String).toList();
      });
    } catch (e) {
      debugPrint('Error fetching categories: $e');
    }
  }
  @override
  Widget build(BuildContext context) {

    final nameController=TextEditingController(text: widget.foodproduct.foodname);
    final categoryController=TextEditingController(text: widget.foodproduct.categoryId);
    final descriptionController=TextEditingController(text: widget.foodproduct.descriptions.join(', '));
    final priceController=TextEditingController(text: widget.foodproduct.price.toString());
    final stockController=TextEditingController(text: widget.foodproduct.stock.toString());
    final weightController=TextEditingController(text: widget.foodproduct.foodweight);
    final startdateController=TextEditingController(text: widget.foodproduct.packedDate);
    final enddateController=TextEditingController(text: widget.foodproduct.endDate);

    return  Scaffold(
       appBar: AppBar(
        title: Text('Edit Food Product',
        style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),
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
                        .read<FoodeditimageBloc>()
                        .add(FoodEditImagePicker()),
                    child: BlocBuilder<FoodeditimageBloc, FoodeditimageState>(
                      builder: (context, state) {
                        if (state is FoodEditImageSuccess) {
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
                        } else if (state is FoodEditImageFailure) {
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
                  labelText: 'Food Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
               DropdownButtonFormField<String>(
                value: categories.contains(categoryController.text)
                    ? categoryController.text
                    : null,
                onChanged: (value) {
                  setState(() {
                    categoryController.text = value!;
                  });
                },
                items: categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
              ),
              // TextField(
              //   controller: categoryController,
              //   decoration: const InputDecoration(
              //     labelText: 'Category',
              //     border: OutlineInputBorder(),
              //   ),
              // ),
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
                controller: priceController,
                decoration: const InputDecoration(
                  labelText: 'Price',
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
                controller: weightController,
                decoration: const InputDecoration(
                  labelText: 'Weight',
                  border: OutlineInputBorder(),
                ),
              ),
               const SizedBox(height: 16),
              TextField(
                controller: startdateController,
                decoration: const InputDecoration(
                  labelText: 'Start date',
                  border: OutlineInputBorder(),
                ),
              ),
               const SizedBox(height: 16),
              TextField(
                controller: enddateController,
                decoration: const InputDecoration(
                  labelText: 'End date',
                  border: OutlineInputBorder(),
                ),
              ),
           const   SizedBox(height: 20),
              ElevatedButton(onPressed: ()async{


               final foodimage =
                            context.read<FoodeditimageBloc>();
                        final imageState = foodimage.state;

                        List<String> imageUrls = [];

                        if (imageState is FoodEditImageSuccess) {
                        
                          for (var image in imageState.images) {
                            final imageUrl =
                                await CloudinaryService.uploadImage(image);
                            if (imageUrl != null) {
                              imageUrls.add(imageUrl);
                            }
                          }
                        }

                    final updatefood=FoodProductModel(
                      id: widget.foodproduct.id, 
                      foodname: nameController.text, 
                       categoryId: categoryController.text,
                      descriptions:descriptionController.text
                          .split(', ')
                          .map((e) => e.trim())
                          .toList(),
                      price: double.tryParse(priceController.text)??0,
                      stock: int.parse(stockController.text), 
                      foodweight: weightController.text, 
                      imageUrls: imageUrls, 
                      packedDate: startdateController.text, 
                      endDate: enddateController.text
                      
                      );
                      context.read<FoodproductBloc>().add(UpdateFoodEvent(updatefood));
                         Navigator.pop(context);
                     
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Food updated successfully')),
                    );
                
              },
               style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
              child:const Text('Update',
              style: TextStyle(color: Colors.white),
              ))
            ],
          ),
          ),
       ),
    );
  }
}