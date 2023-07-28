import 'package:flutter/material.dart';
import 'package:newtest/theme.dart';

class Loader extends StatelessWidget {
  final bool withOverlay;

  const Loader({
    super.key,
    this.withOverlay = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: withOverlay
          ? [
              const Opacity(
                opacity: 0.5,
                child: ModalBarrier(dismissible: false, color: Colors.black),
              ),
              Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  backgroundColor: bgRed,
                  color: bgWhite,
                ),
              ),
            ]
          : [
              Container(
                color: Colors.white,
              ),
              const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            ],
    );
  }
}
