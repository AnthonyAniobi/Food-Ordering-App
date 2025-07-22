import 'package:flutter/material.dart';

class TextOptionsWidget extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final bool selected;

  const TextOptionsWidget({
    super.key,
    required this.text,
    required this.onTap,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF797D82)),
          borderRadius: BorderRadius.circular(10),
          color: selected ? const Color(0xFF797D82) : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : const Color(0xFF797D82),
          ),
        ),
      ),
    );
  }
}
