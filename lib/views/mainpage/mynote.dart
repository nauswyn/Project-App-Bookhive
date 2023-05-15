import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../customcolor.dart';

import '../subpage/createnote.dart';
import '../subpage/updatenote.dart';

import '../../models/note.dart';
import '../../viewsmodel/database_note.dart';
import '../../viewsmodel/notifi_service.dart';

class MyNote extends StatefulWidget {
  const MyNote({super.key, required this.title});

  final String title;

  @override
  State<MyNote> createState() => _MyNoteState();
}

class _MyNoteState extends State<MyNote> {
  DatabaseInstance? databaseInstance;

  Future _refreshNote() async {
    setState(() {});
  }

  @override
  void initState() {
    databaseInstance = DatabaseInstance();
    initDatabase();
    super.initState();
  }

  Future initDatabase() async {
    await databaseInstance!.database();
    setState(() {});
  }

  showAlertDialog(BuildContext context, int idNote) {
    Widget okButton = OutlinedButton(
      child: Text("Sure"),
      onPressed: () {
        //delete disini
        databaseInstance!.hapus(idNote);
        Navigator.of(context, rootNavigator: true).pop();
        setState(() {});
        NotificationService().showNotification(
                        title: 'Notification!', body: 'Note Deleted!');
      },
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text(
        'Warning!',
        style: TextStyle(fontFamily: 'Lexend'),
      ),
      content: Text(
        'Are you sure want to delete it?',
        style: TextStyle(fontFamily: 'Lexend'),
      ),
      actions: [okButton],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
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
      body: RefreshIndicator(
        onRefresh: _refreshNote,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20),
              FutureBuilder<List<Note>>(
                  future: databaseInstance!.getAll(),
                  builder: (context, snapshot) {
                    print('hasil: ' + snapshot.data.toString());
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    } else {
                      if (snapshot.hasData) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(snapshot.data![index].title!,
                                    style: TextStyle(fontFamily: 'Lexend')),
                                subtitle: Text(
                                    snapshot.data![index].description!,
                                    style: TextStyle(fontFamily: 'Lexend')),
                                trailing: Wrap(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateNote(
                                                          mynote: snapshot
                                                              .data![index])))
                                              .then((value) {
                                            setState(() {});
                                          });
                                        },
                                        icon: Icon(Iconsax.edit_2)),
                                    SizedBox(width: 10),
                                    IconButton(
                                      onPressed: () {
                                        showAlertDialog(
                                            context, snapshot.data![index].id!);
                                      },
                                      icon: Icon(Iconsax.trash,
                                          color: Colors.red),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Tidak ada data',
                            style:
                                TextStyle(fontFamily: 'Lexend', fontSize: 20),
                          ),
                        );
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: KprimaryColor,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CreateNote(title: '')))
              .then((value) {
            setState(() {});
          });
        },
        child: Icon(Iconsax.add),
      ),
    );
  }
}
