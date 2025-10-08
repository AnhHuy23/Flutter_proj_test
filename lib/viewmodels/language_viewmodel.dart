import 'package:flutter/material.dart';
import '../models/language_model.dart';

class LanguageViewModel extends ChangeNotifier {
  final List<LanguageModel> _languages = [
    LanguageModel(name: 'Hindi', flag: '🇮🇳'),
    LanguageModel(name: 'Spanish', flag: '🇪🇸'),
    LanguageModel(name: 'French', flag: '🇫🇷'),
    LanguageModel(name: 'Portuguese', flag: '🇵🇹'),
    LanguageModel(name: 'German', flag: '🇩🇪'),
    LanguageModel(name: 'Japanese', flag: '🇯🇵'),
    LanguageModel(name: 'Korean', flag: '🇰🇷'),
    LanguageModel(name: 'English', flag: '🇬🇧'),
  ];

  String _selected = '';
  List<LanguageModel> get languages => _languages;
  String get selected => _selected;

  void selectLanguage(String lang) {
    _selected = lang;
    notifyListeners();
  }
}
