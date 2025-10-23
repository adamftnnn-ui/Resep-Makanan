import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class KategoriModal extends StatelessWidget {
  final String title;
  final List<String> items;
  final Function(String)? onSelected;

  const KategoriModal({
    super.key,
    required this.title,
    required this.items,
    this.onSelected,
  });

  // 🔹 Mapping ikon per kategori/item
  IconData _getIcon(String title, String item) {
    switch (title) {
      case 'Negara':
        return HugeIcons.strokeRoundedEarth;
      case 'Halal':
        return HugeIcons.strokeRoundedHalal;
      case 'Diet':
        // Contoh: item spesifik bisa beda ikon
        switch (item.toLowerCase()) {
          case 'vegetarian':
          case 'sayuran':
            return HugeIcons.strokeRoundedLeaf01;
          case 'vegan':
          case 'seimbang':
            return HugeIcons.strokeRoundedBalanceScale;
          case 'keto':
            return HugeIcons.strokeRoundedDrink;
          default:
            return HugeIcons.strokeRoundedHealth;
        }
      case 'Hidangan':
        switch (item.toLowerCase()) {
          case 'utama':
            return HugeIcons.strokeRoundedPlate;
          case 'pembuka':
            return HugeIcons.strokeRoundedSpoonAndFork;
          case 'penutup':
            return HugeIcons.strokeRoundedCheeseCake01;
          default:
            return HugeIcons.strokeRoundedPlate;
        }
      case 'Acara':
        switch (item.toLowerCase()) {
          case 'ulang tahun':
            return HugeIcons.strokeRoundedBirthdayCake;
          case 'ramadhan':
            return HugeIcons.strokeRoundedMoon;
          case 'natal':
            return HugeIcons.strokeRoundedStar;
          default:
            return HugeIcons.strokeRoundedCalendar01;
        }
      default:
        return HugeIcons.strokeRoundedCircle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ===== HEADER =====
            Container(
              padding: const EdgeInsets.fromLTRB(14, 8, 14, 12),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFEAEAEA), width: 0.8),
                ),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 34,
                      width: 34,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 17,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 34),
                ],
              ),
            ),

            // ===== LIST ITEM =====
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                itemCount: items.length,
                separatorBuilder: (_, __) =>
                    const Divider(color: Color(0xFFEAEAEA), height: 10),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Navigator.pop(context);
                      if (onSelected != null) onSelected!(item);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 4,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _getIcon(title, item),
                            size: 20,
                            color: Colors.black54,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              item,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
