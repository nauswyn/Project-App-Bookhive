import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../models/note.dart';
import '../../models/database_note.dart';

import '../../customcolor.dart';

class UpdateNote extends StatefulWidget {
  final Note mynote;
  const UpdateNote({Key? key, required this.mynote}) : super(key: key);

  @override
  State<UpdateNote> createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    databaseInstance.database();
    _titleController.text = widget.mynote.title!;
    _descController.text = widget.mynote.description!;

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
              mainAxisSize: MainAxisSize.min,
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
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      await databaseInstance.update(widget.mynote.id!, {
                        'title': _titleController.text,
                        'description': _descController.text,
                        'updated_at': DateTime.now().toString()
                      });
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(18),
                      child: Text(
                        'Update',
                        style: TextStyle(fontFamily: 'Lexend'),
                      ),
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
