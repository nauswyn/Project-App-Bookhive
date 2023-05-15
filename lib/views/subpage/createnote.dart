import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../customcolor.dart';
import '../../viewsmodel/database_note.dart';
import '../../viewsmodel/notifi_service.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key, required this.title});

  final String title;

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    databaseInstance.database();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KprimaryColor,
        title: const Text(
          'My Note',
          style: TextStyle(fontFamily: 'Lexend'),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 30,
              left: 15,
              right: 15,
              bottom: MediaQuery.of(context).viewInsets.bottom + 50,
            ),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Title',
                    hintStyle: TextStyle(fontFamily: 'Lexend'),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  maxLines: 20,
                  controller: _descController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Description',
                    hintStyle: TextStyle(fontFamily: 'Lexend'),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: KprimaryColor,
                  ),
                  onPressed: () async {
                    int idInsert = await databaseInstance.insert({
                      'title': _titleController.text,
                      'description': _descController.text,
                      'created_at': DateTime.now().toString(),
                      'updated_at': DateTime.now().toString(),
                    });
                    print("sudah masuk : " + idInsert.toString());
                    NotificationService().showNotification(
                        title: 'Notification!', body: 'Note Saved Successfully!');
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(18),
                    child: Text(
                      'Save',
                      style: TextStyle(fontFamily: 'Lexend'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
