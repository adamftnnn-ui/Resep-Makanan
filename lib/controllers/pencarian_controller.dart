import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../views/components/search_bar.dart';
import '/controllers/daftar_resep_controller.dart';

class PencarianController extends StatefulWidget {
  const PencarianController({super.key});

  @override
  State<PencarianController> createState() => _PencarianControllerState();
}

class _PencarianControllerState extends State<PencarianController> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final List<String> searchHistory = [
    'Nasi Goreng Spesial',
    'Ayam Bakar Madu',
    'Mie Goreng Jawa',
    'Soto Ayam',
    'Bakso Kuah',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleSearch(String value) {
    if (value.trim().isEmpty) return;
    FocusScope.of(context).unfocus();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DaftarResepController(initialKeyword: value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF9FAFB),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        'Pencarian',
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

            // ===== SEARCH BAR =====
            HomeSearchBar(
  initialValue: _searchController.text,
  onSubmitted: _handleSearch,
  padding: const EdgeInsets.fromLTRB(20, 6, 20, 8),
  enableNavigation: false, // 🔹 Penting agar tidak navigasi lagi
  controller: _searchController,
),

            // ===== BODY =====
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Label TERBARU
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Terbaru',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          'Lihat Semua',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF007AFF),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // List Riwayat
                    ...searchHistory.map((item) {
                      final isLast = item == searchHistory.last;
                      return Column(
                        children: [
                          InkWell(
                            onTap: () => _handleSearch(item),
                            borderRadius: BorderRadius.circular(10),
                            splashColor: Colors.grey.withOpacity(0.08),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 2,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.history_rounded,
                                    color: Colors.grey.shade500,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      item,
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey.shade500,
                                        letterSpacing: 0.1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (!isLast)
                            Container(
                              height: 0.5,
                              color: Colors.grey.withOpacity(0.25),
                            ),
                        ],
                      );
                    }).toList(),

                    const SizedBox(height: 20),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            searchHistory.clear();
                          });
                        },
                        child: Text(
                          'Hapus Riwayat',
                          style: GoogleFonts.poppins(
                            fontSize: 14.5,
                            color: const Color(0xFFFF3B30),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
