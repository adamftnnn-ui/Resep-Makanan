import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/controllers/daftar_resep_controller.dart';
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
        'ingredients': [
          'Nasi putih 2 piring',
          'Telur 2 butir',
          'Kecap manis 2 sdm',
          'Bawang merah 3 siung',
        ],
        'instructions': [
          'Panaskan minyak di wajan.',
          'Tumis bawang hingga harum.',
          'Masukkan telur, orak-arik hingga matang.',
          'Tambahkan nasi dan kecap, aduk rata.',
        ],
        'nutrition': {
          'Kalori': '350 kkal',
          'Protein': '12 g',
          'Lemak': '10 g',
          'Karbohidrat': '50 g',
        },
      },
      {
        'image': 'assets/images/banner2.png',
        'title': 'Ayam Bakar Madu',
        'country': 'Indonesia',
        'isHalal': true,
        'time': '25′',
        'serving': '3',
        'rating': 4.9,
        'ingredients': [
          'Ayam 500 gr',
          'Madu 3 sdm',
          'Bawang putih 2 siung',
          'Garam dan merica secukupnya',
        ],
        'instructions': [
          'Marinasi ayam dengan madu dan bumbu.',
          'Diamkan 30 menit.',
          'Bakar ayam hingga matang dan harum.',
        ],
        'nutrition': {
          'Kalori': '420 kkal',
          'Protein': '35 g',
          'Lemak': '20 g',
          'Karbohidrat': '15 g',
        },
      },
      {
        'image': 'assets/images/banner2.png',
        'title': 'Mie Goreng Jawa',
        'country': 'Indonesia',
        'isHalal': true,
        'time': '20′',
        'serving': '2',
        'rating': 4.7,
        'ingredients': [
          'Mie telur 200 gr',
          'Sayuran campur 100 gr',
          'Kecap manis 2 sdm',
          'Bawang merah 2 siung',
        ],
        'instructions': [
          'Rebus mie hingga matang.',
          'Tumis bawang dan sayuran.',
          'Masukkan mie dan kecap, aduk rata.',
        ],
        'nutrition': {
          'Kalori': '300 kkal',
          'Protein': '10 g',
          'Lemak': '8 g',
          'Karbohidrat': '45 g',
        },
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DaftarResepController(
                        initialKeyword: '', // Kosongkan atau bisa pakai filter
                        title: 'Resep Trending', // title khusus
                      ),
                    ),
                  );
                },
                child: Text(
                  "Lihat semua",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF4CAF50),
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),


          const SizedBox(height: 14),

          // ===== LIST OF HomeCardS =====
          SizedBox(
            height: 190,
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
                  ingredients: item['ingredients'] as List<String>,
                  instructions: item['instructions'] as List<String>,
                  nutrition: item['nutrition'] as Map<String, String>,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
