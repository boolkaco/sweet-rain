import 'package:flutter/material.dart';
import 'package:sweetbonanzarain/theme/app_colors.dart';

class OvalGradientContainer extends StatelessWidget {
  const OvalGradientContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double aspectRatio = size.height / size.width;

    final Matrix4 gradientMatrix = Matrix4.identity()
      ..scale(1.0, aspectRatio, 1.0);

    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 0.5,
          colors: const [
            AppColors.white,
            AppColors.black,
            AppColors.anakiwa,
          ],
          stops: const [0.0, 0.6684, 1.0],
          transform: GradientMatrix(gradientMatrix),
        ),
      ),
    );
  }
}

class GradientMatrix extends GradientTransform {
  final Matrix4 matrix;

  const GradientMatrix(this.matrix);

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) {
    return matrix;
  }
}
