import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/subject_provider.dart';
import '../../models/subject_model.dart';

class EditSubjectDialog extends StatefulWidget {
  final Subject subject;
  const EditSubjectDialog({super.key, required this.subject});

  @override
  State<EditSubjectDialog> createState() => _EditSubjectDialogState();
}

class _EditSubjectDialogState extends State<EditSubjectDialog> {
  late TextEditingController _nameController;
  late TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.subject.name);
    _descController = TextEditingController(text: widget.subject.description);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Sửa môn học'),
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
            await Provider.of<SubjectProvider>(context, listen: false).updateSubject(
              Subject(id: widget.subject.id, name: _nameController.text, description: _descController.text),
            );
            Navigator.pop(context);
          },
          child: Text('Lưu'),
        ),
      ],
    );
  }
}
