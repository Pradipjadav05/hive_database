import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_database_demo/note%20app/model/notes_model.dart';
import 'package:hive_flutter/adapters.dart';

import 'boxes/boxes.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hive Database Demo"),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<NotesModel>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (context, box, child) {
          var data = box.values.toList().cast<NotesModel>();
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(data[index].name.toString()),
                          const Spacer(),
                          IconButton(
                            onPressed: () async {
                              await delete(data[index]);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              await showEditDialog(
                                  data[index],
                                  data[index].name.toString(),
                                  data[index].description.toString());
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.green,
                            ),
                          )
                        ],
                      ),
                      Text(data[index].description.toString()),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showInsertDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> delete(NotesModel notesModel) async {
    await notesModel.delete();
  }

  Future<void> showInsertDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Notes"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: "Enter Title",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: "Enter Description",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                clearController();
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                final data = NotesModel(
                    name: titleController.text,
                    description: descriptionController.text);

                final box = Boxes.getData();

                await box.add(data);

                //not need because of listenable() - flutter_hive package
                // await data.save();

                clearController();

                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  Future<void> showEditDialog(
      NotesModel notesModel, String title, String description) {
    titleController.text = title;
    descriptionController.text = description;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Notes"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: "Enter Title",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: "Enter Description",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                clearController();
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                notesModel.name = titleController.text.toString();
                notesModel.description = descriptionController.text.toString();

                await notesModel.save();

                clearController();

                Navigator.pop(context);
              },
              child: const Text("Edit"),
            ),
          ],
        );
      },
    );
  }

  clearController(){
    titleController.clear();
    descriptionController.clear();
  }
}
