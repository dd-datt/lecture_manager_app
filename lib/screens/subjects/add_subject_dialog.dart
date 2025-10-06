import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/subject_provider.dart';

class AddSubjectDialog extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  AddSubjectDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Thêm môn học'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Tên môn'),
          ),
          TextField(
            controller: _descController,
            decoration: InputDecoration(labelText: 'Mô tả'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await Provider.of<SubjectProvider>(
              context,
              listen: false,
            ).addSubject(_nameController.text, _descController.text);
            Navigator.pop(context);
          },
          child: Text('Thêm'),
        ),
      ],
    );
  }
}
