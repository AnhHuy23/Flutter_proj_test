// intro_model.dart
class IntroModel {
  final String title;
  final String description;
  final String imagePath;

  IntroModel({
    required this.title,
    required this.description,
    required this.imagePath,
  });

  // Factory constructor để tạo từ JSON (nếu cần)
  factory IntroModel.fromJson(Map<String, dynamic> json) {
    return IntroModel(
      title: json['title'] as String,
      description: json['description'] as String,
      imagePath: json['imagePath'] as String,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'imagePath': imagePath,
    };
  }
}