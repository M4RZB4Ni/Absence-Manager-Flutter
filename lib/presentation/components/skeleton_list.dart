import 'package:communere/app/extentions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// A widget that displays a list of placeholder items with loading animations.
///
/// This widget is typically used to indicate that data is currently being loaded
/// and will be displayed in place of the actual list items until the content is available.
class SkeletonList extends StatelessWidget {

  /// The number of skeleton items to display.
  ///
  /// Defaults to 25 if not specified.
  final int size;

  /// Creates a [SkeletonList] widget.
  ///
  /// An optional [size] parameter can be provided to specify the number of
  /// skeleton items to be displayed.
  const SkeletonList({super.key, this.size = 25});

  @override
  Widget build(BuildContext context) {
    // Get the device height for dynamic sizing of the skeleton items.
    final height = MediaQuery.of(context).size.height;

    // Build a list view of skeleton items.
    return ListView.builder(
      itemCount: size, // The number of skeleton items to display.
      itemBuilder: (context, index) {
        // Each item consists of a loading image and a loading text animation.
        return ListTile(
          leading: Lottie.asset('loading_img'.animation,
              width: 70, height: height * 0.50, fit: BoxFit.fill),
          minLeadingWidth: 50,
          title: Lottie.asset('loading_txt'.animation, height: height * 0.120),
        );
      },
    );
  }
}

