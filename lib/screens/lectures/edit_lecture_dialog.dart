import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/lecture_provider.dart';
import '../../models/lecture_model.dart';

class EditLectureDialog extends StatefulWidget {
  final Lecture lecture;
  const EditLectureDialog({super.key, required this.lecture});

  @override
  State<EditLectureDialog> createState() => _EditLectureDialogState();
}

class _EditLectureDialogState extends State<EditLectureDialog> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.lecture.title);
    _contentController = TextEditingController(text: widget.lecture.content);
    _selectedDate = widget.lecture.date;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Sửa bài giảng'),
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
            await Provider.of<LectureProvider>(context, listen: false).updateLecture(
              Lecture(
                id: widget.lecture.id,
                title: _titleController.text,
                content: _contentController.text,
                subjectId: widget.lecture.subjectId,
                date: _selectedDate,
              ),
            );
            Navigator.pop(context);
          },
          child: Text('Lưu'),
        ),
      ],
    );
  }
}
