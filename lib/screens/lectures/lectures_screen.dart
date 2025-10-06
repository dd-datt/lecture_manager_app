import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/lecture_provider.dart';
import '../../models/lecture_model.dart';
import 'add_lecture_dialog.dart';
import 'edit_lecture_dialog.dart';

class LecturesScreen extends StatelessWidget {
  final String? subjectId;
  const LecturesScreen({super.key, this.subjectId});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LectureProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Danh sách bài giảng')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              decoration: InputDecoration(labelText: 'Tìm kiếm bài giảng', prefixIcon: Icon(Icons.search)),
              onChanged: (value) {
                provider.filterLectures(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: provider.lectures.length,
              itemBuilder: (context, index) {
                final lecture = provider.lectures[index];
                return ListTile(
                  title: Text(lecture.title),
                  subtitle: Text('${lecture.content}\nNgày học: ${lecture.date.toLocal().toString().split(' ')[0]}'),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AddLectureDialog(subjectId: subjectId),
          );
        },
      ),
    );
  }
}
