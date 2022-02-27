import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:products_app/models/models.dart';
import 'package:http/http.dart' as http;

class ProductService extends ChangeNotifier {
  final String _baseUrl = 'flutter-app-dev-chaico-default-rtdb.firebaseio.com';
  bool isLoading = true;
  bool isError = false;
  bool isSaving = false;
  final List<Product> products = [];
  late Product productSelected;

  final storage = const FlutterSecureStorage();

  File? newPicturefile;

  ProductService() {
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      isLoading = true;
      isError = false;

      notifyListeners();

      final url = Uri.https(_baseUrl, 'products.json',
          {'auth': await storage.read(key: 'token')});
      final response = await http.get(url);
      final Map<String, dynamic> productMap = json.decode(response.body);

      productMap.forEach((key, prod) {
        final producTemp = Product.fromMap(prod);
        producTemp.id = key;
        products.add(producTemp);
      });

      isLoading = false;

      notifyListeners();
    } catch (error) {
      isLoading = false;
      isError = true;
      notifyListeners();
    }
  }

  Future saveOrCreateProduct(Product product) async {
    try {
      isSaving = true;
      notifyListeners();

      if (product.id == null) {
        final url = Uri.https(_baseUrl, 'products.json',
            {'auth': await storage.read(key: 'token')});
        final response = await http.post(url, body: product.toJson());
        final Map<String, dynamic> productMap = json.decode(response.body);
        product.id = productMap['name'];
        products.add(product);
      } else {
        final url = Uri.https(_baseUrl, 'products/${product.id}.json',
            {'auth': await storage.read(key: 'token')});
        await http.put(url, body: product.toJson());
        // final decodeData = json.decode(response.body);
        // print(decodeData);
      }
      final index = products.indexWhere((prod) => prod.id == product.id);
      products[index] = product;

      isSaving = false;
      notifyListeners();
    } catch (error) {
      isSaving = false;
      notifyListeners();
    }
  }

  updateSelectProductImage(String path) {
    productSelected.photoUrl = path;
    newPicturefile = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  Future<String?> uploadImage() async {
    try {
      if (newPicturefile == null) return null;

      isSaving = true;
      notifyListeners();

      final url = Uri.parse(
          'https://api.cloudinary.com/v1_1/deygrepht/image/upload?upload_preset=product-flutter');
      final imageUploadRequest = http.MultipartRequest('POST', url);
      final file =
          await http.MultipartFile.fromPath('file', newPicturefile!.path);

      imageUploadRequest.files.add(file);

      final streamResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamResponse);

      if (response.statusCode != 200 && response.statusCode != 201) {
        isSaving = false;
        notifyListeners();
        return null;
      }

      newPicturefile = null;

      final responseData = json.decode(response.body);

      return responseData['secure_url'];
    } catch (error) {
      return null;
    }
  }
}
