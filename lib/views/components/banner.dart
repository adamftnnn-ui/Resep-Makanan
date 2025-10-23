import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({super.key});

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  final PageController _controller = PageController();
  int _currentIndex = 0;
  Timer? _timer;

  final List<String> _banners = [
    'assets/images/banner1.png',
    'assets/images/banner2.png',
    'assets/images/banner3.png',
  ];

  bool _userScroll = false; // menandai user sedang swipe

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!_userScroll && _controller.hasClients) {
        int nextPage = _currentIndex + 1;
        if (nextPage >= _banners.length) nextPage = 0;
        _controller.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      child: SizedBox(
        height: 180,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                if (notification.direction != ScrollDirection.idle) {
                  _userScroll = true; // user mulai swipe
                } else {
                  // user berhenti swipe
                  _userScroll = false;
                }
                return false;
              },
              child: PageView.builder(
                controller: _controller,
                itemCount: _banners.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(28),
                        child: Image.asset(
                          _banners[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // indikator dot
            Positioned(
              bottom: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _banners.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      height: 6,
                      width: _currentIndex == index ? 10 : 6,
                      decoration: BoxDecoration(
                        color: _currentIndex == index
                            ? const Color(0xFF4CAF50)
                            : const Color(0xFFD1D1D6),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
