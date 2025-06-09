import 'dart:async';

import 'package:flutter/material.dart';

class SlowTextLoader extends StatefulWidget {
  final String fullText;
  final Duration speed;
  final TextStyle? style;

  const SlowTextLoader({
    Key? key,
    required this.fullText,
    this.speed = const Duration(milliseconds: 50),
    this.style,
  }) : super(key: key);

  @override
  _SlowTextLoaderState createState() => _SlowTextLoaderState();
}

class _SlowTextLoaderState extends State<SlowTextLoader> {
  String _visibleText = '';
  int _index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    _timer = Timer.periodic(widget.speed, (timer) {
      if (_index < widget.fullText.length) {
        setState(() {
          _visibleText += widget.fullText[_index];
          _index++;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(_visibleText, style: widget.style);
  }
}
