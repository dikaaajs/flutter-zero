import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zero/components/profile-navbar.dart';
import 'package:zero/services/auth_provider.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const Navbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn =
        Provider.of<Auth_Provider>(context, listen: true).isLoggedIn;
    final User? user = Provider.of<Auth_Provider>(context, listen: true).user;

    return AppBar(
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: ModalRoute.of(context)?.settings.name == '/'
                ? const Icon(Icons.menu)
                : const Icon(Icons.arrow_back_ios),
            onPressed: ModalRoute.of(context)?.settings.name == '/'
                ? () {
                    // Aksi ketika tombol menu ditekan
                  }
                : () {
                    context.go('/');
                  },
          ),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          ProfileWidget(
            isLoggedIn: isLoggedIn,
            urlImg: !isLoggedIn
                ? "https://img.alicdn.com/imgextra/i4/1797064093/O1CN01oaGvKE1g6dut0pICS_!!1797064093.png_.webp"
                : '${user?.photoURL}',
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Atur tinggi sesuai kebutuhan
}
