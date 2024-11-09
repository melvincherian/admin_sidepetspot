import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            Text('Category List',
            style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //       ElevatedButton(onPressed: (){}, child: Text('Add Category'))
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}