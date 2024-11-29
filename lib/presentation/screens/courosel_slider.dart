import 'package:flutter/material.dart';


class UserCarrousel extends StatelessWidget {
  const UserCarrousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Image'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[300],
                ),
                // child: _image == null
                //     ? const Center(child: Text('Tap to pick an image'))
                //     : Image.file(
                //         _image!,
                //         fit: BoxFit.cover,
                //       ),
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
