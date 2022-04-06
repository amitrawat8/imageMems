import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * Created by Amit Rawat on 4/6/2022.
 */

class ErrorText extends StatelessWidget {
  String text;

  ErrorText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: Text(text,
            style: TextStyle(
                fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold)),
      );
}
