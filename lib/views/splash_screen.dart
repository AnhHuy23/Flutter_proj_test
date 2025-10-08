import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/splash_viewmodel.dart';
import 'language_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SplashViewModel(),
      child: Consumer<SplashViewModel>(
        builder: (context, vm, _) {
          if (vm.progress == 0) {
            vm.startLoading(() {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LanguageScreen()),
              );
            });
          }

          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4ECDC4),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(Icons.chat_bubble_outline,
                            size: 40, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'ChiChi',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const Text(
                    'AI Chat Characters',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 80),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: vm.progress,
                            color: const Color(0xFF4ECDC4),
                            backgroundColor: Colors.grey[300],
                            minHeight: 5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${(vm.progress * 100).toInt()}%',
                          style: const TextStyle(
                              color: Colors.black54, fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'This action may contain advertising...',
                          style:
                              TextStyle(color: Colors.black38, fontSize: 11.5),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
