import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;
  const AuthBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _BoxHearderBg(),
          SafeArea(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 30),
              child: const Icon(
                Icons.person_pin,
                size: 100,
                color: Colors.white,
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _BoxHearderBg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      decoration: _bgHeaderGradient(),
      child: Stack(children: [
        Positioned(
          child: _ShapeCircle(),
          top: 90,
          left: 30,
        ),
        Positioned(
          child: _ShapeCircle(),
          top: -40,
          left: -30,
        ),
        Positioned(
          child: _ShapeCircle(),
          top: -50,
          right: -20,
        ),
        Positioned(
          child: _ShapeCircle(),
          bottom: -50,
          left: 10,
        ),
        Positioned(
          child: _ShapeCircle(),
          bottom: 90,
          right: 20,
        ),
      ]),
    );
  }

  BoxDecoration _bgHeaderGradient() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromRGBO(63, 63, 156, 1),
          Color.fromRGBO(90, 70, 178, 1),
        ],
      ),
    );
  }
}

class _ShapeCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: const BoxDecoration(
        // borderRadius: BorderRadius.all(Radius.circular(100)),
        shape: BoxShape.circle,
        color: Color.fromRGBO(255, 255, 255, .05),
        // color: Color.fromARGB(255, 255, 0, 0),
      ),
    );
  }
}
