import 'package:appwrite/appwrite.dart';
import 'package:flutter/widgets.dart';

import 'gravity.dart';
import 'image_provider.dart';
import 'output_format.dart';

class AppwritePreviewImage extends StatelessWidget {
  const AppwritePreviewImage({
    super.key,
    required this.bucketId,
    required this.fileId,
    this.scale = 1.0,
    this.gravity,
    this.quality,
    this.previewWidth,
    this.previewHeight,
    this.borderWidth,
    this.borderColor,
    this.borderRadius,
    this.previewOpacity,
    this.rotation,
    this.background,
    this.output,
    this.storage,
    this.frameBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.width,
    this.height,
    this.color,
    this.opacity,
    this.colorBlendMode,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.centerSlice,
    this.matchTextDirection = false,
    this.gaplessPlayback = false,
    this.isAntiAlias = false,
    this.filterQuality = FilterQuality.low,
  });

  /// Appwrite storage bucketId
  final String bucketId;

  /// Appwrite storage fileId
  final String fileId;

  /// Image scale
  final double scale;

  /// Appwrite image clip gravity
  final Gravity? gravity;

  /// Appwrite preview quality 0-100
  final int? quality;

  /// Appwrite preview generation width, 0-4000
  final int? previewWidth;

  /// Appwrite preview generation height, 0-4000
  final int? previewHeight;

  /// Appwrite preview border thickness, 0-100
  final int? borderWidth;

  /// Appwrite preview border color
  final Color? borderColor;

  /// Appwrite preview border radius, 0-4000
  final int? borderRadius;

  /// Appwrite preview opacity, 0.0~1.0
  final double? previewOpacity;

  /// Appwrite preview rotation, -360~360
  final int? rotation;

  /// Appwrite preview background color
  final Color? background;

  /// Appwrite preview output format
  final OutputFormat? output;

  /// Appwrite storage client.
  /// This overrides the [AppwritePreviewImageProvider.setDefaultStorage] option.
  final Storage? storage;

  /// From [Image.frameBuilder]
  final ImageFrameBuilder? frameBuilder;

  /// From [Image.loadingBuilder]
  final ImageLoadingBuilder? loadingBuilder;

  /// From [Image.errorBuilder]
  final ImageErrorWidgetBuilder? errorBuilder;

  /// From [Image.width]
  final double? width;

  /// From [Image.height]
  final double? height;

  /// From [Image.color]
  final Color? color;

  /// From [Image.opacity]
  final Animation<double>? opacity;

  /// From [Image.colorBlendMode]
  final BlendMode? colorBlendMode;

  /// From [Image.fit]
  final BoxFit? fit;

  /// From [Image.alignment]
  final Alignment alignment;

  /// From [Image.repeat]
  final ImageRepeat repeat;

  /// From [Image.centerSlice]
  final Rect? centerSlice;

  /// From [Image.matchTextDirection]
  final bool matchTextDirection;

  /// From [Image.gaplessPlayback]
  final bool gaplessPlayback;

  /// From [Image.isAntiAlias]
  final bool isAntiAlias;

  /// From [Image.filterQuality]
  final FilterQuality filterQuality;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AppwritePreviewImageProvider(
        bucketId: bucketId,
        fileId: fileId,
        scale: scale,
        gravity: gravity,
        quality: quality,
        width: previewWidth,
        height: previewHeight,
        borderWidth: borderWidth,
        borderColor: borderColor,
        borderRadius: borderRadius,
        opacity: previewOpacity,
        rotation: rotation,
        background: background,
        output: output,
        storage: storage,
      ),
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }
}
