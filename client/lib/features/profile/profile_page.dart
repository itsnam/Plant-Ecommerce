import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantial/features/profile/history_cart_page.dart';
import 'package:plantial/features/styles/styles.dart';
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
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Tài khoản',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: (isLoggedIn == false)
          ? Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/auth");
                  },
                  child: const Text(
                    "Đăng nhập",
                    style: TextStyle(color: Colors.white),
                  )))
          : Column(children: [
              const Icon(
                Iconsax.profile_circle5,
                size: 65,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                email,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.only(left: 20),
                    title: const Text(
                      'Xem lịch sử đơn hàng',
                      style: TextStyle(fontSize: 14),
                    ),
                    onTap: () {
                      if (!isLoggedIn) {
                        showLoginDialog(context);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HistoryCartPage(
                              email: email,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      thickness: 0.5,
                      height: 0,
                    ),
                  ),
                  ListTile(
                      contentPadding: const EdgeInsets.only(left: 20),
                      title: const Text(
                        'Đăng xuất',
                        style: TextStyle(fontSize: 14),
                      ),
                      onTap: () {
                        if (isLoggedIn) {
                          logout();
                        } else {
                          Navigator.pushNamed(context, "/auth");
                        }
                      }),
                ],
              ),
            ]),
    );
  }
}
