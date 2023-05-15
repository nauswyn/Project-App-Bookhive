class Note {
  int? id;
  String? title, description, createdAt, updatedAt;

  Note(
      {this.id,
      this.title,
      this.description,
      this.createdAt,
      this.updatedAt});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }
}
