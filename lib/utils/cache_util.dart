import 'dart:io';

import 'package:path_provider/path_provider.dart';

class CacheUtil {
  /// 加载缓存
  static Future<String> loadCache() async {
    Directory tempDir = await getTemporaryDirectory();
    double value = await _getTotalSizeOfFilesInDir(tempDir);
    return _formatSize(value);
  }

  /// 循环计算文件的大小（递归）
  static Future<double> _getTotalSizeOfFilesInDir(
      final FileSystemEntity file) async {
    if (file is File) {
      int length = await file.length();
      return double.parse(length.toString());
    }
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      double total = 0;
      if (children != null) {
        for (final FileSystemEntity child in children)
          total += await _getTotalSizeOfFilesInDir(child);
        return total;
      }
    }
    return 0;
  }

  /// 格式化文件大小
  static String _formatSize(double value) {
    if (value == null) return '0 B';
    List<String> unitArr = List()..add('B')..add('KB')..add('MB')..add('GB');
    int index = 0;
    while (value > 1024) {
      index++;
      value /= 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }

  /// 删除缓存
  static Future<bool> clearCache() async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      await _delDir(tempDir);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  /// 递归的方式删除文件
  static Future<Null> _delDir(FileSystemEntity file) async {
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      for (final FileSystemEntity child in children) await _delDir(child);
    }
    await file.delete();
  }
}
