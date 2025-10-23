import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:google_fonts/google_fonts.dart';
import '/controllers/kategori_controller.dart';

// Data kategori dan itemnya
final kategoriData = {
  'Halal': ['Halal', 'Non-Halal'],
  'Diet': ['Vegetarian', 'Vegan', 'Keto'],
  'Hidangan': ['Utama', 'Pembuka', 'Penutup'],
  'Acara': ['Ulang Tahun', 'Ramadhan', 'Natal'],
  'Negara': ['Indonesia', 'Malaysia', 'Thailand', 'Vietnam', 'Jepang'],
};

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'icon': HugeIcons.strokeRoundedHalal, 'label': 'Halal'},
      {'icon': HugeIcons.strokeRoundedHealth, 'label': 'Diet'},
      {'icon': HugeIcons.strokeRoundedPlate, 'label': 'Hidangan'},
      {'icon': HugeIcons.strokeRoundedSpoonAndFork, 'label': 'Acara'},
      {'icon': HugeIcons.strokeRoundedEarth, 'label': 'Negara'},
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: categories.map((item) {
                final label = item['label'] as String;

                return GestureDetector(
                  onTap: () {
                    KategoriController.showKategoriPopup(
                      context,
                      title: label,
                      items: kategoriData[label]!,
                      onSelected: (value) {
                        print('Dipilih $label: $value');
                        // Bisa panggil DaftarResepController atau update state di sini
                      },
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 52,
                        width: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          item['icon'] as IconData,
                          color: const Color(0xFF4CAF50),
                          size: 24,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        label,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
