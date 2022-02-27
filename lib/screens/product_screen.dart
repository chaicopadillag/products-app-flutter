import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:products_app/providers/product_form_provider.dart';
import 'package:products_app/services/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:products_app/ui/input_decorations.dart';
import 'package:products_app/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.productSelected),
      child: _ProductScreenBody(productService: productService),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductService productService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
        children: [
          Stack(
            children: [
              ProductAddImage(
                  imageUrl: productService.productSelected.photoUrl),
              Positioned(
                  top: 20,
                  left: 10,
                  child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.chevron_left_rounded,
                        size: 40,
                        color: Colors.deepPurple,
                      ))),
              Positioned(
                  top: 20,
                  right: 20,
                  child: IconButton(
                      onPressed: () async {
                        final picker = ImagePicker();
                        final XFile? xFile = await picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 100);

                        if (xFile == null) {
                          return;
                        }
                        productService.updateSelectProductImage(xFile.path);
                      },
                      icon: const Icon(
                        Icons.camera_alt_rounded,
                        size: 40,
                        color: Colors.deepPurple,
                      )))
            ],
          ),
          const _ProductForm(),
          const SizedBox(height: 100),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: productService.isLoading
            ? null
            : () async {
                final productFormProvider =
                    Provider.of<ProductFormProvider>(context, listen: false);
                if (!productFormProvider.isValid()) return;

                final String? imgUrl = await productService.uploadImage();
                if (imgUrl != null) {
                  productService.productSelected.photoUrl = imgUrl;
                }
                await productService
                    .saveOrCreateProduct(productFormProvider.product);

                Navigator.of(context).pop();
              },
        child: productService.isSaving
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Icon(Icons.save),
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productFormProvider = Provider.of<ProductFormProvider>(context);
    final product = productFormProvider.product;

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        child: Form(
            key: productFormProvider.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: product.name,
                  onChanged: (value) => product.name = value,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 3) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  decoration: InputDecorations.getInputDecoration(
                      hintText: 'Pencil', labelText: 'Product name'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: product.price.toString(),
                  onChanged: (value) {
                    if (double.tryParse(value) == null) {
                      product.price = 0;
                    } else {
                      product.price = double.parse(value);
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecorations.getInputDecoration(
                      hintText: '100', labelText: 'Product price'),
                ),
                const SizedBox(height: 10),
                SwitchListTile.adaptive(
                  value: product.available,
                  onChanged: productFormProvider.toggleAvailable,
                  title: const Text('Product is available'),
                  activeColor: Colors.deepPurple,
                ),
                const SizedBox(height: 30),
              ],
            )));
  }
}
