import 'dart:io';

import 'package:flutter/material.dart';

class ProductAddImage extends StatelessWidget {
  final String? imageUrl;
  const ProductAddImage({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const borderRadiusImg = BorderRadius.only(
        topLeft: Radius.circular(30), topRight: Radius.circular(30));
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      width: double.infinity,
      height: 400,
      child: Opacity(
        opacity: 0.9,
        child: ClipRRect(
            borderRadius: borderRadiusImg, child: _getImage(imageUrl)),
      ),
      decoration: _boxDecorationImg(borderRadiusImg),
    );
  }

  BoxDecoration _boxDecorationImg(BorderRadius borderRadiusImg) {
    return BoxDecoration(
      borderRadius: borderRadiusImg,
      color: Colors.black,
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          offset: Offset(0, 5),
          blurRadius: 10,
        ),
      ],
    );
  }

  Widget _getImage(String? imageUrl) {
    if (imageUrl == null) {
      return const Image(
          image: AssetImage('assets/no-image.png'), fit: BoxFit.cover);
    }
    if (imageUrl.startsWith('http')) {
      return FadeInImage(
        image: NetworkImage(imageUrl),
        placeholder: const AssetImage('assets/loading.gif'),
        fit: BoxFit.cover,
      );
    }
    return Image.file(File(imageUrl), fit: BoxFit.cover);
  }
}
