import 'package:flutter/material.dart';
import 'package:trikcuan_app/utilities/app_consts.dart';

class TitleText extends StatelessWidget {
  const TitleText(this.text, {
    Key key,
    this.maxLines,
    this.textAlign
  }) : super(key: key);

  final String text;
  final int maxLines;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return TextCustom(
      text,
      fontSize: 18,
      maxLines: maxLines,
      textAlign: textAlign,
      fontWeight: FontWeight.w600,
    );
  }
}

class SubtitleText extends StatelessWidget {
  const SubtitleText(this.text, {
    Key key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return TextCustom(
      text,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );
  }
}

class LabelText extends StatelessWidget {
  const LabelText(this.text, {
    Key key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return TextCustom(
      text,
      fontSize: 12,
      color: Colors.grey,
    );
  }
}

class BoldText extends StatelessWidget {
  const BoldText(this.text, {
    Key key,
    this.color
  }) : super(key: key);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return TextCustom(
      text,
      color: color,
      fontWeight: FontWeight.w600,
    );
  }
}

class SmallText extends StatelessWidget {
  const SmallText(this.text, {
    Key key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return TextCustom(
      text,
      fontSize: 12,
    );
  }
}

class PrimaryText extends StatelessWidget {
  const PrimaryText(this.text, {
    Key key,
    this.fontSize,
    this.fontWeight,
  }) : super(key: key);

  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return TextCustom(
      text,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: AppColor.primary,
    );
  }
}

class ErrorText extends StatelessWidget {
  const ErrorText(this.text, {
    Key key,
    this.fontSize,
    this.fontWeight,
  }) : super(key: key);

  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return TextCustom(
      text,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: Colors.red,
    );
  }
}

class AccentText extends StatelessWidget {
  const AccentText(this.text, {
    Key key,
    this.fontSize,
    this.fontWeight
  }) : super(key: key);

  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return TextCustom(
      text,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: AppColor.accent,
    );
  }
}

class PriceText extends StatelessWidget {
  const PriceText(this.text, {
    Key key,
    this.fontSize,
    this.fontWeight
  }) : super(key: key);

  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return TextCustom(
      text,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: AppColor.pink,
    );
  }
}

class GreyText extends StatelessWidget {
  const GreyText(this.text, {
    Key key,
    this.fontSize,
    this.fontWeight
  }) : super(key: key);

  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return TextCustom(
      text,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: Colors.grey,
    );
  }
}

class TextCustom extends StatelessWidget {
  const TextCustom(this.text, {
    Key key,
    this.color = Colors.black87,
    this.fontSize = 14,
    this.maxLines = 1,
    this.textAlign = TextAlign.left,
    this.fontWeight = FontWeight.normal
  }) : super(key: key);

  final String text;
  final Color color;
  final double fontSize;
  final int maxLines;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}