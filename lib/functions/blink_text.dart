import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class BlinkText extends StatefulWidget {
  final String _target;

  const BlinkText(this._target, {Key? key}) : super(key: key);

  @override
  State<BlinkText> createState() => _BlinkTextState();
}

class _BlinkTextState extends State<BlinkText> {
  //blinking text
  bool _show = true;
  Timer? _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(milliseconds: 600), (_) {
      setState(() {
        _show = !_show;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Text(widget._target,
      style: _show
          ? const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red)
          : const TextStyle(color: Colors.transparent));
}
