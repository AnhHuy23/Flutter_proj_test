import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/intro_viewmodel.dart';
import '../models/intro_model.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => IntroViewModel(),
      child: const _IntroScreenView(),
    );
  }
}

class _IntroScreenView extends StatelessWidget {
  const _IntroScreenView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildPageView(context),
            _buildBottomSection(context),
          ],
        ),
      ),
    );
  }

  /// ----- PAGE VIEW -----
  Widget _buildPageView(BuildContext context) {
    final viewModel = context.watch<IntroViewModel>();

    return Expanded(
      child: PageView.builder(
        controller: viewModel.pageController,
        onPageChanged: viewModel.onPageChanged,
        itemCount: viewModel.totalPages,
        itemBuilder: (context, index) {
          return _IntroPageItem(
            intro: viewModel.introPages[index],
            index: index,
          );
        },
      ),
    );
  }

  /// ----- BOTTOM SECTION -----
  Widget _buildBottomSection(BuildContext context) {
    final viewModel = context.watch<IntroViewModel>();

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Indicator + Next
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: List.generate(
                  viewModel.totalPages,
                  (index) => _DotIndicator(
                    index: index,
                    currentIndex: viewModel.currentPage,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (viewModel.isLastPage) {
                    Navigator.pushReplacementNamed(context, '/home');
                  } else {
                    viewModel.nextPage();
                  }
                },
                child: Text(
                  viewModel.isLastPage ? 'Start' : 'Next',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          _buildAdvertisementBanner(context),
        ],
      ),
    );
  }

  /// ----- ADVERTISEMENT BANNER -----
  Widget _buildAdvertisementBanner(BuildContext context) {
    return Container(
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
            color: Colors.black.withOpacity(0.08),
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
            crossAxisAlignment: CrossAxisAlignment.start,
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

          // Nút SIGN UP bên trong khung
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              onPressed: () {
                // TODO: Xử lý khi nhấn nút SIGN UP (nếu cần)
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
    );
  }
}

class _IntroPageItem extends StatelessWidget {
  final IntroModel intro;
  final int index;

  const _IntroPageItem({
    required this.intro,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildImage(intro.imagePath),
        _buildDescription(intro),
      ],
    );
  }

  /// ----- HÌNH ẢNH NỬA TRÊN -----
  Widget _buildImage(String imagePath) {
    return Expanded(
      flex: 2,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 400,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.white.withOpacity(0.6),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ----- PHẦN MÔ TẢ -----
  Widget _buildDescription(IntroModel intro) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              intro.title,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              intro.description,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 14,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _DotIndicator extends StatelessWidget {
  final int index;
  final int currentIndex;

  const _DotIndicator({
    required this.index,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final distance = (index - currentIndex).abs();
    double opacity = 1.0 - (distance * 0.4);
    if (opacity < 0.3) opacity = 0.3;

    final baseColor = const Color(0xFF50C080);
    final color = baseColor.withOpacity(opacity);
    final width = index == currentIndex ? 24 : 8;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: width.toDouble(),
      height: 8,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
