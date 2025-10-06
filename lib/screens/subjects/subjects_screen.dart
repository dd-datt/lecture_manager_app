import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/subject_provider.dart';
import '../../models/subject_model.dart';
import 'add_subject_dialog.dart';
import 'edit_subject_dialog.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SubjectProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Danh sách môn học')),
      body: ListView.builder(
        itemCount: provider.subjects.length,
        itemBuilder: (context, index) {
          final subject = provider.subjects[index];
          return ListTile(
            title: Text(subject.name),
            subtitle: Text(subject.description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Hiển thị dialog sửa môn học
                    showDialog(
                      context: context,
                      builder: (_) => EditSubjectDialog(subject: subject),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    provider.deleteSubject(subject.id);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Hiển thị dialog thêm môn học
          showDialog(context: context, builder: (_) => AddSubjectDialog());
        },
      ),
    );
  }
}
