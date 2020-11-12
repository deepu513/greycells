import 'package:flutter/material.dart';

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
    return Image.network(
      imageUrl,
      fit: boxFit,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes
                : null,
          ),
        );
      },
      errorBuilder: (context, _, __) {
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
