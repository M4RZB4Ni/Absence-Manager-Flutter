import 'package:communere/app/extentions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieWidget extends StatelessWidget {

  const LottieWidget({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    // Build a list view of skeleton items.
    return Lottie.asset(name.animation,renderCache: RenderCache.raster);
  }
}

