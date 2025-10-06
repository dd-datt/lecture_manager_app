import 'package:flutter/material.dart';
import '../models/subject_model.dart';
import '../services/firestore_service.dart';

class SubjectProvider extends ChangeNotifier {
  final FirestoreService _service = FirestoreService();
  List<Subject> _subjects = [];

  List<Subject> get subjects => _subjects;

  void listenSubjects() {
    _service.getSubjects().listen((data) {
      _subjects = data;
      notifyListeners();
    });
  }

  Future<void> addSubject(String name, String description) async {
    await _service.addSubject(Subject(id: '', name: name, description: description));
  }

  Future<void> updateSubject(Subject subject) async {
    await _service.updateSubject(subject);
  }

  Future<void> deleteSubject(String id) async {
    await _service.deleteSubject(id);
  }
}
