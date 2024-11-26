// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:petspot_admin_side/bloc/addpetproduct_bloc.dart';
// import 'package:petspot_admin_side/infrastructure/models/pet_add_model.dart';

// class ProductDetailsScreen extends StatelessWidget {
//   const ProductDetailsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Product Details'),
//       ),
//       body: BlocBuilder<AddpetproductBloc, AddpetproductState>(
//         builder: (context, state) {
//           if (state is AddpetproductSuccess) {
//             return StreamBuilder<petProductModel>(
//               stream: context.read<AddpetproductBloc>().addedProductStream,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 if (snapshot.hasData) {
//                   final petProduct = snapshot.data!;
//                   return Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(12),
//                           child: Image.network(
//                             petProduct.imageUrl?? 'https://example.com/default_image.jpg',
//                             width: double.infinity,
//                             height: 250,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         Text(
//                           petProduct.category,
//                           style: const TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           'Breed: ${petProduct.breed}',
//                           style: const TextStyle(fontSize: 18),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           'Price: \$${petProduct.price}',
//                           style: const TextStyle(fontSize: 18, color: Colors.green),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           'Weight: ${petProduct.weight} kg',
//                           style: const TextStyle(fontSize: 18),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           'Color: ${petProduct.color}',
//                           style: const TextStyle(fontSize: 18),
//                         ),
//                         const SizedBox(height: 16),
//                         Text(
//                           'Description:',
//                           style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           petProduct.description,
//                           style: const TextStyle(fontSize: 16),
//                         ),
//                         const SizedBox(height: 16),
//                         Text(
//                           'Stock: ${petProduct.stock}',
//                           style: const TextStyle(fontSize: 18, color: Colors.blue),
//                         ),
//                       ],
//                     ),
//                   );
//                 } else if (snapshot.hasError) {
//                   return Center(
//                     child: Text(
//                       'Error: ${snapshot.error}',
//                       style: const TextStyle(color: Colors.red),
//                     ),
//                   );
//                 }

//                 return const Center(child: Text('No product data available.'));
//               },
//             );
//           }
//           return const Center(child: Text('No product added yet.'));
//         },
//       ),
//     );
//   }
// }




// // ignore_for_file: use_build_context_synchronously

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:petspot_admin_side/infrastructure/models/pet_add_model.dart';


// class ProductList extends StatelessWidget {
//   const ProductList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Product List',
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.teal,
//         elevation: 4.0,
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('products').snapshots(),
//         builder: (context, snapshot) {
//           // Loading Indicator
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           // Error Handling
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }

//           // No Data Available
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text('No products available'));
//           }

//           final products = snapshot.data!.docs.map((doc) {
//             return petProductModel.fromJson(doc.data() as Map<String, dynamic>, );
//           }).toList();

//           return ListView.builder(
//             padding: const EdgeInsets.symmetric(vertical: 10.0),
//             itemCount: products.length,
//             itemBuilder: (context, index) {
//               final product = products[index];

//               return Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                 child: Card(
//                   elevation: 5,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: ListTile(
//                     contentPadding: const EdgeInsets.symmetric(
//                         vertical: 12.0, horizontal: 16.0),
//                     leading:
//                         product.imageUrl != null && product.imageUrl!.isNotEmpty
//                             ? ClipRRect(
//                                 borderRadius: BorderRadius.circular(8.0),
//                                 child: Image.network(
//                                   product.imageUrl!,
//                                   width: 50,
//                                   height: 50,
//                                   fit: BoxFit.cover,
//                                 ),
//                               )
//                             : const Icon(
//                                 Icons.image,
//                                 size: 50,
//                                 color: Colors.grey,
//                               ),
//                     title: Text(
//                       product.name,
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     subtitle: Text(
//                       '\$${product.price.toStringAsFixed(2)} - ${product.category}',
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: Colors.black54,
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           onPressed: () {
//                             // Navigator.push(
//                             //   context,
//                             //   MaterialPageRoute(
//                             //     builder: (context) =>
//                             //         EditProduct(product: product),
//                             //   ),
//                             // );
//                           },
//                           icon: const Icon(
//                             Icons.edit,
//                             color: Colors.blue,
//                           ),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete, color: Colors.red),
//                           onPressed: () async {
//                             final shouldDelete = await showDialog<bool>(
//                               context: context,
//                               builder: (context) {
//                                 return AlertDialog(
//                                   title: const Text('Delete Product'),
//                                   content: const Text(
//                                       'Are you sure you want to delete this product?'),
//                                   actions: [
//                                     TextButton(
//                                       onPressed: () =>
//                                           Navigator.of(context).pop(false),
//                                       child: const Text('Cancel'),
//                                     ),
//                                     TextButton(
//                                       onPressed: () =>
//                                           Navigator.of(context).pop(true),
//                                       child: const Text('Delete'),
//                                     ),
//                                   ],
//                                 );
//                               },
//                             );

//                             if (shouldDelete == true) {
//                               try {
//                                 await FirebaseFirestore.instance
//                                     .collection('products')
//                                     .doc(product.id)
//                                     .delete();

//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                     content:
//                                         Text('Product deleted successfully.'),
//                                     backgroundColor: Colors.green,
//                                   ),
//                                 );
//                               } catch (error) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                     content:
//                                         Text('Failed to delete product: $error'),
//                                     backgroundColor: Colors.red,
//                                   ),
//                                 );
//                               }
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }



