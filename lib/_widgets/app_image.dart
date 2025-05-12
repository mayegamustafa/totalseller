import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:seller_management/_core/common/logger.dart';
import 'package:seller_management/_core/extensions/context_extension.dart';
import 'package:seller_management/_widgets/shimmer.dart';

class HostedImage extends StatelessWidget {
  const HostedImage(
    this.url, {
    super.key,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.enablePreviewing = false,
    this.onImgTap,
    this.errorIcon,
  });

  const HostedImage.square(
    this.url, {
    super.key,
    double? dimension,
    this.fit = BoxFit.cover,
    this.enablePreviewing = false,
    this.onImgTap,
    this.errorIcon,
  })  : height = dimension,
        width = dimension;

  final String url;
  final BoxFit fit;
  final double? height;
  final double? width;
  final IconData? errorIcon;
  final void Function()? onImgTap;

  /// if [onImgTap] is null this will be ignored
  final bool enablePreviewing;

  static ImageProvider provider(
    String url, {
    int? maxHeight,
    int? maxWidth,
  }) {
    return CachedNetworkImageProvider(
      url,
      maxHeight: maxHeight,
      maxWidth: maxWidth,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      hoverColor: Colors.transparent,
      onTap: enablePreviewing
          ? () => context.nPush(
                url.startsWith('http')
                    ? PhotoView.network(url)
                    : PhotoView.asset(url),
              )
          : onImgTap,
      child: CachedNetworkImage(
        imageUrl: url,
        height: height,
        width: width,
        fit: fit,
        progressIndicatorBuilder: (context, url, _) =>
            KShimmer.card(height: height ?? 50, width: width ?? 50),
        errorWidget: (context, url, e) {
          Logger.ex(e, null, 'Error while loading image');
          return SizedBox(
            height: height ?? 50,
            width: width ?? 50,
            child: Icon(errorIcon ?? Icons.image_not_supported_rounded),
          );
        },
      ),
    );
  }
}

class PhotoView extends HookWidget {
  const PhotoView(this.image, {super.key});

  PhotoView.network(String url, {super.key})
      : image = ExtendedNetworkImageProvider(url);

  // PhotoView.file(File file, {super.key})
  //     : image = ExtendedFileImageProvider(file);

  PhotoView.asset(String asset, {super.key})
      : image = ExtendedAssetImageProvider(asset);

  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ExtendedImageGesturePageView.builder(
        itemCount: 1,
        itemBuilder: (ctx, i) => ExtendedImage(
          image: image,
          fit: BoxFit.contain,
          mode: ExtendedImageMode.gesture,
          onDoubleTap: (d) => context.pop(),
          loadStateChanged: (state) {
            if (state.extendedImageLoadState == LoadState.loading) {
              return KShimmer.card(
                padding: const EdgeInsets.all(20),
                height: state.extendedImageInfo?.image.height.toDouble(),
                width: state.extendedImageInfo?.image.width.toDouble(),
              );
            }
            if (state.extendedImageLoadState == LoadState.failed) {
              return const Icon(Icons.image_not_supported_rounded, size: 30);
            }
            return null;
          },
        ),
      ),
    );
  }
}
