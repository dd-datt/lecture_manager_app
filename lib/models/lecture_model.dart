import 'package:cloud_firestore/cloud_firestore.dart';

class Lecture {
  final String id;
  final String title;
  final String content;
  final String subjectId;
  final DateTime date; // Ngày giờ của bài giảng

  Lecture({required this.id, required this.title, required this.content, required this.subjectId, required this.date});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'subjectId': subjectId,
      'date': date.toIso8601String(), // Lưu dạng String
    };
  }

  factory Lecture.fromMap(Map<String, dynamic> map, String id) {
    final dateRaw = map['date'];
    DateTime date;
    if (dateRaw is Timestamp) {
      date = dateRaw.toDate();
    } else if (dateRaw is String) {
      date = DateTime.parse(dateRaw);
    } else {
      date = DateTime.now();
    }
    return Lecture(
      id: id,
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      subjectId: map['subjectId'] ?? '',
      date: date,
    );
  }
}
