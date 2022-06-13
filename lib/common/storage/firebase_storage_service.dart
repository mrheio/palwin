import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'storage_service.dart';

class FirebaseStorageService implements StorageService {
  final Reference _rootRef;

  FirebaseStorageService(FirebaseStorage _storage, [String? path])
      : _rootRef = _storage.ref(path);

  @override
  Future<File?> getFile(String path) async {
    final fileRef = _rootRef.child(path);
    final data = await fileRef.getData();
    if (data != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final file = File('${appDir.path}/$path');
      if (!(await file.exists())) {
        await file.create();
        await file.writeAsBytes(data);
      }

      return file;
    }
    return null;
  }

  @override
  Future<void> saveFile(File file, [String? path]) async {
    final filePath = path ?? basename(file.path);
    final fileRef = _rootRef.child(filePath);
    await fileRef.putFile(file);
  }

  @override
  Future<void> deleteFile(String path) async {
    final fileRef = _rootRef.child(path);
    await fileRef.delete();
  }
}
