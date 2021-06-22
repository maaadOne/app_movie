import 'package:app_movie/src/theme/pallette.dart';
import 'package:flutter/material.dart';

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(
          strokeWidth: 1.5,
          color: azureColor,
        ),
      ),
    );
  }
}
