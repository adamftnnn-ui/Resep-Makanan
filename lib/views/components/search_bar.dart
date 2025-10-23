import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:google_fonts/google_fonts.dart';
import '/controllers/pencarian_controller.dart';
import '/controllers/daftar_resep_controller.dart';

class HomeSearchBar extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final Function(String)? onSubmitted;
  final VoidCallback? onClear;
  final EdgeInsetsGeometry? padding;
  final bool enableNavigation;
  final String? placeholder;

  const HomeSearchBar({
    super.key,
    this.controller,
    this.initialValue,
    this.onSubmitted,
    this.onClear,
    this.padding,
    this.enableNavigation = true,
    this.placeholder,
  });

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  late TextEditingController searchController;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    searchController =
        widget.controller ??
        TextEditingController(text: widget.initialValue ?? "");
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      searchController.dispose();
    }
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.fromLTRB(20, 6, 20, 4),
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
                      readOnly: widget.enableNavigation, // 🔹 ini penting
                      focusNode: _focusNode,
                      controller: searchController,
                      style: GoogleFonts.poppins(
                        fontSize: 13.5,
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        hintText:
                            widget.placeholder ?? 'Cari resep atau bahan...',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 13.5,
                          color: Colors.grey[400],
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        suffixIcon: searchController.text.isEmpty
                            ? null
                            : IconButton(
                                icon: const Icon(
                                  Icons.close_rounded,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  searchController.clear();
                                  widget.onClear?.call();
                                  setState(() {});
                                },
                              ),
                        suffixIconConstraints: const BoxConstraints(
                          minWidth: 30,
                          minHeight: 30,
                        ),
                      ),
                      onTap: () {
                        if (widget.enableNavigation) {
                          _focusNode.unfocus(); // hilangkan fokus
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PencarianController(),
                            ),
                          );
                        }
                      },
                      onSubmitted: (value) {
                        if (widget.onSubmitted != null) {
                          widget.onSubmitted!(value);
                          searchController.clear();
                          setState(() {});
                        }
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
              color: Colors.white,
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
              color: Colors.black54,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}
