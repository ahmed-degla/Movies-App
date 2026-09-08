import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:movies/core/extensions/num_extension.dart';
import 'package:movies/core/theme/theme_extension.dart';

enum AppNetworkImageShape { rectangle, roundedRectangle, circle }

class AppNetWorkImage extends StatelessWidget {
  const AppNetWorkImage({
    required this.imageUrl,
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.color,
    this.colorBlendMode,
    this.filterQuality = FilterQuality.medium,
    this.cacheKey,
    this.httpHeaders,
    this.memCacheWidth,
    this.memCacheHeight,
    this.maxWidthDiskCache,
    this.maxHeightDiskCache,
    this.fadeInDuration = const Duration(milliseconds: 300),
    this.fadeOutDuration = const Duration(milliseconds: 100),
    this.borderRadius,
    this.border,
    this.backgroundColor,
    this.shape = AppNetworkImageShape.rectangle,
    this.placeholder,
    this.errorWidget,
    this.imageBuilder,
    this.progressIndicatorBuilder,
    this.useOldImageOnUrlChange = false,
    this.placeholderFadeInDuration,
    this.errorListener,
    this.imageRenderMethodForWeb,
  });

  final String imageUrl;

  final double? width;
  final double? height;

  final BoxFit fit;
  final Alignment alignment;
  final ImageRepeat repeat;

  final Color? color;
  final BlendMode? colorBlendMode;
  final FilterQuality filterQuality;

  final String? cacheKey;
  final Map<String, String>? httpHeaders;

  final int? memCacheWidth;
  final int? memCacheHeight;

  final int? maxWidthDiskCache;
  final int? maxHeightDiskCache;

  final Duration fadeInDuration;
  final Duration fadeOutDuration;

  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final Color? backgroundColor;

  final AppNetworkImageShape shape;

  final Widget Function(BuildContext, String)? placeholder;
  final Widget? errorWidget;

  final ImageWidgetBuilder? imageBuilder;
  final ProgressIndicatorBuilder? progressIndicatorBuilder;

  final bool useOldImageOnUrlChange;

  final Duration? placeholderFadeInDuration;

  final void Function(Object)? errorListener;

  final ImageRenderMethodForWeb? imageRenderMethodForWeb;

  @override
  Widget build(BuildContext context) {
    final image = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      color: color,
      colorBlendMode: colorBlendMode,
      filterQuality: filterQuality,
      cacheKey: cacheKey,
      httpHeaders: httpHeaders,
      memCacheWidth:
          memCacheWidth ??
          (width != null && width!.isFinite ? width!.dprInt : null),
      memCacheHeight:
          memCacheHeight ??
          (height != null && height!.isFinite ? height!.dprInt : null),
      maxWidthDiskCache: maxWidthDiskCache,
      maxHeightDiskCache: maxHeightDiskCache,
      fadeInDuration: fadeInDuration,
      fadeOutDuration: fadeOutDuration,
      useOldImageOnUrlChange: useOldImageOnUrlChange,
      placeholderFadeInDuration: placeholderFadeInDuration,

      placeholder: placeholder ?? _defaultPlaceholder,

      errorBuilder: errorWidget != null
          ? (context, stackTrace, anotherStackTrace) => errorWidget!
          : _defaultErrorWidget,

      progressIndicatorBuilder: progressIndicatorBuilder,
      imageBuilder: imageBuilder,
      errorListener: errorListener,
    );

    return _buildShape(image);
  }

  Widget _defaultPlaceholder(BuildContext context, String url) =>
      const _ImageShimmer();

  Widget _defaultErrorWidget(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    return const _ImageError();
  }

  Widget _buildShape(Widget image) {
    switch (shape) {
      case AppNetworkImageShape.circle:
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            border: border,
          ),
          clipBehavior: Clip.antiAlias,
          child: image,
        );

      case AppNetworkImageShape.roundedRectangle:
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            border: border,
          ),
          clipBehavior: Clip.antiAlias,
          child: image,
        );

      case AppNetworkImageShape.rectangle:
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: borderRadius,
            border: border,
          ),
          clipBehavior: Clip.antiAlias,
          child: image,
        );
    }
  }
}

class _ImageShimmer extends StatefulWidget {
  const _ImageShimmer();

  @override
  State<_ImageShimmer> createState() => _ImageShimmerState();
}

class _ImageShimmerState extends State<_ImageShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _controller,
    builder: (_, _) => ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        final position = _controller.value * 2 - 1;

        return LinearGradient(
          begin: Alignment(-1 + position, 0),
          end: Alignment(position, 0),
          colors: [
            colors.fill.withValues(alpha: .3),
            colors.fill.withValues(alpha: .1),
            colors.fill.withValues(alpha: .3),
          ],
          stops: const [0.0, 0.5, 1.0],
        ).createShader(bounds);
      },
      child: const ColoredBox(color: Colors.grey),
    ),
  );
}

class _ImageError extends StatelessWidget {
  const _ImageError();

  @override
  Widget build(BuildContext context) => Container(
    alignment: Alignment.center,
    color: colors.fill,
    child: Icon(
      Icons.image_not_supported_outlined,
      color: Colors.grey.shade500,
      size: 30,
    ),
  );
}
