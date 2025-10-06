import 'package:flutter/material.dart';
import '../models/lecture_model.dart';
import '../services/firestore_service.dart';

class LectureProvider extends ChangeNotifier {
  final FirestoreService _service = FirestoreService();
  List<Lecture> _lectures = [];
  List<Lecture> _filteredLectures = [];

  List<Lecture> get lectures => _filteredLectures.isEmpty ? _lectures : _filteredLectures;

  void listenLectures({String? subjectId}) {
    _service.getLectures(subjectId: subjectId).listen((data) {
      _lectures = data;
      _filteredLectures = [];
      notifyListeners();
    });
  }

  void filterLectures(String keyword) {
    if (keyword.isEmpty) {
      _filteredLectures = [];
    } else {
      _filteredLectures = _lectures
          .where(
            (lecture) =>
                lecture.title.toLowerCase().contains(keyword.toLowerCase()) ||
                lecture.content.toLowerCase().contains(keyword.toLowerCase()),
          )
          .toList();
    }
    notifyListeners();
  }

  void filterByDate(DateTime date) {
    _filteredLectures = _lectures
        .where(
          (lecture) =>
              lecture.date.year == date.year && lecture.date.month == date.month && lecture.date.day == date.day,
        )
        .toList();
    notifyListeners();
  }

  Future<void> addLecture(Lecture lecture) async {
    await _service.addLecture(lecture);
  }

  Future<void> updateLecture(Lecture lecture) async {
    await _service.updateLecture(lecture);
  }

  Future<void> deleteLecture(String id) async {
    await _service.deleteLecture(id);
  }
}
