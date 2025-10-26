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
  final TextEditingController _ingredientC = TextEditingController();
  final TextEditingController _stepC = TextEditingController();
  final TextEditingController _nutritionLabelC = TextEditingController();
  final TextEditingController _nutritionValueC = TextEditingController();

  final List<String> _ingredients = [];
  final List<String> _steps = [];
  final List<Map<String, String>> _nutritions = [];

  String? _selectedCountry;
  bool _isHalal = false;
  String? _selectedImage;

  void _addIngredient() {
    final text = _ingredientC.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _ingredients.add(text);
        _ingredientC.clear();
      });
      widget.controller.setIngredients(_ingredients);
    }
  }

  void _addStep() {
    final text = _stepC.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _steps.add(text);
        _stepC.clear();
      });
      widget.controller.setSteps(_steps);
    }
  }

  void _addNutrition() {
    final label = _nutritionLabelC.text.trim();
    final value = _nutritionValueC.text.trim();
    if (label.isNotEmpty && value.isNotEmpty) {
      setState(() {
        _nutritions.add({'label': label, 'value': value});
        _nutritionLabelC.clear();
        _nutritionValueC.clear();
      });
      widget.controller.setNutritions(_nutritions);
    }
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.poppins(fontSize: 13.5, color: Colors.grey[400]),
      filled: true,
      fillColor: const Color(0xFFF9FAFB),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
              // ===== HEADER =====
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

              // ===== INFO BOX =====
              _buildInfoBox(),
              const SizedBox(height: 20),

              // ===== INGREDIENTS =====
              _buildIngredientsBox(),
              const SizedBox(height: 20),

              // ===== STEPS =====
              _buildStepsBox(),
              const SizedBox(height: 20),

              // ===== NUTRITION =====
              _buildNutritionBox(),
            ],
          ),
        ),
      ),
    );
  }

  // ===== BOX INFORMASI DASAR =====
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
                  value:
                      _selectedCountry != null &&
                          [
                            'Indonesia',
                            'Italia',
                            'Jepang',
                            'India',
                          ].contains(_selectedCountry)
                      ? _selectedCountry
                      : null,
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
                  decoration: _inputDecoration('Waktu (menit)'),
                  onChanged: (v) => widget.controller.setTime(v),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _servingC,
                  keyboardType: TextInputType.number,
                  decoration: _inputDecoration('Porsi (orang)'),
                  onChanged: (v) => widget.controller.setServing(v),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ===== BOX BAHAN =====
  Widget _buildIngredientsBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bahan-bahan',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _ingredientC,
            onSubmitted: (_) => _addIngredient(),
            decoration: _inputDecoration('Tambahkan bahan...'),
          ),
          const SizedBox(height: 14),
          if (_ingredients.isEmpty)
            Text(
              'Belum ada bahan yang ditambahkan',
              style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[500]),
            )
          else
            Column(
              children: List.generate(_ingredients.length, (i) {
                final item = _ingredients[i];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
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
                      Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          shape: BoxShape.circle,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          item,
                          style: GoogleFonts.poppins(
                            fontSize: 13.5,
                            color: Colors.grey[700],
                            height: 1.4,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() => _ingredients.removeAt(i));
                          widget.controller.setIngredients(_ingredients);
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

  // ===== BOX LANGKAH =====
  Widget _buildStepsBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Langkah-langkah',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _stepC,
            onSubmitted: (_) => _addStep(),
            decoration: _inputDecoration('Tambahkan langkah...'),
          ),
          const SizedBox(height: 14),
          if (_steps.isEmpty)
            Text(
              'Belum ada langkah yang ditambahkan',
              style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[500]),
            )
          else
            Column(
              children: List.generate(_steps.length, (i) {
                final step = _steps[i];
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 26,
                        width: 26,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(right: 10, top: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${i + 1}',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF4CAF50),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Text(
                            step,
                            style: GoogleFonts.poppins(
                              fontSize: 13.5,
                              color: Colors.grey[700],
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          setState(() => _steps.removeAt(i));
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

  // ===== BOX NUTRISI =====
  Widget _buildNutritionBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informasi Nutrisi',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          // INPUT LABEL + ANGKA
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextField(
                  controller: _nutritionLabelC,
                  onSubmitted: (_) => _addNutrition(),
                  decoration: _inputDecoration('Label (cth: Protein)'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: TextField(
                  controller: _nutritionValueC,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => _addNutrition(),
                  decoration: _inputDecoration('Nilai'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
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
                          style: GoogleFonts.poppins(
                            fontSize: 13.5,
                            color: Colors.grey[700],
                          ),
                          textAlign: TextAlign.right,
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
}
