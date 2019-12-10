import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/widgets.dart';

@immutable
class FitText extends StatelessWidget {
  final String text;
  final int maxLines;
  final EdgeInsets padding;
  final TextStyle style;
  final TextAlign textAlign;

  const FitText(
    this.text, {
    this.maxLines,
    this.padding = EdgeInsets.zero,
    this.style,
    this.textAlign,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lines = maxLines ?? text.split('\n').length;
    return Padding(
      padding: padding,
      child: AutoSizeText(
        text,
        textAlign: textAlign,
        maxLines: lines,
        style: style,
        minFontSize: 1,
      ),
    );
  }
}
