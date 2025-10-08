// intro_viewmodel.dart
import 'package:flutter/material.dart';
import '../models/intro_model.dart';

class IntroViewModel extends ChangeNotifier {
  // Private fields
  int _currentPage = 0;
  late PageController _pageController;
  late List<IntroModel> _introPages;

  // Constructor
  IntroViewModel() {
    _pageController = PageController();
    _initializeIntroPages();
  }

  // Getters
  int get currentPage => _currentPage;
  PageController get pageController => _pageController;
  List<IntroModel> get introPages => _introPages;
  int get totalPages => _introPages.length;
  bool get isLastPage => _currentPage == _introPages.length - 1;
  bool get isFirstPage => _currentPage == 0;

  // Initialize intro pages data
  void _initializeIntroPages() {
    _introPages = [
      IntroModel(
        title: 'Ask AI Chatbot Anything',
        description: '',
        imagePath: 'assets/images/intro1.png',
      ),
      IntroModel(
        title: 'Personalized Assistant',
        description: '',
        imagePath: 'assets/images/intro2.png',
      ),
      IntroModel(
        title: 'List of Expert Assistants',
        description: '',
        imagePath: 'assets/images/intro3.png',
      ),
      IntroModel(
        title: 'AI Chat History',
        description: '',
        imagePath: 'assets/images/intro4.png',
      ),
    ];
  }

  // Methods
  void onPageChanged(int index) {
    _currentPage = index;
    notifyListeners();
  }

  void nextPage() {
    if (!isLastPage) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  void previousPage() {
    if (!isFirstPage) {
      _currentPage--;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  void skipToLastPage() {
    _currentPage = _introPages.length - 1;
    _pageController.animateToPage(
      _currentPage,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  void jumpToPage(int page) {
    if (page >= 0 && page < _introPages.length) {
      _currentPage = page;
      _pageController.jumpToPage(page);
      notifyListeners();
    }
  }

  // Get button text based on current page
  String getButtonText() {
    return isLastPage ? 'START' : 'NEXT';
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}