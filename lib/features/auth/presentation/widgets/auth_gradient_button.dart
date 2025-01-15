import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback ontap;
  const AuthGradientButton({super.key,required this.ontap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                AppPallete.gradient1,
                AppPallete.gradient2,
              ])),
      child: ElevatedButton(
        onPressed: ontap,
        style: ElevatedButton.styleFrom(
          fixedSize: Size(395, 55),
          backgroundColor: AppPallete.transparentColor,
          shadowColor: AppPallete.transparentColor,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
