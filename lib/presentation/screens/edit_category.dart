// ignore_for_file: use_build_context_synchronously


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:petspot_admin_side/bloc/imagepicker_bloc.dart';
import 'package:petspot_admin_side/infrastructure/pet_category_model.dart';


class EditCategory extends StatefulWidget {
  final Category category;
  const EditCategory({super.key,required this.category});

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {

  @override
  Widget build(BuildContext context) {

    final nameController=TextEditingController(text: widget.category.name);
    final descriptionController=TextEditingController(text: widget.category.description);
    return  Scaffold(
       appBar: AppBar(
        title:const Text('Edit Category',
        style: TextStyle(fontSize: 24,color: Colors.black,fontWeight: FontWeight.bold),
        ),
        centerTitle: true,

       ),
       body: Padding(padding:const EdgeInsets.all(17),
       child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () => context.read<ImagepickerBloc>().add(PickImageEvent()),
            child: BlocBuilder<ImagepickerBloc,ImagepickerState>(builder: (context,state){
              if(state is ImagepickerSuccess){
                return Image.file(
                  state.imageFile,
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                );
              }else{
                return Container(
                  height: 150,
                  width: 150,
                  color: Colors.grey[200],
                  child:const Icon(Icons.camera_alt_outlined),
                );
              }
            }
            )
          ),
      
        const  SizedBox(height: 20),
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
              id: widget.category.id, 
              name: nameController.text, 
              description: descriptionController.text,
              image: widget.category.image
              );

              try{
                await FirebaseFirestore.instance.collection('categories').doc(widget.category.id).update(updatedCategory.toMap());
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
          style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
          
          child:const Text('Update',
          style: TextStyle(color: Colors.white,fontSize: 18),
          ))

        ],
       ),
       ),
    );
  }
}