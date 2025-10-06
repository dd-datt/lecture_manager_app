import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/lecture_provider.dart';
import '../../models/lecture_model.dart';

class AddLectureDialog extends StatefulWidget {
  final String? subjectId;
  const AddLectureDialog({super.key, this.subjectId});

  @override
  State<AddLectureDialog> createState() => _AddLectureDialogState();
}

class _AddLectureDialogState extends State<AddLectureDialog> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Thêm bài giảng'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Tiêu đề'),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Nội dung'),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text('Ngày: ${_selectedDate.toLocal().toString().split(' ')[0]}'),
                TextButton(
                  child: Text('Chọn ngày'),
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) setState(() => _selectedDate = picked);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await Provider.of<LectureProvider>(context, listen: false).addLecture(
              Lecture(
                id: '',
                title: _titleController.text,
                content: _contentController.text,
                subjectId: widget.subjectId ?? '',
                date: _selectedDate,
              ),
            );
            Navigator.pop(context);
          },
          child: Text('Thêm'),
        ),
      ],
    );
  }
}
