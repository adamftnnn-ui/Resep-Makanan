import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Halaman Profil",
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
