// ignore_for_file: use_super_parameters, prefer_null_aware_operators

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petspot_admin_side/bloc/category_bloc.dart';
import 'package:petspot_admin_side/bloc/imagepicker_bloc.dart';
import 'package:petspot_admin_side/infrastructure/pet_category_model.dart';
import 'package:petspot_admin_side/services/image_store.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final categoryController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state is CategoryAddedsuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('Category added successfully!')),
            );
          } else if (state is CategoryError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 70),
                const Text(
                  'Add Category',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
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
                  }),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Upload Image',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: categoryController,
                  decoration: const InputDecoration(
                    hintText: 'Category Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 28),
                ElevatedButton(
                  onPressed: () async {
                    if (categoryController.text.isEmpty ||
                        descriptionController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please enter all fields')),
                      );
                      return;
                    }

                    String? imageUrl;
                    final imageState = context.read<ImagepickerBloc>().state;

                    if (imageState is ImagepickerSuccess) {
                      // Upload the image to Cloudinary
                      imageUrl = await CloudinaryService.uploadImage(
                          imageState.imageFile);
                      if (imageUrl == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Image upload failed')),
                        );
                        return;
                      }
                    }

                    // Create a new category and add the event
                    final category = Category(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        name: categoryController.text,
                        description: descriptionController.text,
                        image: imageUrl // Add image path or null
                        );

                    // Dispatch the event to add category
                    context
                        .read<CategoryBloc>()
                        .add(AddcategoryEvent(category));
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
