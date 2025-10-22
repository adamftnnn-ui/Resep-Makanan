import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../views/components/card.dart';
import '../views/components/search_bar.dart';

class DaftarResepController extends StatefulWidget {
  const DaftarResepController({super.key, required String initialKeyword});

  @override
  State<DaftarResepController> createState() => _DaftarResepControllerState();
}

class _DaftarResepControllerState extends State<DaftarResepController> {
  final List<Map<String, dynamic>> recipes = [
    {
      'image': 'assets/images/banner1.png',
      'title': 'Nasi Goreng Spesial',
      'country': 'Indonesia',
      'isHalal': true,
      'time': '15′',
      'serving': '2',
      'rating': 4.8,
    },
    {
      'image': 'assets/images/banner2.png',
      'title': 'Ayam Bakar Madu',
      'country': 'Indonesia',
      'isHalal': true,
      'time': '25′',
      'serving': '3',
      'rating': 4.9,
    },
    {
      'image': 'assets/images/banner3.png',
      'title': 'Mie Goreng Jawa',
      'country': 'Indonesia',
      'isHalal': true,
      'time': '20′',
      'serving': '2',
      'rating': 4.7,
    },
    // bisa ditambah lagi
  ];

  @override
  Widget build(BuildContext context) {
    final double spacing = 12;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth =
        (screenWidth - (spacing * 3) - 16) / 2; // padding 16 left+right

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF9FAFB),
        body: Column(
          children: [
            // ===== HEADER =====
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 20,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Daftar Resep',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // spacer agar center tetap tepat
                ],
              ),
            ),

            // ===== SEARCH BAR =====
            const HomeSearchBar(),

            // ===== LIST RESEP =====
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: recipes.map((item) {
                    return SizedBox(
                      width: cardWidth,
                      child: HomeCard(
                        image: item['image'] as String?,
                        title: item['title'] as String,
                        country: item['country'] as String,
                        isHalal: item['isHalal'] as bool,
                        time: item['time'] as String,
                        serving: item['serving'] as String,
                        rating: item['rating'] as double,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
