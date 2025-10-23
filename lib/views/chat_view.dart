import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/chat_controller.dart';
import './components/chat_bubble.dart';
import './components/search_bar.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final ChatController controller = ChatController();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _inputController = TextEditingController();

  // default avatar untuk user dan assistant
  final String _userAvatar = 'assets/images/avatar.jpg';
  final String _assistantAvatar = 'assets/images/avatar_ai.jpg';

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    // Tambahkan chat user
    setState(() {
      controller.chats.add({
        'avatarUrl': _userAvatar,
        'name': 'Adam',
        'role': null,
        'message': text,
        'time': TimeOfDay.now().format(context),
      });
    });

    _inputController.clear();

    // scroll ke bawah otomatis
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 80,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });

    // Simulasi balasan AI setelah 500ms
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        controller.chats.add({
          'avatarUrl': _assistantAvatar,
          'name': 'Kama',
          'role': 'Asisten',
          'message': 'Ini adalah balasan dari AI.',
          'time': TimeOfDay.now().format(context),
        });
      });

      Future.delayed(const Duration(milliseconds: 50), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent + 80,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            // ===== HEADER =====
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Center(
                child: Text(
                  'Obrolan',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),

            // ===== CHAT LIST =====
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: controller.chats.length,
                itemBuilder: (context, index) {
                  final chat = controller.chats[index];
                  return ChatBubble(
                    avatar: chat['avatarUrl'] ?? '',
                    name: chat['name'] ?? 'User',
                    role: chat['role'],
                    message: chat['message'] ?? '',
                    time: chat['time'] ?? '',
                    isAssistant: chat['role'] != null,
                  );
                },
              ),
            ),

            // ===== SEARCH BAR =====
           HomeSearchBar(
              enableNavigation: false,
              placeholder: 'Ketik pertanyaanmu disini...',
              initialValue: '',
              onSubmitted: _sendMessage,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              controller: _inputController, 
            ),
            const SizedBox(height: 16), // spasi dari bawah layar
          ],
        ),
      ),
    );
  }
}
