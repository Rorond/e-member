import 'package:emembers/constants.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: AppColors.primaryColor,
        strokeWidth: 1.5,
      ),
    );
  }
}
