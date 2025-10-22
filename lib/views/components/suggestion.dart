import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeSuggestion extends StatelessWidget {
  const HomeSuggestion({super.key});

  @override
  Widget build(BuildContext context) {
    final suggestions = [
      'Mangut Lele',
      'Sop Ayam',
      'Nasi Goreng',
      'Ikan Bakar',
      'Tumis Kangkung',
      'Rawon Daging',
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 6, 20, 6),
      child: SizedBox(
        height: 30,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(width: 6),
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            final label = suggestions[index];
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFF6F7F8), // iOS soft background
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade500, // soft grey
                  height: 1.1,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
