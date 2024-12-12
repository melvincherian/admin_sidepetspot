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

    final ageController =
        TextEditingController(text: widget.petbreed.age.toString());
    final genderController =
        TextEditingController(text: widget.petbreed.gender);
           final stockController=TextEditingController(text: widget.petbreed.stock.toString());

    // int?selectedMonth;
    // int?selectedYear;

    // List<int>arr=[
    //  1,2,3,4,5,6,7,8,9,10,11,12

    // ];

    // List<int>year=[
    //  1,2,3,4,5,6,7,8,9,10,11,12

    // ];

    //   String?gender;

    // List<String>genders=[
    //   'Male',
    //   'Female'
    // ];

    // final ageController=TextEditingController(text: widget.petbreed.age.toString());

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
                          } else if (state is EditImageFailure) {
                            return Text(
                              state.errormessage,
                              style: const TextStyle(color: Colors.red),
                            );
                          } else {
                            return Icon(Icons.camera_alt,size: 70,);
                            // return const CircleAvatar(
                            //   radius: 60,
                            //   backgroundImage: NetworkImage(
                            //     'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/461fed23287735.599f500689d80.jpg',
                            //   ),
                            //   backgroundColor: Colors.grey,
                            // );
                          }
                    }
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
                controller: ageController,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: genderController,
                decoration: const InputDecoration(
                  labelText: 'Gender',
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

              SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () async {
                  
                      final breedimage =
                            context.read<EditimageBloc>();
                        final imageState = breedimage.state;

                        List<String> imageUrls = [];

                        if (imageState is EditImageSuccess) {
                          // Loop through each selected image and upload it to Cloudinary
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
                        genderController.text.isEmpty ||
                        ageController.text.isEmpty ||
                        stockController.text.isEmpty
                        ) {
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
                      gender: genderController.text,
                      age: int.tryParse(ageController.text)??0,
                      stock: int.tryParse(stockController.text)??0,
                    
                      // month: int.tryParse(monthController.text) ?? 0,
                      // month: selectedMonth??0,
                      // year: selectedYear??0,
                      // gender:gender??''
                    );
                    context
                        .read<BreedBloc>()
                        .add(UpdateBreedEvent(updateBreed));

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
