import 'package:hive/hive.dart';
import 'package:hive_database_demo/note%20app/model/notes_model.dart';

class Boxes {
  static Box<NotesModel> getData() => Hive.box<NotesModel>('notes');
}
