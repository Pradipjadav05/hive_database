import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hive Database Demo"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        // Adjust alignment as needed
        children: [
          Expanded(
            child: FutureBuilder(
              future: Hive.openBox("person"),
              builder: (context, AsyncSnapshot<Box> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child:
                          CircularProgressIndicator()); // Center the loading indicator
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final personBox = snapshot.data;
                  final name = personBox!.get('name');
                  final age = personBox.get('age');

                  return ListTile(
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () async{
                            await personBox.put('name', 'PJ');
                            setState(() {
                            });
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () async{
                            await personBox.delete('name');
                            setState(() {
                            });
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                    title: Text("name : $name"),
                    subtitle: Text("name : $age"),
                  );
                }
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var box = await Hive.openBox('person');

          await box.put("name", "Pradip");
          await box.put("age", 21);
          await box.put("details", {"designation": "developer"});

          print("${box.get("name")}");
          print("${box.get("age")}");
          print("${box.get("details")}");
          print("${box.get("details")['designation']}");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
