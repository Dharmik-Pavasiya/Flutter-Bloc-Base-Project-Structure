import 'dart:ui';

import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  final Widget? child;
  final bool isLoading;

  const AppLoader({super.key, this.child, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoading, // Prevents user interaction
      child: Stack(
        children: [
          child ?? Offstage(),
          // Blurry background
          if (isLoading) ...[
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(color: Colors.black54),
            ),
            // Loader in center
            const Center(child: CircularProgressIndicator()),
          ],
        ],
      ),
    );
  }
}
