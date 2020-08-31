import 'package:flutter/material.dart';

class LoadingForButton extends StatelessWidget {
  const LoadingForButton({
    Key key,
    this.color = Colors.white,
    this.height = 20,
    this.width = 20
  }) : super(key: key);

  final Color color;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Center(
          child: SizedBox(
            width: width,
            height: height,
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
              backgroundColor: color,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
            ),
          ),
        ),
    );
  }
}