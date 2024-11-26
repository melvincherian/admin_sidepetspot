import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petspot_admin_side/bloc/addpetproduct_bloc.dart';
import 'package:petspot_admin_side/bloc/multipleimage_bloc.dart';
import 'package:petspot_admin_side/infrastructure/models/pet_add_model.dart';
import 'package:petspot_admin_side/presentation/widgets/pet_add_widget.dart';
import 'package:petspot_admin_side/services/image_store.dart';


class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

 String? selectedCategory;
  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('categories').get();
      setState(() {
        categories = snapshot.docs.map((doc) => doc['name'] as String).toList();
      });
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }



  final categoryController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final weightController = TextEditingController();
  // final colorController = TextEditingController();
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
            //  colorController.clear();
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
                  onTap: () => context.read<MultipleimageBloc>().add(MultiPickImageEvent()),
                  child: BlocBuilder<MultipleimageBloc, MultipleimageState>(
                    builder: (context, state) {
                      if (state is MultipleImagesuccess) {
                        return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                    }
                  ),
                ),
                const SizedBox(height: 16),
                 Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Please select a category' : null,
                    ),
                  ),
                // CustomTextField(controller: categoryController, label: 'category', validationMessage: 'Please Enter Category'),
                CustomTextField(controller: priceController, label: 'price', validationMessage: 'Please Eneter Price',keyboardType: TextInputType.number),
                CustomTextField(controller: descriptionController, label: 'Description', validationMessage: 'Please Enter Description'),
                CustomTextField(controller: weightController, label: 'Weight', validationMessage: 'Please Enter Weight',keyboardType: TextInputType.number,),
                // CustomTextField(controller: colorController, label: 'Color', validationMessage: 'Please Enter the color of the pet'),
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
                  onPressed: () async{
                  
                    if (_formKey.currentState!.validate()) {
                      final multipleImageBloc = context.read<MultipleimageBloc>();
                       final imageState = multipleImageBloc.state;

                        List<String> imageUrls = [];
                         
                         if (imageState is MultipleImagesuccess) {
        // Loop through each selected image and upload it to Cloudinary
        for (var image in imageState.images) {
          final imageUrl = await CloudinaryService.uploadImage(image);
          if (imageUrl != null) {
            imageUrls.add(imageUrl);
          }
        }
      }
                      final petProduct = petProductModel(
                        id: 'unique-product-id',
                        category: selectedCategory??'',
                        price: double.tryParse(priceController.text) ?? 0,
                        description: descriptionController.text,
                        weight: weightController.text,
                        // color: colorController.text,
                        breed: breedController.text,
                        stock: int.tryParse(stockController.text) ?? 0,
                        imageUrls: imageUrls,
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
