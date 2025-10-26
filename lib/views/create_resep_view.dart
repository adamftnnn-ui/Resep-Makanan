// lib/views/create_resep_view.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:projekakhir2/controllers/create_resep_controller.dart';

class CreateRecipeView extends StatefulWidget {
  final CreateResepController controller;

  const CreateRecipeView({super.key, required this.controller});

  @override
  State<CreateRecipeView> createState() => _CreateRecipeViewState();
}

class _CreateRecipeViewState extends State<CreateRecipeView> {
  final TextEditingController _titleC = TextEditingController();
  final TextEditingController _timeC = TextEditingController();
  final TextEditingController _servingC = TextEditingController();

  String? _selectedCountry;
  bool _isHalal = false;
  String? _selectedImage;

  final List<String> _ingredients = [];
  final List<String> _steps = [];
  final List<Map<String, String>> _nutritions = [];

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.poppins(fontSize: 13.5, color: Colors.grey[400]),
      filled: true,
      fillColor: const Color(0xFFF9FAFB),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 1.2),
      ),
    );
  }

  // ===== DIALOG MULTI-LINE UNTUK BAHAN / INSTRUKSI =====
  void _showAddMultiLineDialog({
    required String title,
    required void Function(List<String>) onSave,
    String hint = '',
  }) {
    final textC = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Container(
          padding: const EdgeInsets.all(18),
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: textC,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 13.5,
                    color: Colors.grey[400],
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
                ),
                maxLines: 6,
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Batal', style: GoogleFonts.poppins()),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (textC.text.trim().isEmpty) return;
                      final lines = textC.text
                          .split('\n')
                          .map((e) => e.trim())
                          .where((e) => e.isNotEmpty)
                          .toList();
                      onSave(lines);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      'Simpan',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===== DIALOG NUTRISI =====
  void _showAddNutritionDialog({
    required void Function(String label, String value) onSave,
  }) {
    final labelC = TextEditingController();
    final valueC = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Container(
          padding: const EdgeInsets.all(18),
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Tambah Nutrisi',
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: labelC,
                decoration: _inputDecoration('Label (cth: Protein)'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: valueC,
                decoration: _inputDecoration('Nilai'),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Batal', style: GoogleFonts.poppins()),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (labelC.text.trim().isEmpty) return;
                      onSave(labelC.text.trim(), valueC.text.trim());
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      'Simpan',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Buat Resep',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildInfoBox(),
              const SizedBox(height: 20),
              _buildIngredientsBox(),
              const SizedBox(height: 20),
              _buildStepsBox(),
              const SizedBox(height: 20),
              _buildNutritionBox(),
            ],
          ),
        ),
      ),
    );
  }

  // ==== INFO BOX ====
  Widget _buildInfoBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: _selectedImage != null
                  ? Image.asset(
                      _selectedImage!,
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 160,
                      width: double.infinity,
                      color: const Color(0xFFF2F3F5),
                      alignment: Alignment.center,
                      child: Text(
                        'Ketuk untuk menambahkan gambar',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _titleC,
            decoration: _inputDecoration('Judul Resep'),
            onChanged: (v) => widget.controller.setTitle(v),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: DropdownButtonFormField<String>(
                  decoration: _inputDecoration(
                    'Negara',
                  ).copyWith(isDense: true),
                  items: ['Indonesia', 'Italia', 'Jepang', 'India']
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: GoogleFonts.poppins(fontSize: 13.5),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (v) {
                    setState(() => _selectedCountry = v);
                    widget.controller.setCountry(v ?? '');
                  },
                  value: _selectedCountry,
                  borderRadius: BorderRadius.circular(14),
                  icon: const Icon(
                    HugeIcons.strokeRoundedArrowDown01,
                    size: 18,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Halal',
                        style: GoogleFonts.poppins(
                          fontSize: 13.5,
                          color: Colors.grey[700],
                        ),
                      ),
                      Switch(
                        value: _isHalal,
                        activeColor: const Color(0xFF4CAF50),
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: const Color(0xFFE0E0E0),
                        onChanged: (v) {
                          setState(() => _isHalal = v);
                          widget.controller.setHalal(v);
                        },
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _timeC,
                  keyboardType: TextInputType.number,
                  decoration: _inputDecoration('Waktu').copyWith(
                    suffixText: 'menit',
                    suffixStyle: GoogleFonts.poppins(
                      color: Colors.grey[600],
                      fontSize: 13.5,
                    ),
                  ),
                  onChanged: (v) => widget.controller.setTime(v),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _servingC,
                  keyboardType: TextInputType.number,
                  decoration: _inputDecoration('Porsi').copyWith(
                    suffixText: 'porsi',
                    suffixStyle: GoogleFonts.poppins(
                      color: Colors.grey[600],
                      fontSize: 13.5,
                    ),
                  ),
                  onChanged: (v) => widget.controller.setServing(v),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

  // ==== BAHAN ====
  Widget _buildIngredientsBox() {
    return _buildSectionMultiLine(
      title: 'Bahan-bahan',
      items: _ingredients,
      bullet: true,
      onAdd: () => _showAddMultiLineDialog(
        title: 'Tambah Bahan-bahan',
        hint: 'Tulis setiap bahan di baris baru',
        onSave: (lines) {
          setState(() => _ingredients.addAll(lines));
          widget.controller.setIngredients(_ingredients);
        },
      ),
    );
  }

  // ==== LANGKAH ====
  Widget _buildStepsBox() {
    return _buildSectionMultiLine(
      title: 'Langkah-langkah',
      items: _steps,
      isNumbered: true,
      onAdd: () => _showAddMultiLineDialog(
        title: 'Tambah Langkah',
        hint: 'Tulis setiap langkah di baris baru',
        onSave: (lines) {
          setState(() => _steps.addAll(lines));
          widget.controller.setSteps(_steps);
        },
      ),
    );
  }

  // ==== NUTRISI ====
  Widget _buildNutritionBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Informasi Nutrisi',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _showAddNutritionDialog(
                  onSave: (label, value) {
                    setState(
                      () => _nutritions.add({'label': label, 'value': value}),
                    );
                    widget.controller.setNutritions(_nutritions);
                  },
                ),
                child: Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    HugeIcons.strokeRoundedAdd01,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_nutritions.isEmpty)
            Text(
              'Belum ada data nutrisi ditambahkan',
              style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[500]),
            )
          else
            Column(
              children: List.generate(_nutritions.length, (i) {
                final item = _nutritions[i];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFCFCFD),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200, width: 0.8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          item['label']!,
                          style: GoogleFonts.poppins(
                            fontSize: 13.5,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          item['value']!,
                          textAlign: TextAlign.right,
                          style: GoogleFonts.poppins(
                            fontSize: 13.5,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          setState(() => _nutritions.removeAt(i));
                          widget.controller.setNutritions(_nutritions);
                        },
                        child: Icon(
                          HugeIcons.strokeRoundedXVariableCircle,
                          size: 18,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
        ],
      ),
    );
  }

  // ==== GENERIC SECTION UNTUK BAHAN / LANGKAH MULTI-LINE ====
  Widget _buildSectionMultiLine({
    required String title,
    required List<String> items,
    bool isNumbered = false,
    bool bullet = false,
    required VoidCallback onAdd,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onAdd,
                child: Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    HugeIcons.strokeRoundedAdd01,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (items.isEmpty)
            Text(
              'Belum ada item ditambahkan',
              style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[500]),
            )
          else
            Column(
              children: List.generate(items.length, (i) {
                final item = items[i];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFCFCFD),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade200, width: 0.8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isNumbered)
                        Container(
                          height: 22,
                          width: 22,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2F3F5),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${i + 1}',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      if (bullet && !isNumbered)
                        Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.only(right: 10, top: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            shape: BoxShape.circle,
                          ),
                        ),
                      Expanded(
                        child: Text(
                          item,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.grey[700],
                            height: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          setState(() => items.removeAt(i));
                          if (title == 'Bahan-bahan')
                            widget.controller.setIngredients(_ingredients);
                          if (title == 'Langkah-langkah')
                            widget.controller.setSteps(_steps);
                        },
                        child: Icon(
                          HugeIcons.strokeRoundedXVariableCircle,
                          size: 18,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
        ],
      ),
    );
  }
}
