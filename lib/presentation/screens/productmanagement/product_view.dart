import 'package:flutter/material.dart';
import 'package:petspot_admin_side/presentation/screens/details/accessory_detail.dart';
import 'package:petspot_admin_side/presentation/screens/details/breed_detail.dart';
import 'package:petspot_admin_side/presentation/screens/details/food_product_detail.dart';
import 'package:petspot_admin_side/presentation/screens/details/pet_detail.dart';
import 'package:petspot_admin_side/presentation/screens/productmanagement/accesory_management.dart';
import 'package:petspot_admin_side/presentation/screens/productmanagement/add_product.dart';
import 'package:petspot_admin_side/presentation/screens/productmanagement/food_management.dart';
import 'package:petspot_admin_side/presentation/screens/productmanagement/pet_breed.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Management',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two columns for a balanced layout
            crossAxisSpacing: 16, // Space between columns
            mainAxisSpacing: 16, // Space between rows
            childAspectRatio: 1.5, // Aspect ratio for each button (adjust as needed)
          ),
          itemCount: 8, // Number of items in the grid
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return _buildActionButton(
                  label: 'Add Pet Product',
                  color: Colors.grey,
                  icon: Icons.pets,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddProduct()));
                  },
                );
              case 1:
                return _buildActionButton(
                  label: 'Add Accessories Product',
                  color: Colors.grey,
                  icon: Icons.shopping_bag,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AccesoryManagement()));
                  },
                );
              case 2:
                return _buildActionButton(
                  label: 'Add Food Product',
                  color: Colors.grey,
                  icon: Icons.fastfood,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const FoodManagement()));
                  },
                );
              case 3:
                return _buildActionButton(
                  label: 'Breed Session',
                  color: Colors.grey,
                  icon: Icons.pets,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const PetBreed()));
                  },
                );
              case 4:
                return _buildActionButton(
                  label: 'Pet Product Detail',
                  color: Colors.grey,
                  icon: Icons.details,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const PetDetail()));
                  },
                );
              case 5:
                return _buildActionButton(
                  label: 'Accessories Detail',
                  color: Colors.grey,
                  icon: Icons.shop_two,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AccessoryList()));
                  },
                );
              case 6:
                return _buildActionButton(
                  label: 'Food Detail',
                  color: Colors.grey,
                  icon: Icons.food_bank_outlined,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const FoodProductDetail()));
                  },
                );
              case 7:
                return _buildActionButton(
                  label: 'Breed Detail',
                  color: Colors.grey,
                  icon: Icons.pets,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const BreedDetail()));
                  },
                );
              default:
                return const SizedBox.shrink();
            }
          },
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
