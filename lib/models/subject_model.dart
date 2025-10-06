class Subject {
  final String id;
  final String name;
  final String description;

  Subject({required this.id, required this.name, required this.description});

  Map<String, dynamic> toMap() {
    return {'name': name, 'description': description};
  }

  factory Subject.fromMap(Map<String, dynamic> map, String id) {
    return Subject(id: id, name: map['name'] ?? '', description: map['description'] ?? '');
  }
}
