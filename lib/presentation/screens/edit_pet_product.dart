// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petspot_admin_side/bloc/addpetproduct_bloc.dart';
import 'package:petspot_admin_side/bloc/peteditimage_bloc.dart';
import 'package:petspot_admin_side/infrastructure/models/pet_add_model.dart';
import 'package:petspot_admin_side/services/image_store.dart';

class EditPetProduct extends StatelessWidget {
  final petProductModel petproduct;
  const EditPetProduct({super.key, required this.petproduct});

  @override
  Widget build(BuildContext context) {
    final categoryController = TextEditingController(text: petproduct.category);
    final priceController =
        TextEditingController(text: petproduct.price.toString());
    final descriptionController =
        TextEditingController(text: petproduct.descriptions.join(', '));
    final weightController = TextEditingController(text: petproduct.weight);
    final breedController = TextEditingController(text: petproduct.breed);
    final stockController =
        TextEditingController(text: petproduct.stock.toString());

    return Scaffold(
      appBar: AppBar(
        title:const Text(
          'Edit Pet Product',
          style: TextStyle(fontWeight: FontWeight.bold),
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
                    context.read<PeteditimageBloc>().add(PetEditImagePicker()),
                child: BlocBuilder<PeteditimageBloc, PeteditimageState>(
                  builder: (context, state) {
                    if (state is PetEditImageSuccess) {
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
                    } else if (state is PetEditImageFailure) {
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
                controller: priceController,
                decoration: const InputDecoration(
                  labelText: 'Price',
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
                controller: weightController,
                decoration: const InputDecoration(
                  labelText: 'Weight',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: breedController,
                decoration: const InputDecoration(
                  labelText: 'Breed',
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
           const   SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () async {
                    final petimage = context.read<PeteditimageBloc>();
                    final imageState = petimage.state;

                    List<String> imageUrls = [];

                    if (imageState is PetEditImageSuccess) {
                      
                      for (var image in imageState.images) {
                        final imageUrl =
                            await CloudinaryService.uploadImage(image);
                        if (imageUrl != null) {
                          imageUrls.add(imageUrl);
                        }
                      }
                    }

                    final updatepetproduct = petProductModel(
                        id: petproduct.id,
                        category: categoryController.text,
                        price: double.tryParse(priceController.text) ?? 0,
                        descriptions: descriptionController.text
                            .split(', ')
                            .map((e) => e.trim())
                            .toList(),
                        weight: weightController.text,
                        breed: breedController.text,
                        stock: int.parse(stockController.text),
                        imageUrls: imageUrls);
                    context
                        .read<AddpetproductBloc>()
                        .add(UpdateProductEvent(updatepetproduct));

                          Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('pet updated successfully')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
