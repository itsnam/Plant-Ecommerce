import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoggedIn = false;
  String email = "";

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      email = prefs.getString("email") ?? "";
    });
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.setString('email', "");
    setState(() {
      email = "";
      isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          decoration: const BoxDecoration(
              color: Color(0xFF4b8e4b)
          ),
          height: 40,
        ),
        Container(
          decoration: const BoxDecoration(
            color: Color(0xFF4b8e4b)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  email,
                  style:
                      const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.white
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: TextButton(
                    onPressed: () {
                      if (isLoggedIn) {
                        logout();
                      } else {
                        Navigator.pushNamed(context, "/auth");
                      }
                    },
                    child: Text(isLoggedIn ? "Log out" : "Sign In", style: const TextStyle(color: Colors.black),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
