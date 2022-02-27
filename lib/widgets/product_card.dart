import 'package:flutter/material.dart';
import 'package:products_app/models/models.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      width: double.infinity,
      height: 350,
      decoration: _productCardBoxShadow(),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          _BackgroundImage(product: product),
          _ProductCardContent(
            product: product,
          ),
          Positioned(
            child: _ProductTagPrice(
              product: product,
            ),
            top: 0,
            right: 0,
          ),
          if (!product.available)
            const Positioned(
              child: _ProductTagNotAvailable(),
              top: 0,
              left: 0,
            ),
        ],
      ),
    );
  }

  BoxDecoration _productCardBoxShadow() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          offset: Offset(0, 5),
          blurRadius: 10,
        ),
      ],
    );
  }
}

class _ProductTagPrice extends StatelessWidget {
  final Product product;
  const _ProductTagPrice({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      width: 70,
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 5),
            blurRadius: 10,
          ),
        ],
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          '\$${product.price}',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _ProductTagNotAvailable extends StatelessWidget {
  const _ProductTagNotAvailable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      width: 70,
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 5),
            blurRadius: 10,
          ),
        ],
      ),
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Text(
          'No Available',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _ProductCardContent extends StatelessWidget {
  final Product product;
  const _ProductCardContent({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 70),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              product.id.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        decoration: const BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
      ),
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  final Product product;
  const _BackgroundImage({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: SizedBox(
        width: double.infinity,
        height: 350,
        child: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(
              product.photoUrl ?? 'http://placeimg.com/640/480/nature'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
