import 'package:flutter/material.dart';
import 'package:products_app/screens/screens.dart';

void main() => runApp(const ProductsApp());

class ProductsApp extends StatelessWidget {
  const ProductsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Products App',
      initialRoute: 'home',
      routes: {
        'login': (context) => const LoginScreen(),
        'home': (context) => const HomeScreen(),
        'product': (context) => const ProductScreen(),
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        primaryColor: Colors.deepPurple,
        appBarTheme: const AppBarTheme(
          color: Colors.deepPurple,
          elevation: 0,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.deepPurple,
          elevation: 0,
        ),
      ),
    );
  }
}
