// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petspot_admin_side/bloc/breed_bloc.dart';
import 'package:petspot_admin_side/bloc/editimage_bloc.dart';
import 'package:petspot_admin_side/infrastructure/models/breed_model.dart';
import 'package:petspot_admin_side/services/image_store.dart';

class EditBreed extends StatefulWidget {
  final BreedModel petbreed;

  const EditBreed({super.key, required this.petbreed});

  @override
  State<EditBreed> createState() => _EditBreedState();
}

class _EditBreedState extends State<EditBreed> {
  final List<String> gender = ['Male', 'Female'];
  final List<int> month = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
  final List<int> year = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: widget.petbreed.name);
    final categoryController =
        TextEditingController(text: widget.petbreed.categoryId);
    final descriptionController =
        TextEditingController(text: widget.petbreed.descriptions.join(','));
    final sizeController = TextEditingController(text: widget.petbreed.size);
    final careController =
        TextEditingController(text: widget.petbreed.careRequirements);
    final priceController =
        TextEditingController(text: widget.petbreed.price.toString());
    final stockController =
        TextEditingController(text: widget.petbreed.stock.toString());
    final dropdowngenderController =
        TextEditingController(text: widget.petbreed.gender);
    final monthController =
        TextEditingController(text: widget.petbreed.month.toString());
    final yearController =
        TextEditingController(text: widget.petbreed.year.toString());
    return Scaffold(
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
          padding: const EdgeInsets.all(17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            GestureDetector(
  onTap: () => context.read<EditimageBloc>().add(EditimagePicker()),
  child: BlocBuilder<EditimageBloc, EditimageState>(
    builder: (context, state) {
      if (state is EditImageSuccess) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: state.images.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    state.images[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: () => context
                        .read<EditimageBloc>()
                        .add(RemoveImageEvent(index)),
                    child: const CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.red,
                      child: Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      } else if (state is EditImageFailure) {
        return Text(
          state.errormessage,
          style: const TextStyle(color: Colors.red),
        );
      } else if (state is EditimageInitial && widget.petbreed.imageUrls.isNotEmpty) {
  
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: widget.petbreed.imageUrls.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.petbreed.imageUrls[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ],
            );
          },
        );
      } else {
        return const Icon(
          Icons.camera_alt,
          size: 70,
          color: Colors.grey,
        );
      }
    },
  ),
),

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
              const SizedBox(height: 16),
              TextField(
                controller: stockController,
                decoration: const InputDecoration(
                  labelText: 'Stock',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: dropdowngenderController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Select an Option',
                  suffixIcon: PopupMenuButton<String>(
                    icon: Icon(Icons.arrow_drop_down),
                    onSelected: (value) {
                      dropdowngenderController.text = value;
                    },
                    itemBuilder: (context) {
                      return gender.map((item) {
                        return PopupMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList();
                    },
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an option';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: monthController,
                readOnly: true, 
                decoration: InputDecoration(
                  labelText: 'Select a Month',
                  suffixIcon: PopupMenuButton<int>(
                    icon: Icon(Icons.arrow_drop_down),
                    onSelected: (value) {
               
                      monthController.text = value.toString();
                    },
                    itemBuilder: (context) {
                      return month.map((item) {
                        return PopupMenuItem(
                          value: item, 
                          child: Text(item
                              .toString()), 
                        );
                      }).toList();
                    },
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a month';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: yearController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Select a year',
                  suffixIcon: PopupMenuButton<int>(
                    icon: Icon(Icons.arrow_drop_down),
                    onSelected: (value) {
                    
                      yearController.text = value.toString();
                    },
                    itemBuilder: (context) {
                      return year.map((item) {
                        return PopupMenuItem(
                          value: item,
                          child: Text(item
                              .toString()), 
                        );
                      }).toList();
                    },
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a month';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () async {
                    final breedimage = context.read<EditimageBloc>();
                    final imageState = breedimage.state;

                    List<String> imageUrls = [];

                    if (imageState is EditImageSuccess) {
                      for (var image in imageState.images) {
                        final imageUrl =
                            await CloudinaryService.uploadImage(image);
                        if (imageUrl != null) {
                          imageUrls.add(imageUrl);
                        }
                      }
                    }

                    if (nameController.text.isEmpty ||
                        categoryController.text.isEmpty ||
                        descriptionController.text.isEmpty ||
                        sizeController.text.isEmpty ||
                        priceController.text.isEmpty ||
                        dropdowngenderController.text.isEmpty ||
                        monthController.text.isEmpty ||
                        yearController.text.isEmpty ||
                        stockController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please enter all fields')));
                      return;
                    }

                    final updateBreed = BreedModel(
                      id: widget.petbreed.id,
                      name: nameController.text,
                      categoryId: categoryController.text,
                      imageUrls: imageUrls,
                      descriptions: descriptionController.text
                          .split(', ')
                          .map((e) => e.trim())
                          .toList(),

                      size: sizeController.text,
                      careRequirements: careController.text,
                      price: double.tryParse(priceController.text) ?? 0,
                      gender: dropdowngenderController.text,
                      month: int.tryParse(monthController.text) ?? 0,
                      year: int.tryParse(yearController.text) ?? 0,
                      // age: int.tryParse(ageController.text)??0,
                      stock: int.tryParse(stockController.text) ?? 0,
                    );
                    context
                        .read<BreedBloc>()
                        .add(UpdateBreedEvent(updateBreed));
                         breedimage.add(ClearImagesEvent());

                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Breed updated successfully')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
