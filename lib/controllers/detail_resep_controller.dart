// lib/controllers/detail_resep_controller.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class DetailResepController extends StatelessWidget {
  final Map<String, dynamic> resep;

  const DetailResepController({super.key, required this.resep});

  @override
  Widget build(BuildContext context) {
    final ingredients = (resep['ingredients'] as List?) ?? [];
    final instructions = (resep['instructions'] as List?) ?? [];
    final nutritionItems =
        (resep['nutrition'] as Map?)?.entries
            .map((e) => '${e.key}: ${e.value}')
            .toList() ??
        [];

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            // ===== HEADER =====
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 38,
                      width: 38,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Detail Resep',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 38),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    // ===== FOTO + INFO DI KANAN =====
                    Container(
                      padding: const EdgeInsets.all(12),
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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // FOTO
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child:
                                (resep['image'] as String?) != null &&
                                    (resep['image'] as String).isNotEmpty
                                ? Image.asset(
                                    resep['image'],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    width: 100,
                                    height: 100,
                                    color: const Color(0xFFF2F3F5),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Belum ada gambar',
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        color: Colors.grey[500],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                          ),
                          const SizedBox(width: 12),
                          // INFO DI KANAN
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // TITLE + HALAL
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        resep['title'] ?? '-',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    if (resep['isHalal'] == true)
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE8F5E9),
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                        child: const Icon(
                                          HugeIcons.strokeRoundedHalal,
                                          color: Color(0xFF43A047),
                                          size: 14,
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                // COUNTRY
                                Text(
                                  resep['country'] ?? '-',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 6),
                                // TIME + SERVING
                                Row(
                                  children: [
                                    _infoItem(
                                      HugeIcons.strokeRoundedClock01,
                                      resep['time'] ?? '-',
                                    ),
                                    const SizedBox(width: 8),
                                    _infoItem(
                                      HugeIcons.strokeRoundedRiceBowl01,
                                      resep['serving'] ?? '-',
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                // RATING + SHARE + SIMPAN
                                Row(
                                  children: [
                                    _ratingStars(resep['rating'] ?? 0.0),
                                    const Spacer(), // mendorong icon ke kanan
                                    Icon(
                                      HugeIcons.strokeRoundedShare01,
                                      size: 16,
                                      color: Colors.grey[600],
                                    ),
                                    const SizedBox(width: 12),
                                    Icon(
                                      HugeIcons.strokeRoundedBookmark01,
                                      size: 16,
                                      color: Colors.grey[600],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ===== BAHAN-BAHAN =====
                    _buildSectionCard('Bahan-bahan', ingredients),

                    const SizedBox(height: 16),

                    // ===== INSTRUKSI =====
                    _buildSectionCard(
                      'Instruksi',
                      instructions,
                      isNumbered: true,
                    ),

                    const SizedBox(height: 16),

                    // ===== NUTRISI =====
                    _buildSectionCard('Nutrisi', nutritionItems),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==== MINI WIDGET: INFO ITEM (TIME, SERVING)
  Widget _infoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 12, color: Colors.grey[600]),
        const SizedBox(width: 3),
        Text(
          text,
          style: GoogleFonts.poppins(fontSize: 11.5, color: Colors.grey[700]),
        ),
      ],
    );
  }

  // ==== MINI WIDGET: RATING STARS
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

  // ==== MINI WIDGET: SECTION CARD
  Widget _buildSectionCard(
    String title,
    List items, {
    bool isNumbered = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(items.length, (index) {
              final content = items[index].toString();
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  isNumbered ? '${index + 1}. $content' : '• $content',
                  style: GoogleFonts.poppins(fontSize: 13, height: 1.3),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
