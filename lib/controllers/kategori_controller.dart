import 'package:flutter/material.dart';
import '../views/components/kategori_modal.dart';

class KategoriController {
  static void showKategoriPopup(
    BuildContext context, {
    required String title,
    required List<String> items,
    Function(String)? onSelected, // callback saat user pilih item
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (context) =>
          KategoriModal(title: title, items: items, onSelected: onSelected),
    );
  }
}
