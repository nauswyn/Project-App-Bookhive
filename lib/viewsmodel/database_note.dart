import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/note.dart';

class DatabaseInstance {
  final String databaseName = "note.db";
  final int databaseVersion = 2;

  // Atribut di Model Transaksi
  final String namaTabel = 'note';
  final String id = 'id';
  final String title = 'title';
  final String description = 'description';
  final String createdAt = 'created_at';
  final String updatedAt = 'updated_at';

  Database? _database;
  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory databaseDirectory = await getApplicationDocumentsDirectory();
    String path = join(databaseDirectory.path, databaseName);
    print('database init');
    return openDatabase(path, version: databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE ${namaTabel} ($id INTEGER PRIMARY KEY, $title TEXT NULL, $description TEXT NULL, $createdAt TEXT NULL, $updatedAt TEXT NULL)');
  }

  Future<List<Note>> getAll() async {
    final data = await _database!.query(namaTabel);
    List<Note> result =
        data.map((e) => Note.fromJson(e)).toList();
    return result;
  }

  Future<int> insert(Map<String, dynamic> row) async {
    final query = await _database!.insert(namaTabel, row);
    return query;
  }

  Future<int> hapus(idNote) async {
    final query = await _database!
        .delete(namaTabel, where: '$id = ?', whereArgs: [idNote]);

    return query;
  }

  Future<int> update(int idNote, Map<String, dynamic> row) async {
    final query = await _database!
        .update(namaTabel, row, where: '$id = ?', whereArgs: [idNote]);
    return query;
  }
}