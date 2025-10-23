import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '/controllers/profil_controller.dart';
import '../views/home_view.dart';
import '../views/create_recipe_view.dart';
import '../views/chat_view.dart';
import '../views/profile_view.dart';

class MainController extends StatefulWidget {
  const MainController({super.key});

  @override
  State<MainController> createState() => _MainControllerState();
}

class _MainControllerState extends State<MainController> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeView(),
    CreateRecipeView(),
    ChatView(),
    ProfileView(controller: ProfilController()),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildNavItem({
    required IconData iconData,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: isActive
                  ? const Color(0xFF4CAF50)
                  : const Color(0xFFE5E5EA),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(iconData, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isActive ? const Color(0xFF4CAF50) : Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              iconData: HugeIcons.strokeRoundedHome01,
              label: 'Beranda',
              isActive: _selectedIndex == 0,
              onTap: () => _onItemTapped(0),
            ),
            _buildNavItem(
              iconData: HugeIcons.strokeRoundedAddSquare,
              label: 'Buat Resep',
              isActive: _selectedIndex == 1,
              onTap: () => _onItemTapped(1),
            ),
            _buildNavItem(
              iconData: HugeIcons.strokeRoundedBubbleChat,
              label: 'Obrolan',
              isActive: _selectedIndex == 2,
              onTap: () => _onItemTapped(2),
            ),
            _buildNavItem(
              iconData: HugeIcons.strokeRoundedUser,
              label: 'Profil',
              isActive: _selectedIndex == 3,
              onTap: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }
}
