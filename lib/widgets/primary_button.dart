import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final bool isLoading;
  const PrimaryButton({
    super.key,
    required this.onTap,
    required this.text,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: 61,
        width: double.maxFinite,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23),
          color: const Color(0xFFFFA500),
        ),
        child:
            isLoading
                ? CircularProgressIndicator(color: Colors.black)
                : Text(
                  text,
                  style: TextStyle(
                    color: const Color(0xFF101010),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
      ),
    );
  }
}
