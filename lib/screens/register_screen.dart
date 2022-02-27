import 'package:flutter/material.dart';
import 'package:products_app/providers/login_form_provider.dart';
import 'package:products_app/services/services.dart';
import 'package:provider/provider.dart';
import 'package:products_app/ui/input_decorations.dart';
import 'package:products_app/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
            child: Column(
          children: [
            const SizedBox(height: 250),
            CustomCard(
                child: Column(children: [
              const SizedBox(height: 10),
              Text('Register', style: Theme.of(context).textTheme.headline3),
              const SizedBox(height: 30),
              ChangeNotifierProvider(
                create: (_) => LoginFormProvider(),
                child: const _RegisterForm(),
              ),
            ])),
            const SizedBox(height: 50),
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                      Colors.deepPurple.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(const StadiumBorder())),
              child: const Text('Login here',
                  style: TextStyle(fontSize: 18, color: Colors.deepPurple)),
            ),
            const SizedBox(height: 20),
          ],
        )),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final form = Provider.of<LoginFormProvider>(context);

    return Form(
      key: form.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.getInputDecoration(
                hintText: 'retta.huel@yahoo.com',
                labelText: 'Email',
                prefixIcon: Icons.email_outlined),
            onChanged: (value) => form.email = value,
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

              RegExp regExp = RegExp(pattern);
              return regExp.hasMatch(value ?? '') ? null : 'Invalid email';
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: InputDecorations.getInputDecoration(
                hintText: '********',
                labelText: 'Password',
                prefixIcon: Icons.lock_outline),
            onChanged: (value) => form.password = value,
            validator: (value) {
              return value != null && value.length >= 6
                  ? null
                  : 'Password is required and must be at least 6 characters';
            },
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.deepPurple,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
              child: Text(
                form.isLoading ? 'Please...' : 'Submit',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            onPressed: form.isLoading
                ? null
                : () async {
                    final authService =
                        Provider.of<AuthService>(context, listen: false);

                    FocusScope.of(context).unfocus();
                    if (!form.isValidForm()) return;
                    form.isLoading = true;

                    final String? error =
                        await authService.signUp(form.email, form.password);
                    if (error == null) {
                      Navigator.pushReplacementNamed(context, 'home');
                    } else {
                      SnackBarNotificationService.showMessage(error);
                    }
                    form.isLoading = false;
                  },
          ),
        ],
      ),
    );
  }
}
