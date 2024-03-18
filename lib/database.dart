import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase {
  // init database Function :::

  Future<Database> initDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path, 'dbstudent.db');
    return await openDatabase(databasePath);
  }

// copy to root Function

  Future<bool> copyPasteAssetFileToRoot() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "dbstudent.db");

    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data =
          await rootBundle.load(join('assets/database', 'dbstudent.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
      return true;
    }
    return false;
  }

  Future<List<Map<String, Object?>>> getDataFromStudent() async {
    Database db = await initDatabase();
    var data = await db.rawQuery("select * from student");
    return data;
  }

  Future<int> deleteStudent(int id) async {
    Database db = await initDatabase();
    var data = db.delete("student", where: "StudentID=?", whereArgs: [id]);
    return data;
  }

  Future<int> insertStudent({name}) async {
    Database db = await initDatabase();
    Map<String, Object> map = {};
    map['name'] = name;
    var data = db.insert("student", map);
    return data;
  }

  Future<int> updateStudent({name,id}) async {
    Database db = await initDatabase();
    Map<String, Object> map = {};
    map['name'] = name;
    var data = db.update("student", map,where:"StudentID=?",whereArgs: [id]);
    return data;
  }
}
