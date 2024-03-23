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
            onCreate: (db, _ ) async => await db.execute(
                '''CREATE TABLE articles (
                    id         INTEGER   PRIMARY KEY  AUTOINCREMENT,
                    hash       TEXT      UNIQUE       NOT NULL,
                    title      TEXT                   NOT NULL,
                    uri        TEXT                   NOT NULL,
                    content    TEXT                   NOT NULL,
                    created_at INTEGER                NOT NULL
                )'''
            ),
            version: 1,
        );
    }

    void close() async => await db.close();

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

    Future<void> delete(String table, String query, List<Object> args) async =>
        await db.delete(
            table,
            where: query,
            whereArgs: args,
        );

    Future<void> clear(String table) async =>
        await db.delete(
            table,
        );
}
