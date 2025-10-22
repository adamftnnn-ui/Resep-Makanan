import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui'; // untuk blur

class HomeEvent extends StatelessWidget {
  const HomeEvent({super.key});

  @override
  Widget build(BuildContext context) {
    final events = [
      {
        'title': 'Spesial Ramadan',
        'subtitle': 'Temukan inspirasi masakan buka puasa',
        'image': 'assets/images/banner1.png',
        'color': const Color(0xFFFFF8E1),
      },
      {
        'title': 'Menu Akhir Pekan',
        'subtitle': 'Resep santai bareng keluarga di rumah',
        'image': 'assets/images/banner2.png',
        'color': const Color(0xFFE3F2FD),
      },
      {
        'title': 'Inspirasi Harian',
        'subtitle': 'Coba resep baru setiap hari!',
        'image': 'assets/images/banner3.png',
        'color': const Color(0xFFF3E5F5),
      },
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Rekomendasi",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 165,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: events.length,
              separatorBuilder: (context, index) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                final event = events[index];
                return Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: event['color'] as Color,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Row(
                    children: [
                      // TEKS KIRI
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 18,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // judul + subtitle
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    event['title'] as String,
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    event['subtitle'] as String,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: Colors.black87.withOpacity(0.7),
                                      height: 1.3,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                ],
                              ),
                              // tombol lihat semua blur hijau
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 10,
                                    sigmaY: 10,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.50),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      "Lihat Semua",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // GAMBAR KANAN
                      Expanded(
                        flex: 5,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          child: (event['image'] as String).trim().isNotEmpty
                              ? Image.asset(
                                  event['image'] as String,
                                  height: double.infinity,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  color: const Color(0xFFF4F6F8),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Belum ada gambar",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.2,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
