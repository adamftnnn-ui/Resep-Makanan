import 'package:flutter/material.dart';
import 'components/header.dart';
import 'components/banner.dart';
import 'components/category.dart';
import 'components/search_bar.dart';
import 'components/suggestion.dart';
import 'components/trending.dart';
import 'components/event.dart';
import '../../models/user_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserModel(name: 'Adam', avatarUrl: 'assets/images/avatar.jpg');

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF9FAFB),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Header(user: user),
            const HomeBanner(),
            const Category(),
            const HomeSearchBar(),
            const HomeSuggestion(),
            const HomeTrending(),
            const HomeEvent(),
          ],
        ),
      ),
    );
  }
}
