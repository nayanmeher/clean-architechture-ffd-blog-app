import 'package:clean_architechtrue_blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  final String buttonLabel;
  final VoidCallback onPressed;
  const AuthGradientButton({super.key, required this.buttonLabel, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
          AppPallete.gradient1,
          AppPallete.gradient2
        ],
          begin: Alignment.bottomLeft,
          end: Alignment.bottomRight
        ),
        borderRadius: BorderRadius.circular(7)
      ),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppPallete.transparentColor,
          shadowColor: AppPallete.transparentColor,
          fixedSize: const Size(395, 55)
      ),
          child: Text(buttonLabel),
      ),
    );
  }
}
