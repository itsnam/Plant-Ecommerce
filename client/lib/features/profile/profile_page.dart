import 'package:flutter/material.dart';
import 'package:plantial/features/profile/update_address.dart';
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

  void showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Yêu cầu đăng nhập"),
          content: const Text("Vui lòng đăng nhập để thực hiện chức năng này"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Huỷ"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/auth");
              },
              child: const Text("Đăng nhập"),
            ),
          ],
        );
      },
    );
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
        ListTile(
          leading: const Icon(Icons.history),
          title: const Text('Xem lịch sử đơn hàng'),
          onTap: () {
            if (!isLoggedIn) {
              showLoginDialog(context);
            } else {
              
            }   
          },
        ),
        ListTile(
          leading: const Icon(Icons.location_on),
          title: const Text('Cập nhật địa chỉ giao hàng'),
          onTap: () {
            if (!isLoggedIn) {
              showLoginDialog(context);
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateAddressPage(
                    email: email,
                  ),
                ),
              );
            }
          },
        ),
        ListTile(
          leading: const Icon(Icons.payment),
          title: const Text('Cập nhật thanh toán'),
          onTap: () {
            if (!isLoggedIn) {
              showLoginDialog(context);
            } else {
              
            }
          },
        ),
      ]),
    );
  }
}
