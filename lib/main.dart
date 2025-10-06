import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lecture_manager_app/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'providers/subject_provider.dart';
import 'providers/lecture_provider.dart';
import 'screens/subjects/subjects_screen.dart'; // Thêm import màn hình chính

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SubjectProvider()..listenSubjects()),
        ChangeNotifierProvider(create: (_) => LectureProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lecture Manager App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}
