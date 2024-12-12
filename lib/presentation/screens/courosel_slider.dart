import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:petspot_admin_side/bloc/multipleimage_bloc.dart';
class UserCarrousel extends StatelessWidget {
  const UserCarrousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Image',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               GestureDetector(
                    onTap: () => context
                        .read<MultipleimageBloc>()
                        .add(MultiPickImageEvent()),
                    child: BlocBuilder<MultipleimageBloc, MultipleimageState>(
                      builder: (context, state) {
                        if (state is MultipleImagesuccess) {
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
                        } else if (state is MultipleImageFailure) {
                          return Text(
                            state.errormessage,
                            style: const TextStyle(color: Colors.red),
                          );
                        } else {
                          return const Icon(Icons.camera_alt);
                        
                        }
                      },
                    ),
                  ),
              const SizedBox(height: 20),
              const Text(
                'Tap to upload an image',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: ()async {
                    // final multipleImageBloc =
                    //         context.read<MultipleimageBloc>();
                    //     final imageState = multipleImageBloc.state;
    
                    //     List<String> imageUrls = [];
    
                    //     if (imageState is MultipleImagesuccess) {
                    //       // Loop through each selected image and upload it to Cloudinary
                    //       for (var image in imageState.images) {
                    //         final imageUrl =
                    //             await CloudinaryService.uploadImage(image);
                    //         if (imageUrl != null) {
                    //           imageUrls.add(imageUrl);
                    //         }
                    //       }
                  
                    //     }
                  // Handle next action
                },
                icon: const Icon(Icons.download,color: Colors.white,),
                label: const Text('Save Image',
                style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12),
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
