import 'package:flutter/material.dart';
import 'lesson.dart';
import 'lesson_service.dart';

class AddLesson extends StatefulWidget {
  final String topicId;

  const AddLesson({super.key, required this.topicId});

  @override
  _AddLessonScreenState createState() => _AddLessonScreenState();
}

class _AddLessonScreenState extends State<AddLesson> {
  final _formKey = GlobalKey<FormState>();
  final _questionNameController = TextEditingController();
  final LessonService _lessonService = LessonService();

  @override
  void dispose() {
    _questionNameController.dispose();
    super.dispose();
  }

  Future<void> _addLesson() async {
    if (_formKey.currentState!.validate()) {
      final newLesson = Lesson(
        documentId: '',
        topicId: widget.topicId,
        questionName: _questionNameController.text,
      );

      final createdLesson = await _lessonService.createLesson(newLesson);
      if (createdLesson != null) {
        Navigator.of(context).pop(createdLesson);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error creating lesson')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Lesson'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _questionNameController,
                decoration: const InputDecoration(labelText: 'Lesson Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a question name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addLesson,
                child: const Text('Add Lesson'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}