import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateRecipeView extends StatelessWidget {
  const CreateRecipeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Halaman Buat Resep",
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
