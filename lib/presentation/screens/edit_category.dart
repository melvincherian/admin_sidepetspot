// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petspot_admin_side/infrastructure/category_model.dart';

class EditCategory extends StatelessWidget {
  final Category category;
  const EditCategory({super.key,required this.category});

  @override
  Widget build(BuildContext context) {

    final nameController=TextEditingController(text: category.name);
    final descriptionController=TextEditingController(text: category.description);
    return  Scaffold(
       appBar: AppBar(
        title:const Text('Edit Category',
        style: TextStyle(fontSize: 24,color: Colors.white),
        ),
        centerTitle: true,

       ),
       body: Padding(padding:const EdgeInsets.all(17),
       child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
         controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Category Name',
                border: OutlineInputBorder(),
              ),
            
          ),
       const   SizedBox(height: 16),
           TextField(
         controller:descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            
          ),
        const  SizedBox(height: 32),
          ElevatedButton(onPressed: ()async{
            if(nameController.text.isEmpty || descriptionController.text.isEmpty){
              ScaffoldMessenger.of(context).showSnackBar(
             const   SnackBar(content: Text('Please enter all fields'))
              );
              return;
            }
            final updatedCategory=Category(
              id: category.id, 
              name: nameController.text, 
              description: descriptionController.text,
              image: category.image
              );

              try{
                await FirebaseFirestore.instance.collection('categories').doc(category.id).update(updatedCategory.toMap());
                       ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text('Category updated successfully!')),
                  );
              }catch(e){
                 ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Failed to update category: $e')),
                  );
              }

          }, 
          
          child:const Text('Update'))

        ],
       ),
       ),
    );
  }
}