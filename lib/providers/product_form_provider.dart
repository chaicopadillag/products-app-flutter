import 'package:flutter/material.dart';
import 'package:products_app/models/models.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Product product;

  ProductFormProvider(this.product);

  bool isValid() {
    return formKey.currentState?.validate() ?? false;
  }

  toggleAvailable(bool value) {
    product.available = value;
    notifyListeners();
  }
}
