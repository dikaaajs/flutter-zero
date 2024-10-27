import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:zero/components/navbar.dart';
import 'package:zero/services/auth.dart';
import 'package:zero/services/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn =
        Provider.of<Auth_Provider>(context, listen: true).isLoggedIn;
    if (isLoggedIn) context.go('/');
    return Scaffold(
      appBar: const Navbar(title: "Login"),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Text(
                  "Login With Google",
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Text("login untuk menggunakan semua fitur",
                    style: GoogleFonts.inter(fontSize: 15))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            OutlinedButton.icon(
              icon: SizedBox(
                width: 24, // Lebar ikon
                height: 24, // Tinggi ikon
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/768px-Google_%22G%22_logo.svg.png',
                ),
              ),
              onPressed: () {
                print("test ntyala");
                AuthService().signInWithGoogle();
              },
              label: const Text("login with google"),
              style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  side: const BorderSide(
                    width: 1,
                  ),
                  padding: const EdgeInsets.fromLTRB(5, 25, 5, 25),
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.9,
                      50), // Lebar 90%,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10), // Mengatur kelengkungan sudut
                  ),
                  textStyle: GoogleFonts.inter()),
            ),
            OutlinedButton.icon(
              icon: SizedBox(
                width: 24, // Lebar ikon
                height: 24, // Tinggi ikon
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/768px-Google_%22G%22_logo.svg.png',
                ),
              ),
              onPressed: () {
                print("test ntyala");
                AuthService().signOut();
              },
              label: const Text("Sign Out"),
              style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  side: const BorderSide(
                    width: 1,
                  ),
                  padding: const EdgeInsets.fromLTRB(5, 25, 5, 25),
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.9,
                      50), // Lebar 90%,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10), // Mengatur kelengkungan sudut
                  ),
                  textStyle: GoogleFonts.inter()),
            )
          ],
        ),
      ),
    );
  }
}
