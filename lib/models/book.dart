class BookData {
  final String id;
  final String title;
  final List<String> author;
  final String image;
  final String publisher;
  final String publishedDate;
  final String category;
  final String description;
  final int pageNum;
  final double rating;

  BookData(
      {required this.id,
      required this.title,
      required this.author,
      required this.image,
      required this.publisher,
      required this.publishedDate,
      required this.category,
      required this.description,
      required this.pageNum,
      required this.rating});

  factory BookData.fromJson(Map<String, dynamic> json, {required author, required title, required id}) {
    final volumeInfo = json['volumeInfo'];

    return BookData(
      id: json['id'],
      title: volumeInfo['title'] ?? '',
      author: List<String>.from(volumeInfo['authors'] ?? []),
      image: volumeInfo['imageLinks']?['thumbnail'] ?? '',
      publisher: volumeInfo['publisher'] ?? '',
      publishedDate: volumeInfo['publishedDate'] ?? '',
      category: volumeInfo['categories'] ?? [],
      description: volumeInfo['description'] ?? '',
      pageNum: volumeInfo['pageCount'] ?? 0,
      rating: volumeInfo['averageRating']?.toDouble() ?? 0.0,
    );
  }
}
