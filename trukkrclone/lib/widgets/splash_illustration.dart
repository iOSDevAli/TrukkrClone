// import 'package:flutter/material.dart';
// import 'package:ms_undraw/ms_undraw.dart';
// import 'splash_road_scene.dart';

// /// Tries to render a real, sourced unDraw illustration (MIT-licensed
// /// artwork by Katerina Limpitsouni, via the `ms_undraw` package, which
// /// fetches from unDraw's CDN with disk caching). Falls back to the
// /// hand-built [SplashRoadScene] if that specific illustration name
// /// isn't available or the device has no network yet — so the splash
// /// screen never shows a broken image.
// ///
// /// NOTE: I couldn't verify the exact enum name against a running
// /// Flutter environment, so `UnDrawIllustration.delivery` is a
// /// best-guess. If it doesn't match, ms_undraw shows [errorWidget]
// /// (the fallback scene) automatically — check `UnDrawIllustration.values`
// /// in your IDE's autocomplete for the closest real match and swap it in.
// class SplashIllustration extends StatelessWidget {
//   final double height;
//   const SplashIllustration({super.key, this.height = 240});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: height,
//       width: double.infinity,
//       child: UnDraw(
//         illustration: UnDrawIllustration.delivery,
//         color: const Color(0xFF2563EB),
//         placeholder: SplashRoadScene(height: height),
//         errorWidget: SplashRoadScene(height: height),
//       ),
//     );
//   }
// }
