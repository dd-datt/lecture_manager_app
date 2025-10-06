import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/subject_model.dart';
import 'package:lecture_manager_app/models/lecture_model.dart';

class FirestoreService {
  final _subjects = FirebaseFirestore.instance.collection('subjects');

  Future<void> addSubject(Subject subject) async {
    await _subjects.add(subject.toMap());
  }

  Future<void> updateSubject(Subject subject) async {
    await _subjects.doc(subject.id).update(subject.toMap());
  }

  Future<void> deleteSubject(String id) async {
    await _subjects.doc(id).delete();
  }

  Stream<List<Subject>> getSubjects() {
    return _subjects.snapshots().map(
      (snapshot) => snapshot.docs.map((doc) => Subject.fromMap(doc.data(), doc.id)).toList(),
    );
  }

  final _lectures = FirebaseFirestore.instance.collection('lectures');

  Future<void> addLecture(Lecture lecture) async {
    await _lectures.add(lecture.toMap());
  }

  Future<void> updateLecture(Lecture lecture) async {
    await _lectures.doc(lecture.id).update(lecture.toMap());
  }

  Future<void> deleteLecture(String id) async {
    await _lectures.doc(id).delete();
  }

  Stream<List<Lecture>> getLectures({String? subjectId}) {
    Query query = _lectures;
    if (subjectId != null) {
      query = query.where('subjectId', isEqualTo: subjectId);
    }
    return query.snapshots().map(
      (snapshot) => snapshot.docs.map((doc) => Lecture.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList(),
    );
  }
}
