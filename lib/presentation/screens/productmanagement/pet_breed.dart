// ignore_for_file: depend_on_referenced_packages, use_super_parameters, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petspot_admin_side/bloc/breed_bloc.dart';
import 'package:petspot_admin_side/bloc/breedimagebloc_bloc.dart';
import 'package:petspot_admin_side/infrastructure/models/breed_model.dart';
import 'package:petspot_admin_side/presentation/screens/productmanagement/product_view.dart';
import 'package:petspot_admin_side/presentation/widgets/breed_textfield.dart';
import 'package:petspot_admin_side/presentation/widgets/pet_textfield_desc.dart';
import 'package:petspot_admin_side/services/image_store.dart';
// Adjust import based on your project structure

class PetBreed extends StatefulWidget {
  const PetBreed({Key? key}) : super(key: key);

  @override
  State<PetBreed> createState() => _PetBreedState();
}

class _PetBreedState extends State<PetBreed> {
  String? selectedCategory;
  List<String> categories = [];
  // int? selectedMonth;
  // int? selectedYear;
  // String? gender;

  // List<String> genders = ['Male', 'Female'];

  // List<int> arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  // List<int> year = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('categories').get();
      setState(() {
        categories = snapshot.docs.map((doc) => doc['name'] as String).toList();
      });
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  Future<String?> _fetchCategoryId(String categoryName) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('categories')
          .where('name', isEqualTo: categoryName)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      }
      return null;
    } catch (e) {
      print('Error fetching category ID: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final categoryController = TextEditingController();
    final descriptionController = TextEditingController();
    final sizeController = TextEditingController();
    final careController = TextEditingController();
    final priceController = TextEditingController();
    final ageController=TextEditingController();
    final genderController=TextEditingController();
    final stockController=TextEditingController();
    
    // final ageController=TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Form(
        key: _formKey,
        child: BlocListener<BreedBloc, BreedState>(
          listener: (context, state) {
            if (state is BreedSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('Breed Added Successfully'),
                ),
              );
              nameController.clear();
              categoryController.clear();
              descriptionController.clear();
              sizeController.clear();
              careController.clear();
              priceController.clear();
              // ageController.clear();
            }
          },
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
                    onTap: () => context
                        .read<BreedimageblocBloc>()
                        .add(BreedImagepicker()),
                    child: BlocBuilder<BreedimageblocBloc, BreedimageblocState>(
                      builder: (context, state) {
                        if (state is BreedImageSuccess) {
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
                        } else if (state is BreedImageFailure) {
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
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            child: DropdownButtonFormField<String>(
                              value: selectedCategory,
                              items: categories
                                  .map((category) => DropdownMenuItem<String>(
                                        value: category,
                                        child: Text(category),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                selectedCategory = value!;
                                // setState(() {
                                //   selectedCategory = value!;
                                // });
                              },
                              decoration: const InputDecoration(
                                labelText: 'Category',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'Please select a category'
                                      : null,
                            ),
                          ),
                          // BreedTextField(
                          //   controller: categoryController,
                          //   label: 'Category',
                          //   validationMessage: 'Please Enter Category',
                          // ),
                          const SizedBox(height: 16),
                          CustomDescriptionTextField(
                            controller: descriptionController,
                            label: 'Description',
                            validationMessage: 'Please Enter Description',
                            keyboardType: TextInputType.multiline,
                          ),
                          // BreedTextField(
                          //   controller: descriptionController,
                          //   label: 'Description',
                          //   validationMessage: 'Please Enter Description',
                          // ),
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
                           BreedTextField(
                            controller: ageController,
                            label: 'Age',
                            validationMessage: 'Please Enter Month',
                          ),
                           BreedTextField(
                            controller: genderController,
                            label: 'Gender',
                            validationMessage: 'Please Enter Gender',
                          ),
                             BreedTextField(
                            controller: stockController,
                            label: 'Stock',
                            validationMessage: 'Please Enter Stock',
                          ),
                          
                      //       Padding(
                      //       padding: const EdgeInsets.symmetric(
                      //           vertical: 8.0, horizontal: 16.0),
                      //       child: DropdownButtonFormField<int>(
                      //         value: selectedMonth,
                      //         items: arr
                      //             .map((arr) => DropdownMenuItem<int>(
                      //                   value: arr,
                      //                   child: Text(arr.toString()),
                      //                 ))
                      //             .toList(),
                      //         onChanged: (value) {
                      //           selectedMonth = value!;
                      //           // setState(() {
                      //           //   selectedCategory = value!;
                      //           // });
                      //         },
                      //         decoration: const InputDecoration(
                      //           labelText: 'Month',
                      //           border: OutlineInputBorder(),
                      //         ),
                      //         validator: (value){
                      //           if(value==null){
                      //             return 'Please select month';
                      //           }
                      //           return null;
                      //         }
                      //       ),
                      //     ),
                      //   // year session
                      //      Padding(
                      //       padding: const EdgeInsets.symmetric(
                      //           vertical: 8.0, horizontal: 16.0),
                      //       child: DropdownButtonFormField<int>(
                      //         value: selectedYear,
                      //         items: year
                      //             .map((year) => DropdownMenuItem<int>(
                      //                   value: year,
                      //                   child: Text(year.toString()),
                      //                 ))
                      //             .toList(),
                      //         onChanged: (value) {
                      //           selectedYear = value!;
                      //           // setState(() {
                      //           //   selectedCategory = value!;
                      //           // });
                      //         },
                      //         decoration: const InputDecoration(
                      //           labelText: 'Year',
                      //           border: OutlineInputBorder(),
                      //         ),
                      //         validator: (value){
                      //           if(value==null){
                      //             return 'Please select year';
                      //           }
                      //           return null;
                      //         }
                      //       ),
                      //     ),

                      //     /// gender session
                          
                      
                      //  Padding(
                      //       padding: const EdgeInsets.symmetric(
                      //           vertical: 8.0, horizontal: 16.0),
                      //       child: DropdownButtonFormField<String>(
                      //         value: gender,
                      //         items: genders
                      //             .map((genders) => DropdownMenuItem<String>(
                      //                   value: genders,
                      //                   child: Text(genders),
                      //                 ))
                      //             .toList(),
                      //         onChanged: (value) {
                      //           gender = value!;
                      //           // setState(() {
                      //           //   selectedCategory = value!;
                      //           // });
                      //         },
                      //         decoration: const InputDecoration(
                      //           labelText: 'Gender',
                      //           border: OutlineInputBorder(),
                      //         ),
                      //         validator: (value) =>
                      //             value == null || value.isEmpty
                      //                 ? 'Please select a gender'
                      //                 : null,
                      //       ),
                      //     ),
                    // added new code
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final breedimage =
                            context.read<BreedimageblocBloc>();
                        final imageState = breedimage.state;

                        List<String> imageUrls = [];

                        if (imageState is BreedImageSuccess) {
                          // Loop through each selected image and upload it to Cloudinary
                          for (var image in imageState.images) {
                            final imageUrl =
                                await CloudinaryService.uploadImage(image);
                            if (imageUrl != null) {
                              imageUrls.add(imageUrl);
                            }
                          }
                        }

                        final categoryId =
                            await _fetchCategoryId(selectedCategory!);
                        final categorySnapshot = await FirebaseFirestore
                            .instance
                            .collection('categories')
                            .doc(categoryId)
                            .get();

                        final breedModel = BreedModel(
                            id: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(), // Replace with a unique ID if needed
                            name: nameController.text,
                            categoryDetails: {
                              'id': categoryId,
                              'name': categorySnapshot.data()?['name'],
                            },
                            categoryId: categoryId ?? '',
                            // description: descriptionController.text,
                            descriptions: [descriptionController.text],
                            size: sizeController.text,
                            careRequirements: careController.text,
                            price: double.tryParse(priceController.text) ?? 0,
                            // priceRange: priceController.text,
                            imageUrls: imageUrls,
                            // month: selectedMonth ?? 0,

                            // year: selectedYear ?? 0,
                            gender: genderController.text,
                            age: int.tryParse(ageController.text)??0,
                            stock: int.tryParse(stockController.text)??0,
                            
                            // age: int.tryParse(monthController.text) ??0,

                            // Update to include image URLs when saving to Firebase
                            );
                        context
                            .read<BreedBloc>()
                            .add(AddBreedEvent(breedModel));
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductView()));
                        breedimage.add(ClearImagesEvent());
                        // Handle form submission
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Submit',
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
