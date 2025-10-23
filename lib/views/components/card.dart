// lib/views/components/home_HomeCard.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../controllers/detail_resep_controller.dart';

class HomeCard extends StatelessWidget {
  final String? image;
  final String title;
  final String country;
  final bool isHalal;
  final String time;
  final String serving;
  final double rating;
  final List<String> ingredients;
  final List<String> instructions;
  final Map<String, String> nutrition;

  const HomeCard({
    super.key,
    this.image,
    required this.title,
    required this.country,
    required this.isHalal,
    required this.time,
    required this.serving,
    required this.rating,
    required this.ingredients,
    required this.instructions,
    required this.nutrition,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Tap → buka DetailResepController
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailResepController(
              resep: {
                'image': image,
                'title': title,
                'country': country,
                'isHalal': isHalal,
                'ingredients': ingredients,
                'instructions': instructions,
                'nutrition': nutrition,
              },
            ),
          ),
        );
      },
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          color: const Color(0xFFFDFDFE),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==== GAMBAR ====
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
              child: image != null && image!.isNotEmpty
                  ? Image.asset(
                      image!,
                      height: 110,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 110,
                      width: double.infinity,
                      color: const Color(0xFFF2F3F5),
                      alignment: Alignment.center,
                      child: Text(
                        "Belum ada gambar",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
            ),

            // ==== ISI HomeCard ====
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TITLE + HALAL
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isHalal)
                        Container(
                          height: 18,
                          width: 18,
                          margin: const EdgeInsets.only(left: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(
                            HugeIcons.strokeRoundedHalal,
                            color: Color(0xFF43A047),
                            size: 13,
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 2),

                  // NEGARA
                  Text(
                    country,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // INFORMASI (WAKTU, PORSI, RATING)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          _infoItem(HugeIcons.strokeRoundedClock01, time),
                          const SizedBox(width: 6),
                          _infoItem(HugeIcons.strokeRoundedRiceBowl01, serving),
                        ],
                      ),
                      _ratingStars(rating),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==== MINI WIDGET: Info Item ====
  Widget _infoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 12, color: Colors.grey[600]),
        const SizedBox(width: 3),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 10.5,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // ==== MINI WIDGET: Rating Stars ====
  Widget _ratingStars(double rating) {
    return Row(
      children: List.generate(5, (index) {
        final filled = index < rating.floor();
        final half = index == rating.floor() && rating % 1 >= 0.5;
        return Icon(
          half ? Icons.star_half_rounded : Icons.star_rounded,
          size: 12,
          color: filled || half
              ? const Color(0xFFFFC107)
              : Colors.grey.shade300,
        );
      }),
    );
  }
}
