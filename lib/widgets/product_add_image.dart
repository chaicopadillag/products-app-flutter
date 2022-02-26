import 'package:flutter/material.dart';

class ProductAddImage extends StatelessWidget {
  const ProductAddImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const borderRadiusImg = BorderRadius.only(
        topLeft: Radius.circular(30), topRight: Radius.circular(30));
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      width: double.infinity,
      height: 400,
      child: const ClipRRect(
        borderRadius: borderRadiusImg,
        child: FadeInImage(
          image: NetworkImage('http://placeimg.com/640/480/nature'),
          placeholder: AssetImage('assets/loading.gif'),
          fit: BoxFit.cover,
        ),
      ),
      decoration: _boxDecorationImg(borderRadiusImg),
    );
  }

  BoxDecoration _boxDecorationImg(BorderRadius borderRadiusImg) {
    return BoxDecoration(
      borderRadius: borderRadiusImg,
      color: Colors.white.withOpacity(0.5),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          offset: Offset(0, 5),
          blurRadius: 10,
        ),
      ],
    );
  }
}
