import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petspot_admin_side/bloc/addpetproduct_bloc.dart';
import 'package:petspot_admin_side/bloc/category_bloc.dart';
import 'package:petspot_admin_side/bloc/imagepicker_bloc.dart';
import 'package:petspot_admin_side/firebase/add_pet_pro.dart';
import 'package:petspot_admin_side/firebase/category.dart'; // Your CategoryRepository
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
    // Create the CategoryRepository instance
    final categoryRepository = CategoryRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          // Provide the CategoryBloc with the CategoryRepository instance
          create: (context) => CategoryBloc(categoryRepository),
        ),
        BlocProvider(
          create: (context) => ImagepickerBloc(),
        ),
        BlocProvider(
          create: (context) => AddpetproductBloc(productRepository: ProductRepository()),
        ),
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
