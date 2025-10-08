import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/language_viewmodel.dart';
import 'intro_screen.dart'; // màn hình intro bạn sẽ tạo sau

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LanguageViewModel(),
      child: Consumer<LanguageViewModel>(
        builder: (context, vm, _) => Scaffold(
          backgroundColor: const Color(0xFFF2F9FF),
          body: SafeArea(
            child: Column(
              children: [
                // ======= TOP BAR =======
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Language',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.check,
                            color: Colors.black, size: 28),
                        onPressed: () {
                          // Chuyển sang màn Intro
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => IntroScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // ======= LANGUAGE LIST =======
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    itemCount: vm.languages.length,
                    itemBuilder: (context, i) {
                      final lang = vm.languages[i];
                      final selected = lang.name == vm.selected;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: InkWell(
                          onTap: () => vm.selectLanguage(lang.name),
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFF50C880),
                                width: 2,
                              ),
                              color: selected
                                  ? const Color(0xFF50C880)
                                  : Colors.white,
                            ),
                            child: Row(
                              children: [
                                Text(lang.flag,
                                    style: const TextStyle(fontSize: 24)),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    lang.name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: selected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // ======= SIGN UP + QUẢNG CÁO (gộp chung) =======
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF50C880), Color.fromARGB(255, 180, 227, 199)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nội dung quảng cáo
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.workspace_premium,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Try Moana Plus',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Top answers, no limits.\nExperience the Plus tier.',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                      height: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Nút SIGN UP trong cùng khung
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            onPressed: () {
                              // TODO: xử lý đăng ký
                            },
                            child: const Text(
                              'SIGN UP',
                              style: TextStyle(
                                color: Color(0xFF50C880),
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
