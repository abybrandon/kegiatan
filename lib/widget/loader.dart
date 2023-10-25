import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:newtest/theme.dart';

class Loader extends StatelessWidget {
  final bool withOverlay;
  final bool zeroOpacity;

  const Loader({
    super.key,
    this.zeroOpacity = false,
    this.withOverlay = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: withOverlay
          ? [
               Opacity(
                opacity: zeroOpacity ? 0 : 0.3,
                child: ModalBarrier(dismissible: false, color: Colors.black),
              ),
              Align(
                alignment: Alignment.center,
                child: Lottie.asset('assets/animation/loader.json'),
              ),
            ]
          : [
              Container(
                color: Colors.white,
              ),
               Align(
                alignment: Alignment.center,
                child:  Lottie.asset('assets/animation/loader.json'),
              ),
            ],
    );
  }
}
