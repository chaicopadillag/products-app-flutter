import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: const Center(
        child: Icon(
          Icons.airplanemode_off_outlined,
          size: 50,
          color: Colors.red,
        ),
      ),
    );
  }
}
