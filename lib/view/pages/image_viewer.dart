import 'package:flutter/material.dart';
import 'package:greycells/view/widgets/network_image_with_error.dart';

class ImageViewer extends StatelessWidget {
  final String imageUrl;

  const ImageViewer({Key key, @required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        title: Text(
          'Image',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.black87),
        ),
      ),
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
          color: Colors.black,
          child: InteractiveViewer(
            boundaryMargin: EdgeInsets.all(8.0),
            child: NetworkImageWithError(
              imageUrl: imageUrl,
            ),
          ),
        ),
      ),
    );
  }
}
