import 'dart:convert';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'categorypage.dart';
import 'bookdetail.dart';

import '../../customcolor.dart';

import '../../views/mainpage/mynote.dart';

//import '../../viewsmodel/getfcm.dart';
import '../../viewsmodel/localnotif.dart';
import '../../viewsmodel/searchbook.dart';
import '../../viewsmodel/theme_controller.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ThemeController _themeController = Get.find();
  // int _counter = 0; untuk mendapatkan fcm token

  //list books
  List<dynamic> _books = [];
  List<dynamic> _books1 = [];

  //method getbook
  Future<void> getBooks() async {
    final response = await http.get(
        Uri.parse('https://www.googleapis.com/books/v1/volumes?q=harrypotter'));
    final data = jsonDecode(response.body);
    setState(() {
      _books = data['items'];
    });
  }

  Future<void> getBooks1() async {
    final response = await http
        .get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=horror'));
    final data = jsonDecode(response.body);
    setState(() {
      _books1 = data['items'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBooks();
    getBooks1();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    LocalNotification.initialize();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      LocalNotification.showNotification(message);
    });

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 85, 50, 50),
        elevation: 0,
        leading: IconButton(
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          icon: Icon(Iconsax.menu_1, color: Colors.grey.shade500, size: 25),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(5),
          children: [
            Container(
              width: 70.0,
              height: 70.0,
              margin: const EdgeInsets.only(
                right: 190,
                top: 60.0,
              ),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                shape: BoxShape.circle,
              ),
              child: Image.network(
                'https://images.unsplash.com/photo-1677831362570-0d1beabae5ff?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                "Farah Safia",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Lexend'),
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                "200605110082",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Lexend'),
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Divider(
              color: Colors.grey.shade600,
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return HomePage();
                    },
                  ),
                );
              },
              leading: const Icon(Iconsax.home, size: 20),
              title: const Text('Dashboard',
                  style: TextStyle(fontFamily: 'Lexend')),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Iconsax.settings, size: 20),
              title: const Text('Change Theme',
                  style: TextStyle(fontFamily: 'Lexend')),
              trailing: Obx(() => Switch(
                  value: _themeController.themeMode.value == ThemeMode.dark,
                  onChanged: (value) {
                    final selectedMode =
                        value ? ThemeMode.dark : ThemeMode.light;
                    _themeController.setThemeMode(selectedMode);
                  },
                )),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return CategoryPage();
                    },
                  ),
                );
              },
              leading: Icon(Iconsax.category, size: 20),
              title: const Text('Category',
                  style: TextStyle(fontFamily: 'Lexend')),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return MyNote(title: 'Note');
                    },
                  ),
                );
              },
              leading: Icon(Iconsax.note_1, size: 20),
              title:
                  const Text('MyNote', style: TextStyle(fontFamily: 'Lexend')),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, bottom: 20.0, top: 10),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'best place to find',
                    style: TextStyle(fontSize: 22, fontFamily: 'Lexend'),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Awesome Books',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lexend'),
                  ),
                ],
              ),
            ),
            Container(
              height: 90,
              padding: const EdgeInsets.only(right: 20, left: 20, bottom: 45),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return BookList();
                      },
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[300]),
                  child: Row(
                    children: [
                      Icon(Iconsax.search_normal,
                          size: 15, color: Colors.grey.shade600),
                      SizedBox(width: 10),
                      Text(
                        "Search here",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontFamily: 'Lexend',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: KColor2,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )),
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Harry Potter Series',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Lexend'),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Container(
                          height: 200,
                          child: ListView.builder(
                            itemCount: _books.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BookDetailPage(
                                              bookId: _books[index]['id'])));
                                },
                                child: AspectRatio(
                                  aspectRatio: 2.5 / 3,
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(_books[index]
                                                  ['volumeInfo']['imageLinks']
                                              ['thumbnail'])),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: LinearGradient(
                                              begin: Alignment.bottomRight,
                                              stops: const [
                                                0.1,
                                                0.9
                                              ],
                                              colors: [
                                                Colors.black.withOpacity(.8),
                                                Colors.black.withOpacity(.1),
                                              ])),
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          _books[index]['volumeInfo']['title'],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Lexend',
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Text(
                          'Best Horror',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Lexend'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 200,
                          child: ListView.builder(
                            itemCount: _books1.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BookDetailPage(
                                              bookId: _books[index]['id'])));
                                },
                                child: AspectRatio(
                                  aspectRatio: 2.5 / 3,
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(_books1[index]
                                                  ['volumeInfo']['imageLinks']
                                              ['thumbnail'])),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: LinearGradient(
                                              begin: Alignment.bottomRight,
                                              stops: const [
                                                0.1,
                                                0.9
                                              ],
                                              colors: [
                                                Colors.black.withOpacity(.8),
                                                Colors.black.withOpacity(.1),
                                              ])),
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          _books1[index]['volumeInfo']['title'],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Lexend',
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      /*
      button untuk mendapatkan fcm token
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      */
    );
  }
}
