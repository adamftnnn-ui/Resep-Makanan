import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Halaman Obrolan",
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
