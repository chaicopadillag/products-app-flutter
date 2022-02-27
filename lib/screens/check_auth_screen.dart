import 'package:flutter/material.dart';
import 'package:products_app/screens/screens.dart';
import 'package:products_app/services/services.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.isAuthenticated(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator.adaptive(
                backgroundColor: Colors.deepPurple,
              );
            }

            if (snapshot.data == '') {
              Future.microtask(() => {
                    // Navigator.of(context).pushReplacementNamed('login')
                    Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const LoginScreen(),
                          transitionDuration: const Duration(seconds: 0),
                        ))
                  });
            } else {
              Future.microtask(() => {
                    // Navigator.of(context).pushReplacementNamed('login')
                    Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const HomeScreen(),
                          transitionDuration: const Duration(seconds: 0),
                        ))
                  });
            }
            return const CircularProgressIndicator.adaptive(
              backgroundColor: Colors.deepPurple,
            );
          },
        ),
      ),
    );
  }
}
