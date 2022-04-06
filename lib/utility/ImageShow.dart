import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * Created by Amit Rawat on 4/6/2022.
 */

class ImageLoader extends StatelessWidget {
  String url;

  ImageLoader(this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        imageUrl: url,
        progressIndicatorBuilder: (context, url, progress) => Center(
          child: CircularProgressIndicator(
            value: progress.progress,
          ),
        ),
        errorWidget: (context, url, error) => Center(
          child: Icon(
            Icons.error,
            size: 30,
          ),
        ),
        fit: BoxFit.fill,
      ),
    );
  }
}
