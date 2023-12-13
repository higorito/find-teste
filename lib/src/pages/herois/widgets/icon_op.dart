import 'package:flutter/material.dart';

class IconItens extends StatelessWidget {
  final String image;

  const IconItens({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(1, 1),
            blurRadius: 3,
            spreadRadius: 3,
          ),
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(62),
        ),
      ),
      child: Image.asset(image),
    );
  }
}
