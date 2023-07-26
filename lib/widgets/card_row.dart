import 'package:flutter/material.dart';

class CardRow extends StatelessWidget {
  final String name;
  final String text;

  const CardRow({
    required this.name,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) {
      return const SizedBox();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          child: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            softWrap: true,
          ),
        ),
        Flexible(
          child: Text(
            text,
            textAlign: TextAlign.end,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
