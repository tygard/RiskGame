import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
 return directory.path;
}


Future<File> _localFile(String name) async {
  final path = await _localPath;
  return File('$path/$name');
}


Future<File> writeContentToFileSystem(String name, String data) async {
  final file = await _localFile(name);
  return file.writeAsString(data);
}

Future<String> readContentFromFileSystem(String name) async {
    final file = await _localFile(name);
    String contents = await file.readAsString();
    return contents;
}

void deleteFile(String name) async {
    final file = await _localFile(name);
    file.delete();
}