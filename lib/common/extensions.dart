import 'package:flutter/cupertino.dart';

// extension WidgetExtension on Widget {
//   Widget addBackgroundContainer() {
//     return Container(
//       decoration: const BoxDecoration(
//           image:
//               DecorationImage(image: AssetImage('assets/images/bg_image.png'))),
//       child: this,
//     );
//   }
// }

extension WidgetExtension on Widget {
  Widget withBackgroundImage() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg_image.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: this, // Preserve the child of the original Container
    );
  }
}
