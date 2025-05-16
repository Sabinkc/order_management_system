class FaqModel {
  final String id;
  final String title;
  final String description;

  FaqModel({
    required this.id,
    required this.title,
    required this.description,
  });

  @override
  String toString() {
    return 'FaqModel(id: $id, title: $title, description: $description)';
  }
}
