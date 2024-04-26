import 'package:crewmeister/app/extentions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// A widget that displays a Lottie animation.
///
/// This widget is used to render Lottie animations based on the provided [name].
/// It expects a [name] parameter, which represents the animation asset name.
///
/// Example usage:
/// ```dart
/// LottieWidget(name: 'my_animation.json')
/// ```
class LottieWidget extends StatelessWidget {
  const LottieWidget({super.key, required this.name});

  /// The name of the Lottie animation asset.
  final String name;

  @override
  Widget build(BuildContext context) {
    // Build a centered Lottie animation widget.
    return Center(
      child: Lottie.asset(
        name.animation, // Animation asset name
        renderCache: RenderCache.raster,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}


