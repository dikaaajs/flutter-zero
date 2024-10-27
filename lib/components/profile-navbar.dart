// ignore: file_names
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final bool isLoggedIn;
  final String urlImg;
  const ProfileWidget(
      {super.key, required this.isLoggedIn, required this.urlImg});

  @override
  Widget build(BuildContext context) {
    return isLoggedIn
        ? CircleAvatar(
            backgroundImage: isLoggedIn
                ? NetworkImage(urlImg)
                : const AssetImage('/assets/images/pp.jpg'),
            radius: 20,
          )
        : ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                  context, '/login'); // Navigasi ke halaman login
            },
            child: const Text('Login'),
          );
  }
}
