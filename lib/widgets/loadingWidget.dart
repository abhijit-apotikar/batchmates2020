import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../class/colorCodeNotifier.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localColorCodeNotifier = Provider.of<ColorCodeNotifier>(context);
    final localColorCode = localColorCodeNotifier.getColorCode();
    return Container(
      color: localColorCode.loadingBackground,
      child: Center(
        child: SpinKitCircle(
          color: localColorCode.loadingForeground,
          size: 50,
        ),
      ),
    );
  }
}
