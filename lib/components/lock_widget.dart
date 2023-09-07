import 'package:flutter/material.dart';

class LockWidget extends StatelessWidget {
  const LockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 100,
      color: Colors.grey,
      child: const Center(
        child: Icon(
          Icons.lock,
          size: 30,
        ),
      ),
    );
  }
}
