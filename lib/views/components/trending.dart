import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'card.dart';

class HomeTrending extends StatelessWidget {
  const HomeTrending({super.key});

  @override
  Widget build(BuildContext context) {
    final trendingRecipes = [
      {
        'image': 'assets/images/banner2.png',
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
        'image': 'assets/images/banner2.png',
        'title': 'Mie Goreng Jawa',
        'country': 'Indonesia',
        'isHalal': true,
        'time': '20′',
        'serving': '2',
        'rating': 4.7,
      },
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== TITLE BAR =====
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Resep Trending",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  letterSpacing: 0.2,
                ),
              ),
              Text(
                "Lihat semua",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF4CAF50),
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // ===== LIST OF HomeCardS =====
          SizedBox(
            height: 190, // Tinggi pas tanpa space
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: trendingRecipes.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final item = trendingRecipes[index];
                return HomeCard(
                  image: item['image'] as String?,
                  title: item['title'] as String,
                  country: item['country'] as String,
                  isHalal: item['isHalal'] as bool,
                  time: item['time'] as String,
                  serving: item['serving'] as String,
                  rating: item['rating'] as double,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
