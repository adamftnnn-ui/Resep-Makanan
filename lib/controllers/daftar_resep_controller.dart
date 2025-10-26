import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../views/components/card.dart';
import '../views/components/search_bar.dart';

class DaftarResepController extends StatefulWidget {
  final String initialKeyword;
  final String title;

  const DaftarResepController({
    super.key,
    required this.initialKeyword,
    this.title = 'Daftar Resep',
  });

  @override
  State<DaftarResepController> createState() => _DaftarResepControllerState();
}

class _DaftarResepControllerState extends State<DaftarResepController>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> recipes = [
    {
      'image': 'assets/images/banner1.png',
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
      'image': 'assets/images/banner3.png',
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

  late List<Map<String, dynamic>> filteredRecipes;
  late AnimationController _animationController;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    final keyword = widget.initialKeyword.toLowerCase();
    filteredRecipes = recipes
        .where((r) => r['title'].toString().toLowerCase().contains(keyword))
        .toList();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _fadeIn = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleSearch(String keyword) {
    setState(() {
      filteredRecipes = recipes
          .where(
            (r) => r['title'].toString().toLowerCase().contains(
              keyword.toLowerCase(),
            ),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double spacing = 14;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = (screenWidth - (spacing * 3) - 16) / 2;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF9FAFB),
        body: Column(
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
                        widget.title,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 38),
                ],
              ),
            ),

            HomeSearchBar(
              initialValue: widget.initialKeyword,
              onSubmitted: _handleSearch,
              onClear: () {
                setState(() {
                  filteredRecipes = recipes;
                });
              },
              enableNavigation: false,
              padding: const EdgeInsets.fromLTRB(20, 6, 20, 8),
            ),

            const SizedBox(height: 8),

            // ===== LIST RESEP =====
            Expanded(
              child: FadeTransition(
                opacity: _fadeIn,
                child: filteredRecipes.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 120),
                          child: Column(
                            children: [
                              Icon(
                                Icons.search_off_rounded,
                                color: Colors.grey[400],
                                size: 60,
                              ),
                              const SizedBox(height: 14),
                              Text(
                                'Tidak ditemukan',
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Wrap(
                            spacing: spacing,
                            runSpacing: spacing,
                            children: filteredRecipes.map((item) {
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
                                  ingredients:
                                      item['ingredients'] as List<String>,
                                  instructions:
                                      item['instructions'] as List<String>,
                                  nutrition:
                                      item['nutrition'] as Map<String, String>,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
