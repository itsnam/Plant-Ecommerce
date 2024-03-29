import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:plantial/features/authentication/sign_in_page.dart';
import 'package:plantial/features/cart/cart_page.dart';
import 'package:plantial/features/favourites/favourites_page.dart';
import 'package:plantial/features/home/home_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/home/home_page.dart';
import 'features/profile/profile_page.dart';
import '.env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
  await Stripe.instance.applySettings();
  runApp(const App());
}


class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int index = 0;
  List<Widget> pages = [const HomePage(), const FavouritePage(), const CartPage(), const ProfilePage()];


  void onTapped(int i){
    setState(() {
      index = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/home',
        routes: {
          '/home': (context) => const HomeLayout(),
          '/auth': (context) => const SignInPage(),
          '/cart': (context) => const CartPage()
        },
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFececee),
          fontFamily: 'Roboto',
          textTheme: const TextTheme(
            bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)
          )
        ),
      ),
    );
  }
}