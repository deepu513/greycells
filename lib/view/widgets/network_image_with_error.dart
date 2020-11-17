import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:greycells/view/widgets/centered_circular_loading.dart';

class NetworkImageWithError extends StatelessWidget {
  final String imageUrl;
  final BoxFit boxFit;

  const NetworkImageWithError({
    Key key,
    this.imageUrl,
    this.boxFit = BoxFit.contain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: boxFit,
      placeholder: (context, url) =>
          CenteredCircularLoadingIndicator(),
      errorWidget: (context, url, error) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.broken_image_rounded,
              size: 48.0,
              color: Colors.grey,
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              "Unable to load image!",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Colors.white),
            )
          ],
        );
      },
    );
  }
}
