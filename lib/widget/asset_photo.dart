import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'shimmer_effect.dart';

class AssetPhoto extends StatefulWidget {
  final String? image;
  final double? width;
  final double? height;
  final double? radius;
  final BoxFit? fit;

  const AssetPhoto({
    super.key,
    this.image,
    this.width,
    this.height,
    this.radius,
    this.fit
  });

  @override
  State<AssetPhoto> createState() => _AssetPhotoState();
}

class _AssetPhotoState extends State<AssetPhoto> {
  @override
  initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.dialog(
          Align(
            alignment: Alignment.center,
            child: InteractiveViewer(
              child: Image.network(
                widget.image ??
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/2560px-Placeholder_view_vector.svg.png',
                height: Get.width * 0.9,
                width: Get.width * 0.9,
                fit: widget.fit ?? BoxFit.contain,
              ),
            ),
          ),
          barrierColor: Colors.black.withOpacity(0.6),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.radius ?? 5.r),
        child: CachedNetworkImage(
          imageUrl: widget.image ??
              'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/2560px-Placeholder_view_vector.svg.png',
          height: widget.height ?? 60.h,
          width: widget.width ?? 60.w,

                fit: widget.fit ?? BoxFit.contain,
          placeholder: (_, __) => ShimmerEffect(
            width: 60.w,
            height: 60.h,
            radius: 5.r,
          ),
        ),
      ),
    );
  }
}

