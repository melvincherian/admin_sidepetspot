// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petspot_admin_side/bloc/breed_bloc.dart';
import 'package:petspot_admin_side/bloc/imagepicker_bloc.dart';
import 'package:petspot_admin_side/infrastructure/models/breed_model.dart';
import 'package:petspot_admin_side/presentation/widgets/breed_textfield.dart';

class PetBreed extends StatelessWidget {
  const PetBreed({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final categoryController = TextEditingController();
    // final popularityController = TextEditingController();
    // //  final ratingsCotroller= TextEditingController();
    //  final reviewsController = TextEditingController();
     final descriptionController=TextEditingController();
     final sizeController=TextEditingController();
     final careController=TextEditingController();
     final priceController=TextEditingController();
    //  final isAvailableController=TextEditingController();
    final _formKey=GlobalKey<FormState>();

    return Scaffold(
    
      body: BlocListener<BreedBloc,BreedState>(
        listener: (context,state){
           if(state is BreedSuccess){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.green,
              content: Text('Breed Added Successfully')
              ));

              nameController.clear();
              categoryController.clear();
              descriptionController.clear();
              sizeController.clear();
              careController.clear();
              priceController.clear();
              
           }
        },
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Breed Session',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () =>
                        context.read<ImagepickerBloc>().add(PickImageEvent()),
                    child: BlocBuilder<ImagepickerBloc, ImagepickerState>(
                      builder: (context, state) {
                        return state is ImagepickerSuccess
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  state.imageFile,
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : CircleAvatar(
                                radius: 60,
                                backgroundImage: const NetworkImage(
                                  'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/461fed23287735.599f500689d80.jpg',
                                ),
                                backgroundColor: Colors.grey[200],
                              );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          BreedTextField(
                            controller: nameController,
                            label: 'Breed Name',
                            validationMessage: 'Please Enter Breed name',
                          ),
                          const SizedBox(height: 16),
                          BreedTextField(
                            controller: categoryController,
                            label: 'Category',
                            validationMessage: 'Please Enter Category',
                          ),
                          // const SizedBox(height: 16),
                          // BreedTextField(
                          //   controller: popularityController,
                          //   label: 'Popularity',
                          //   validationMessage: 'Please Enter Popularity',
                          // ),
                          //   const SizedBox(height: 16),
                          //   BreedTextField(
                          //   controller: ratingsCotroller,
                          //   label: 'Ratings',
                          //   validationMessage: 'Please Enter Ratings',
                          // ),
                          //  const SizedBox(height: 16),
                          //   BreedTextField(
                          //   controller: reviewsController,
                          //   label: 'Review',
                          //   validationMessage: 'Please Enter Review ratings',
                          // ),
                          const SizedBox(height: 16),
                            BreedTextField(
                            controller: descriptionController,
                            label: 'Description',
                            validationMessage: 'Please Enter Description',
                          ),
                            const SizedBox(height: 16),
                            BreedTextField(
                            controller: sizeController,
                            label: 'Size',
                            validationMessage: 'Please Enter Size',
                          ),
                            const SizedBox(height: 16),
                            BreedTextField(
                            controller: careController,
                            label: 'Care Requirement',
                            validationMessage: 'Please Enter requirement',
                          ),
                           const SizedBox(height: 16),
                            BreedTextField(
                            controller: priceController,
                            label: 'Price',
                            validationMessage: 'Please Enter Price',
                          ),
                          // const SizedBox(height: 16),
                          //   BreedTextField(
                          //   controller: isAvailableController,
                          //   label: 'Available',
                          //   validationMessage: 'Please Enter Detail',
                          // ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        final breedmodel=BreedModel(
                          id: '', 
                          name: nameController.text, 
                          category: categoryController.text, 
                          description: descriptionController.text,
                          size: sizeController.text,
                          careRequirements: careController.text,
                          priceRange: priceController.text,
                          // isAvailable: true
                          
                          
                          );
                          context.read<BreedBloc>().add(AddBreedEvent(breedmodel));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('Submit',
                    style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
