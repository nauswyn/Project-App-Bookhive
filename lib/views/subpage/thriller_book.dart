import 'dart:convert';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../customcolor.dart';
import '../../views/mainpage/bookdetail.dart';
import '../../views/mainpage/categorypage.dart';

class ThrillerBook extends StatefulWidget {
  const ThrillerBook({super.key});

  @override
  State<ThrillerBook> createState() => _ThrillerBookState();
}

class _ThrillerBookState extends State<ThrillerBook> {
  List<dynamic> _books = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBooksThr();
  }

  Future<void> getBooksThr() async {
    final response = await http.get(
        Uri.parse('https://www.googleapis.com/books/v1/volumes?q=thriller'));
    final data = jsonDecode(response.body);
    setState(() {
      _books = data['items'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // sliver app bar
          SliverAppBar(
            backgroundColor: KColor2,
            expandedHeight: 150,
            leading: IconButton(
              padding: const EdgeInsets.all(30.0),
              icon: const Icon(Iconsax.arrow_left),
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).pop(
                  MaterialPageRoute(
                    builder: (context) {
                      return CategoryPage();
                    },
                  ),
                );
              },
            ),
            flexibleSpace: const FlexibleSpaceBar(
              title: Text(
                'Adventure',
                style: TextStyle(
                    fontFamily: 'Lexend', fontSize: 20, color: Colors.black),
              ),
              centerTitle: true,
            ),
          ),

          // sliver items
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: _books.length,
              (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BookDetailPage(bookId: _books[index]['id'])));
                  },
                  child: Container(
                    height: 150,
                    child: Row(
                      children: [
                        Container(
                          width: 90,
                          margin: EdgeInsets.only(left: 15, top: 20),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(_books[index]['volumeInfo']
                                    ['imageLinks']['thumbnail'])),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _books[index]['volumeInfo']['title'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Lexend',
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 7),
                                Text(
                                  _books[index]['volumeInfo']['authors']
                                      ?.join(', '),
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 15,
                                    fontFamily: 'Lexend',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
