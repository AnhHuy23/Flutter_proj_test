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
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 30), // thêm khoảng cách hợp lý
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

          const SizedBox(height: 28), // khoảng cách giữa dot và banner

          _buildAdvertisementBanner(context),
        ],
      ),
    );
  }

  /// ----- ADVERTISEMENT BANNER -----
  Widget _buildAdvertisementBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 130, // tăng chiều cao banner
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Logo
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFF4ECDC4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 14),

          // Text mô tả
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // căn giữa theo chiều cao banner
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hanami',
                  style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Ứng dụng xem truyện hàng đầu Việt Nam! Thỏa sức đắm chìm trong hơn 2000 bộ truyện đa thể loại tại Hanami!',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.5,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // Nút Sign Up
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4ECDC4),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {},
            child: const Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.bold,
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
          // Ảnh nền chính
          Container(
            width: double.infinity,
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
          // Gradient mờ nhẹ chỉ ở phần dưới ảnh
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
    final distance = (index - currentIndex).abs(); // 0, 1, 2, ...
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
