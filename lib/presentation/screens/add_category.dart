// ignore_for_file: use_super_parameters, prefer_null_aware_operators

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart'; // Add image_picker import
import 'dart:io';
import 'package:petspot_admin_side/bloc/category_bloc.dart';
import 'package:petspot_admin_side/infrastructure/category_model.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final categoryController = TextEditingController();
  final descriptionController = TextEditingController();
  File? _image; 

  // Initialize the ImagePicker
  final ImagePicker _picker = ImagePicker();

 
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Set the picked image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state is CategoryAddedsuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
           const   SnackBar(
                backgroundColor: Colors.green,
                content: Text('Category added successfully!')),
            );
          } else if (state is CategoryError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Center(
          child: Column(
            children: [
           const   SizedBox(height: 70),
           const   Text(
                'Add Category',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
           const   SizedBox(height: 20),

              // Camera icon to pick an image
              GestureDetector(
                onTap: _pickImage,
                child: IconButton(
                  onPressed: _pickImage,
                  icon:const Icon(Icons.camera_alt, size: 60),
                ),
              ),
              if (_image != null)
                Image.file(
                  _image!,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
           const   SizedBox(height: 10),
           const   Text(
                'Upload Image',
                style: TextStyle(fontSize: 18),
              ),
           const   SizedBox(height: 20),
              TextFormField(
                controller: categoryController,
                decoration:const InputDecoration(
                  hintText: 'Category Name',
                  border: OutlineInputBorder(),
                ),
              ),
            const  SizedBox(height: 15),
              TextFormField(
                controller: descriptionController,
                decoration:const InputDecoration(
                  hintText: 'Enter Description',
                  border: OutlineInputBorder(),
                ),
              ),
           const   SizedBox(height: 28),
              ElevatedButton(
                onPressed: () {
                  if (categoryController.text.isEmpty ||
                      descriptionController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                    const  SnackBar(content: Text('Please enter all fields')),
                    );
                    return;
                  }

                  // Create a new category and add the event
                  final category = Category(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: categoryController.text,
                    description: descriptionController.text,
                    image: _image != null ? _image!.path : null, // Add image path or null
                  );

                  // Dispatch the event to add category
                  context.read<CategoryBloc>().add(AddcategoryEvent(category));
                },
                child:const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


