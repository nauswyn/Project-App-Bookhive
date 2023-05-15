import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';

import '../../customcolor.dart';
import '../../views/mainpage/homepage.dart';

import '../subpage/novel.dart';
import '../subpage/horror_book.dart';
import '../subpage/romance_book.dart';
import '../subpage/thriller_book.dart';
import '../subpage/adventure_book.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
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
                      return HomePage();
                    },
                  ),
                );
              },
            ),
            flexibleSpace: const FlexibleSpaceBar(
              title: Text(
                'Categories',
                style: TextStyle(
                    fontFamily: 'Lexend', fontSize: 20, color: Colors.black),
              ),
              centerTitle: true,
            ),
          ),

          // sliver items
          SliverGrid.builder(
            itemCount: categoriesName.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, childAspectRatio: 2 / 1),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (index == 0){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RomanceBook()));
                  } else if (index == 1){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AdventureBook()));
                  } else if (index == 2){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NovelBook()));
                  } else if (index == 3){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ThrillerBook()));
                  } else {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HorrorBook()));
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(categoriesImage[index])),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 5,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              stops: const [
                                0.1,
                                0.9
                              ],
                              colors: [
                                Colors.black.withOpacity(.8),
                                Colors.black.withOpacity(.1),
                              ]),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(categoriesName[index],
                                style: const TextStyle(
                                    fontFamily: 'Lexend',
                                    fontSize: 17,
                                    color: Colors.white))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

List categoriesName = [
  "Romance",
  "Adventure",
  "Novel",
  "Thriller",
  "Horror",
];

List categoriesImage = [
  "https://images.unsplash.com/photo-1524194838522-6264794f485d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
  "https://images.unsplash.com/photo-1542359649-31e03cd4d909?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80",
  "https://images.unsplash.com/photo-1560942485-b2a11cc13456?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=436&q=80",
  "https://images.unsplash.com/photo-1523712900580-a5cc2e0112ed?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
  "https://images.unsplash.com/photo-1678526773417-3e08a00d745f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
];
