import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key, required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
          items.length,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: Colors.amber,
            width: 100,
            child: Center(
              child: Text('item : [$index]'),
            ),
          ),
        ),
      ),
    );
  }
}
