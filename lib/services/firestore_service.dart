import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/subject_model.dart';

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
}
