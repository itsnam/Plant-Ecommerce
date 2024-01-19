import 'package:flutter/material.dart';
import 'package:plantial/features/home/home_layout.dart';
import 'package:plantial/features/product_detail/product_detail_layout.dart';

void main() => runApp(const App());

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomeLayout(),
        '/product-detail': (context) => const ProductDetailLayout()
      },
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFECECEC),
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
          bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)
        )
      ),
    );
  }
}