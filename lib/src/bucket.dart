import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/enums.dart';
import 'package:appwrite/models.dart' as models;

class Bucket {
  Bucket(this.storage, this.id);

  final Storage storage;
  final String id;

  Future<models.FileList> listFiles({List<String>? queries, String? search}) {
    return storage.listFiles(bucketId: id, queries: queries, search: search);
  }

  Future<models.File> createFile({
    required String fileId,
    required InputFile file,
    List<String>? permissions,
    Function(UploadProgress)? onProgress,
  }) {
    return storage.createFile(
      bucketId: id,
      fileId: fileId,
      file: file,
      permissions: permissions,
      onProgress: onProgress,
    );
  }

  Future<models.File> getFile(String fileId) {
    return storage.getFile(bucketId: id, fileId: fileId);
  }

  Future<models.File> updateFile(
    String fileId, {
    String? name,
    List<String>? permissions,
  }) {
    return storage.updateFile(
      bucketId: id,
      fileId: fileId,
      permissions: permissions,
    );
  }

  Future deleteFile(String fileId) {
    return storage.deleteFile(bucketId: id, fileId: fileId);
  }

  Future<Uint8List> getFileDownload(String fileId) {
    return storage.getFileDownload(bucketId: id, fileId: fileId);
  }

  Future<Uint8List> getFilePreview(
    String fileId, {
    int? width,
    int? height,
    ImageGravity? gravity,
    int? quality,
    int? borderWidth,
    String? borderColor,
    int? borderRadius,
    double? opacity,
    int? rotation,
    String? background,
    ImageFormat? output,
  }) {
    return storage.getFilePreview(
      bucketId: id,
      fileId: fileId,
      width: width,
      height: height,
      gravity: gravity,
      quality: quality,
      borderWidth: borderWidth,
      borderColor: borderColor,
      borderRadius: borderRadius,
      opacity: opacity,
      rotation: rotation,
      background: background,
      output: output,
    );
  }

  Future<Uint8List> getFileView(String fileId) {
    return storage.getFileView(bucketId: id, fileId: fileId);
  }
}

extension BucketFromStorage on Storage {
  Bucket bucket(String id) => Bucket(this, id);
}
