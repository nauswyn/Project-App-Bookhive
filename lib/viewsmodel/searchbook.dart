import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';

import 'bookprovider.dart';
import '../../views/mainpage/homepage.dart';

class BookList extends StatefulWidget {
  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  List<dynamic> _books = [];
  BookApiProvider _bookApiProvider = BookApiProvider();
  TextEditingController _searchController = TextEditingController();

  //get book from api
  void _fetchBooks(String query) async {
    try {
      final books = await _bookApiProvider.getBooks(query);
      setState(() {
        _books = books;
      });
    } catch (e) {
      // Handle error
      print(e.toString());
    }
  }

  //search book in api
  void _searchBooks(String query) async {
    try {
      final books = await _bookApiProvider.searchBooks(query);
      setState(() {
        _books = books;
      });
    } catch (e) {
      // Handle error
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 30),
          icon: const Icon(Iconsax.arrow_left),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop(
              MaterialPageRoute(
                builder: (context) {
                  return HomePage();
                },
              ),
            );
          },
        ),
        backgroundColor: Colors.white,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            hintText: 'Search book here',
            hintStyle: const TextStyle(color: Colors.black),
            suffixIcon: IconButton(
              icon: const Icon(Iconsax.search_normal, size: 15, color: Colors.black),
              onPressed: () {
                _searchBooks(_searchController.text);
              },
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _books.length,
              itemBuilder: (context, index) {
                final book = _books[index];
                return Container(
                  height: 150,
                  child: Row(
                    children: [
                      Container(
                        width: 90,
                        margin: const EdgeInsets.only(left: 15, top: 20),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(book['volumeInfo']
                                  ['imageLinks']['thumbnail'])),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                book['volumeInfo']['title'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Lexend',
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 7),
                              Text(
                                book['volumeInfo']['authors']?.join(', '),
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
