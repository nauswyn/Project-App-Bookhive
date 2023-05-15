import 'dart:convert';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../customcolor.dart';
import '../../views/mainpage/categorypage.dart';

class BookDetailPage extends StatefulWidget {
  final String bookId;

  BookDetailPage({required this.bookId});

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  Map<String, dynamic>? _bookData;
  bool isFavorite = false;
  late String bookId;

  @override
  void initState() {
    super.initState();
    _fetchBookData();
  }

  Future<void> _fetchBookData() async {
    final response = await http.get(Uri.parse(
        'https://www.googleapis.com/books/v1/volumes/${widget.bookId}'));
    if (response.statusCode == 200) {
      setState(() {
        _bookData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load book data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          // IconButton(
          //   padding: const EdgeInsets.only(top: 20, right: 30),
          //   icon: Icon(
          //     _isFavorite ? Iconsax.heart5 : Iconsax.heart5,
          //     color: _isFavorite ? Colors.red : null,
          //   ),
          //   onPressed: _toggleFavorite,
          // ),
        ],
        leading: IconButton(
          padding: const EdgeInsets.only(top: 20, left: 30),
          icon: const Icon(Iconsax.arrow_left),
          color: Colors.white,
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
        backgroundColor: KprimaryColor,
        elevation: 0,
      ),
      body: _bookData == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Container(
                  height: 170,
                  decoration: const BoxDecoration(
                    color: KprimaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                        height: 220.0,
                        width: 160.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(_bookData!['volumeInfo']
                                ['imageLinks']['thumbnail']),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        child: Text(
                          _bookData!['volumeInfo']['title'] ?? '',
                          style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Lexend'),
                          textAlign: TextAlign.center,
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        _bookData!['volumeInfo']['authors'] != null
                            ? 'by ${_bookData!['volumeInfo']['authors'].join(', ')}'
                            : '',
                        style:
                            const TextStyle(fontSize: 15, fontFamily: 'Lexend'),
                      ),
                      const SizedBox(height: 18.0),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: const Text(
                                'Details',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(left: 25),
                            ),
                            const SizedBox(height: 8.0),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: const EdgeInsets.only(left: 25),
                                    child: const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Author',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Lexend',
                                          ),
                                        ),
                                        Text(
                                          'Publisher',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Lexend',
                                          ),
                                        ),
                                        Text(
                                          'Published Date',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Lexend',
                                          ),
                                        ),
                                        Text(
                                          'Rating',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Lexend',
                                          ),
                                        ),
                                        Text(
                                          'Page',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Lexend',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.only(left: 25),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _bookData!['volumeInfo']['authors']
                                                .join(', '),
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontSize: 14,
                                              fontFamily: 'Lexend',
                                            ),
                                          ),
                                          Text(
                                            _bookData!['volumeInfo']
                                                ['publisher'],
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontSize: 14,
                                              fontFamily: 'Lexend',
                                            ),
                                          ),
                                          Text(
                                            _bookData!['volumeInfo']
                                                ['publishedDate'],
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontSize: 14,
                                              fontFamily: 'Lexend',
                                            ),
                                          ),
                                          Text(
                                            _bookData!['volumeInfo']
                                                        ['averageRating']
                                                    ?.toString() ??
                                                'N/A',
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontSize: 14,
                                              fontFamily: 'Lexend',
                                            ),
                                          ),
                                          Text(
                                            _bookData!['volumeInfo']
                                                        ['pageCount']
                                                    ?.toString() ??
                                                'N/A',
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontSize: 14,
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
                          ],
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: const Text(
                                'Description',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(left: 25),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      _bookData!['volumeInfo']['description']
                                              ?.substring(0, 400) ??
                                          '',
                                      style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 15,
                                          fontFamily: 'Lexend'),
                                      textAlign: TextAlign.justify,
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 25),
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
              ],
            ),
    );
  }
}
