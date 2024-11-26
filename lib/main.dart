import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petspot_admin_side/bloc/accessories_bloc.dart';
import 'package:petspot_admin_side/bloc/addpetproduct_bloc.dart';
import 'package:petspot_admin_side/bloc/breed_bloc.dart';
import 'package:petspot_admin_side/bloc/category_bloc.dart';
import 'package:petspot_admin_side/bloc/foodproduct_bloc.dart';
import 'package:petspot_admin_side/bloc/imagepicker_bloc.dart';
import 'package:petspot_admin_side/bloc/multipleimage_bloc.dart';
import 'package:petspot_admin_side/firebase/accesory_product.dart';
import 'package:petspot_admin_side/firebase/add_pet_pro.dart';
import 'package:petspot_admin_side/firebase/breed_session.dart';
import 'package:petspot_admin_side/firebase/category.dart'; // Your CategoryRepository
import 'package:petspot_admin_side/firebase/food_product_model.dart';
import 'package:petspot_admin_side/presentation/screens/admin_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
   
    final categoryRepository = CategoryRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoryBloc(categoryRepository),
        ),
        BlocProvider(
          create: (context) => ImagepickerBloc(),
        ),
        BlocProvider(
          create: (context) =>
              AddpetproductBloc(productRepository: ProductRepository()),
        ),
        BlocProvider(
            create: (context) => FoodproductBloc(repository: Foodrepository())
        ),
        BlocProvider(
          create: (context)=>AccessoriesBloc(accessoryRepository: AccessoryRepository())
        ),
         BlocProvider(
          create: (context)=>BreedBloc(BreedRepository())
        ),
         BlocProvider(
          create: (context)=>MultipleimageBloc()
        )

      ],
      child: MaterialApp(
        title: 'Admin Side',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const AdminLogin(),
      ),
    );
  }
}
