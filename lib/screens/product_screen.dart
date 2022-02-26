import 'package:flutter/material.dart';
import 'package:products_app/ui/input_decorations.dart';
import 'package:products_app/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Stack(
            children: [
              const ProductAddImage(),
              Positioned(
                  top: 10,
                  left: 10,
                  child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.chevron_left_rounded,
                        size: 40,
                        color: Colors.white,
                      ))),
              Positioned(
                  top: 10,
                  right: 20,
                  child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.camera_alt_rounded,
                        size: 40,
                        color: Colors.white,
                      )))
            ],
          ),
          const _ProductForm(),
          const SizedBox(height: 100),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.save),
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        child: Form(
            child: Column(
          children: [
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecorations.getInputDecoration(
                  hintText: 'Pencil', labelText: 'Product name'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecorations.getInputDecoration(
                  hintText: '100', labelText: 'Product price'),
            ),
            const SizedBox(height: 10),
            SwitchListTile.adaptive(
              value: true,
              onChanged: (value) {},
              title: const Text('Product is available'),
              activeColor: Colors.deepPurple,
            ),
            const SizedBox(height: 30),
          ],
        )));
  }
}
