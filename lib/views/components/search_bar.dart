import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:google_fonts/google_fonts.dart';
import '/controllers/daftar_resep_controller.dart'; // path ke controller

class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({super.key});

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 6, 20, 4),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  Icon(
                    HugeIcons.strokeRoundedSearch01,
                    color: Colors.black54,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      style: GoogleFonts.poppins(
                        fontSize: 13.5,
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Cari resep atau bahan...',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 13.5,
                          color: Colors.grey[400],
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        // ===== X BUTTON DI PADA RIGHT =====
                        suffixIcon: searchController.text.isEmpty
                            ? null
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    searchController.clear();
                                  });
                                },
                                child: const Icon(
                                  Icons.close_rounded,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                              ),
                        suffixIconConstraints: const BoxConstraints(
                          minWidth: 30,
                          minHeight: 30,
                        ),
                      ),
                      onSubmitted: (value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DaftarResepController(initialKeyword: value),
                          ),
                        );
                      },
                      onChanged: (_) {
                        setState(() {}); // refresh X button
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50),
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              HugeIcons.strokeRoundedMic01,
              color: Colors.white,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}
