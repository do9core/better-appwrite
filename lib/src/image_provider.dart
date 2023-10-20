// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;

import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'gravity.dart';
import 'output_format.dart';

class AppwritePreviewImageProvider
    extends ImageProvider<AppwritePreviewImageProvider> {
  AppwritePreviewImageProvider({
    required this.bucketId,
    required this.fileId,
    this.scale = 1.0,
    this.gravity,
    this.quality,
    this.width,
    this.height,
    this.borderWidth,
    this.borderColor,
    this.borderRadius,
    this.opacity,
    this.rotation,
    this.background,
    this.output,
    this.storage,
  });

  static Storage? _defaultStorage;
  static setDefaultStorage(Storage storage) {
    if (_defaultStorage != null) {
      log(
        'defaultStorage is not null and is updating to a new one '
        'with client config: ${storage.client.config}',
        // [Level.WARN](https://github.com/dart-lang/logging/blob/642ed2124f7ef7abc819a0e22ae0c7afdb5398d3/lib/src/level.dart#L48)
        level: 900,
        name: 'AppwriteImageProvider',
      );
    }
    _defaultStorage = storage;
  }

  static String? _colorToString(Color? color) {
    if (color == null) return null;
    final r = color.red.toRadixString(16);
    final g = color.green.toRadixString(16);
    final b = color.blue.toRadixString(16);
    final a = color.alpha.toRadixString(16);
    return '$r$g$b$a';
  }

  /// Appwrite storage client.
  /// This overrides the [AppwritePreviewImageProvider.setDefaultStorage] option.
  final Storage? storage;

  /// Appwrite storage bucketId
  final String bucketId;

  /// Appwrite storage fileId
  final String fileId;

  /// Appwrite image clip gravity
  final Gravity? gravity;

  /// Appwrite preview quality 0-100
  final int? quality;

  /// Appwrite preview generation width, 0-4000
  final int? width;

  /// Appwrite preview generation height, 0-4000
  final int? height;

  /// Appwrite preview border thickness, 0-100
  final int? borderWidth;

  /// Appwrite preview border color
  final Color? borderColor;

  /// Appwrite preview border radius, 0-4000
  final int? borderRadius;

  /// Appwrite preview opacity, 0.0~1.0
  final double? opacity;

  /// Appwrite preview rotation, -360~360
  final int? rotation;

  /// Appwrite preview background color
  final Color? background;

  /// Appwrite preview output format
  final OutputFormat? output;

  /// Image scale
  final double scale;

  @override
  Future<AppwritePreviewImageProvider> obtainKey(
      ImageConfiguration configuration) {
    return SynchronousFuture(this);
  }

  @override
  ImageStreamCompleter loadImage(
    AppwritePreviewImageProvider key,
    ImageDecoderCallback decode,
  ) {
    // XXX: currently appwrite sdk doesn't support the download progress
    final chunkEvents = StreamController<ImageChunkEvent>();
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key, chunkEvents, decode),
      scale: key.scale,
      chunkEvents: chunkEvents.stream,
      debugLabel: '${key.bucketId}/${key.fileId}',
      informationCollector: () sync* {
        yield DiagnosticsProperty('Image provider', this);
        yield DiagnosticsProperty('Image key', key);
      },
    );
  }

  Future<ui.Codec> _loadAsync(
    AppwritePreviewImageProvider key,
    StreamController<ImageChunkEvent> chunkEvents,
    ImageDecoderCallback decode,
  ) async {
    try {
      assert(key == this);
      final storage = this.storage ?? _defaultStorage;
      assert(
        storage != null,
        'You must set a storage provider with instance parameter "storage" '
        'or class function "AppwriteImageProvider.setDefaultStorage"',
      );
      chunkEvents.add(const ImageChunkEvent(
        cumulativeBytesLoaded: 0,
        expectedTotalBytes: null,
      ));
      final bytes = await storage!.getFilePreview(
        bucketId: key.bucketId,
        fileId: key.fileId,
        width: width,
        height: height,
        gravity: gravity?.raw,
        quality: quality,
        borderWidth: borderWidth,
        borderColor: _colorToString(borderColor),
        borderRadius: borderRadius,
        opacity: opacity,
        rotation: rotation,
        background: _colorToString(background),
        output: output?.raw,
      );
      chunkEvents.add(ImageChunkEvent(
        cumulativeBytesLoaded: bytes.length,
        expectedTotalBytes: bytes.length,
      ));
      final buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
      return decode(buffer);
    } catch (e) {
      scheduleMicrotask(() {
        PaintingBinding.instance.imageCache.evict(key);
      });
      rethrow;
    } finally {
      chunkEvents.close();
    }
  }

  @override
  bool operator ==(covariant AppwritePreviewImageProvider other) {
    if (identical(this, other)) return true;
    return other.storage == storage &&
        other.bucketId == bucketId &&
        other.fileId == fileId &&
        other.gravity == gravity &&
        other.quality == quality &&
        other.width == width &&
        other.height == height &&
        other.borderWidth == borderWidth &&
        other.borderColor == borderColor &&
        other.borderRadius == borderRadius &&
        other.opacity == opacity &&
        other.rotation == rotation &&
        other.background == background &&
        other.output == output;
  }

  @override
  int get hashCode {
    return Object.hash(
      bucketId,
      fileId,
      gravity,
      quality,
      width,
      height,
      borderWidth,
      borderColor,
      borderRadius,
      opacity,
      rotation,
      background,
      output,
    );
  }

  @override
  String toString() =>
      '${objectRuntimeType(this, 'AppwritePreviewImage')}("$bucketId/$fileId")';
}
