import 'package:flutter/material.dart';
import 'package:petspot_admin_side/presentation/screens/details/accessory_detail.dart';
import 'package:petspot_admin_side/presentation/screens/details/breed_detail.dart';
import 'package:petspot_admin_side/presentation/screens/details/food_product_detail.dart';
import 'package:petspot_admin_side/presentation/screens/details/pet_detail.dart';
// import 'package:petspot_admin_side/presentation/screens/details/accessory_detail.dart';
import 'package:petspot_admin_side/presentation/screens/productmanagement/accesory_management.dart';
import 'package:petspot_admin_side/presentation/screens/productmanagement/add_product.dart';
import 'package:petspot_admin_side/presentation/screens/productmanagement/food_management.dart';
import 'package:petspot_admin_side/presentation/screens/productmanagement/pet_breed.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Management',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        // backgroundColor: Colors.teal,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildActionButton(
              label: 'Add Pet Product',
              color: Colors.green,
              icon: Icons.pets,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddProduct()));
              },
            ),
            const SizedBox(height: 16),
            _buildActionButton(
              label: 'Add Accessories Product',
              color: Colors.grey,
              icon: Icons.shopping_bag,
              onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context)=>const AccesoryManagement()));
              },
            ),
            const SizedBox(height: 16),
            _buildActionButton(
              label: 'Add Food Product',
              color: Colors.grey,
              icon: Icons.fastfood,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const FoodManagement()));
              },
            ),
                 const SizedBox(height: 16),
             _buildActionButton(
              label: 'Breed Session',
              color: Colors.grey,
              icon: Icons.pets,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const PetBreed()));
                // Navigate to Add Accessories Product page
              },
            ),
             const SizedBox(height: 16),
             _buildActionButton(
              label: 'Pet product Detail',
              color: Colors.grey,
              icon: Icons.details,
              onTap: () {
               
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const PetDetail()));
              },
            ),
             const SizedBox(height: 16),
             _buildActionButton(
              label: 'Accesories Detail',
              color: Colors.grey,
              icon: Icons.shop_two,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AccessoryList()));
                // Navigate to Add Accessories Product page
              },
            ),
             const SizedBox(height: 16),
             _buildActionButton(
              label: 'Food Detail',
              color: Colors.grey,
              icon: Icons.food_bank_outlined,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FoodProductDetail()));
                // Navigate to Add Accessories Product page
              },
            ),
         

              const SizedBox(height: 16),
             _buildActionButton(
              label: 'Breed Detail',
              color: Colors.grey,
              icon: Icons.pets,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BreedDetail()));
                // Navigate to Add Accessories Product page
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              offset: const Offset(0, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
