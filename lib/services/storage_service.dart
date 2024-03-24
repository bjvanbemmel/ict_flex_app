// ignore_for_file: non_constant_identifier_names

import 'package:ict_flex_app/types/model.dart';
import 'package:sqflite/sqflite.dart';

class StorageService {
    static final StorageService _storageService = StorageService._internal();
    factory StorageService() => _storageService;
    StorageService._internal();

    final String DATABASE_PATH = 'flex.db';
    late final Database db;

    Future<void> connect() async {
        db = await openDatabase(
            DATABASE_PATH,
            onConfigure: (Database db) async => await db.execute('PRAGMA foreign_keys = ON'),
            onCreate: (db, _ ) async {
                await db.execute('''
                    CREATE TABLE articles (
                        id         TEXT      PRIMARY KEY  NOT NULL,
                        title      TEXT                   NOT NULL,
                        uri        TEXT                   NOT NULL,
                        content    TEXT                   NOT NULL,
                        created_at INTEGER                NOT NULL
                    );
                ''');

                await db.execute('''
                    CREATE TABLE reads(
                        id  TEXT  NOT NULL,
                        CONSTRAINT fk_articles
                        FOREIGN KEY (id)
                        REFERENCES articles (id)
                        ON DELETE CASCADE
                    );
                ''');
            },
            version: 1,
        );
    }

    void close() async => await db.close();

    Future<dynamic> query(String query) async =>
        await db.rawQuery(query);

    Future<List<Map<String, Object?>>> list(String table) async =>
        await db.query(table);

    Future<void> insert(Model model) async =>
        await db.insert(
            model.tableName(),
            model.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace,
        );

    // Not implemented
    Future<void> update() async => throw UnimplementedError();

    Future<void> delete(Model model) async =>
        await db.delete(
            model.tableName(),
            where: 'id = ?',
            whereArgs: [model.id()],
        );

    Future<void> clear(String table) async =>
        await db.delete(
            table,
        );
}
