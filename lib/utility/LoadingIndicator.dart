import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/**
 * Created by Amit Rawat on 4/6/2022.
 */

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Center(
        child: SpinKitCircle(
          color: Colors.blue,
          size: 50,
        ),
      );
}
