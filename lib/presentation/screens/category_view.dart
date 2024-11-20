import 'package:flutter/material.dart';
import 'package:petspot_admin_side/presentation/screens/add_category.dart';
import 'package:petspot_admin_side/presentation/screens/category_list.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Category Management',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildActionButton(
              label: 'Add Category',
              color: Colors.blue,
              icon: Icons.category,
              onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddCategory()));
                // Navigate to Add Pet Product page
              },
            ),
            const SizedBox(height: 16),
            _buildActionButton(
              label: 'Category Detail',
              color: Colors.green,
              icon: Icons.category_outlined,
              onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>const CategoryList()));
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
