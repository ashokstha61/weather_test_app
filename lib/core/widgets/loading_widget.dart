import 'package:flutter/material.dart';
import 'package:weather/core/utils/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  final double strokeWidth;
  final Color color;

  const LoadingWidget(
      {Key? key, this.strokeWidth = 4.0, this.color = AppColors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: strokeWidth,
      ),
    );
  }
}
