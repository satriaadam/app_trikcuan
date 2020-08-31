import 'package:flutter/material.dart';
import 'package:trikcuan_app/utilities/app_consts.dart';

class BoxBordered extends StatelessWidget {
  const BoxBordered({
    Key key,
    this.child,
    this.borderRadius = 8,
    this.padding = 16,
    this.borderColor,
  }) : super(key: key);

  final Widget child;
  final double borderRadius;
  final double padding;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Box(
      borderColor: borderColor ?? AppColor.accent,
      padding: padding,
      child: child,
      borderRadius: borderRadius,
    );
  }
}

class BoxShadowed extends StatelessWidget {
  const BoxShadowed({
    Key key,
    this.child,
    this.borderRadius = 8,
    this.padding,
  }) : super(key: key);

  final Widget child;
  final double padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Box(
      padding: padding,
      child: child,
      borderRadius: borderRadius,
      boxShadow: [AppBoxShadow.type1],
    );
  }
}

class Box extends StatelessWidget {
  const Box({
    Key key,
    this.child,
    this.width,
    this.height,
    this.padding,
    this.color = Colors.white,
    this.borderRadius,
    this.borderColor,
    this.boxShadow,
    this.image,
    this.onPressed
  }) : super(key: key);

  final Widget child;
  final double width;
  final double height;
  final Color color;
  final double padding;
  final double borderRadius;
  final Color borderColor;
  final ImageProvider image;
  final List<BoxShadow> boxShadow;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onPressed,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        height: height,
        padding: EdgeInsets.all(padding ?? 0),
        child: child,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: borderColor ?? Colors.transparent, width: borderColor != null ? 1 : 0),
          boxShadow: boxShadow,
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
          image: image != null ? DecorationImage(image: image) : null
        ),
      ),
    );
  }
}