import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DefaultLoading extends StatelessWidget {
  const DefaultLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SpinKitSpinningLines(
          color: Colors.black,
          size: 100.0,
        ),
        Text('Fetching data...'),
      ],
    );
  }
}
