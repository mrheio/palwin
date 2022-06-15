import 'dart:io';

abstract class StorageService {
  Future<File?> getFile(String path);
  Future<String> getDownloadURL(String path);
  Future<void> saveFile(File file, [String? path]);
  Future<void> deleteFile(String path);
}
