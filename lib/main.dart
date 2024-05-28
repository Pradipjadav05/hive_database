import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_database_demo/note%20app/notes_screen.dart';
import 'package:path_provider/path_provider.dart';

import 'home_screen.dart';
import 'note app/model/notes_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var directory = await getApplicationDocumentsDirectory();

  Hive.init(directory.path);

  // NotesModelAdapter is generated through 'flutter packages pub run build_runner build'
  Hive.registerAdapter(NotesModelAdapter());
  await Hive.openBox<NotesModel>('notes');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hive Database Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NotesScreen(),
    );
  }
}
