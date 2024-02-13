import 'package:sweetbonanzarain/const/assets.dart';
import 'package:sweetbonanzarain/services/images_service.dart';
import 'package:sweetbonanzarain/widgets/app_logo.dart';
import 'package:flutter/material.dart';

class BackgroundWrapper extends StatefulWidget {
  final Widget child;
  final String backgroundUrl;
  final double opacity;
  final bool isAnimate;
  final bool isStatic;
  final bool isShownLogo;

  const BackgroundWrapper({
    Key? key,
    required this.child,
    this.backgroundUrl = '/assets/bg.png',
    this.opacity = 0.5,
    this.isAnimate = false,
    this.isStatic = true,
    this.isShownLogo = true,
  }) : super(key: key);

  @override
  State<BackgroundWrapper> createState() => _BackgroundWrapperState();
}

class _BackgroundWrapperState extends State<BackgroundWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1, end: 0.9).animate(
      _animationController,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.55),
      end: const Offset(0, -0.1),
    ).animate(
      _animationController,
    );

    if (widget.isAnimate) {
      _animationController.forward();
    }

    if (widget.isStatic) {
      _animationController.value = _animationController.upperBound;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(BackgroundWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimate && !oldWidget.isAnimate) {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Positioned.fill(
          child: Image.file(
            ImagesService().getByFilename(widget.backgroundUrl)!,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          bottom: 100,
          child: OverflowBox(
            maxWidth: size.width * 3.5,
            maxHeight: size.height * 3.5,
            alignment: Alignment.center,
            child: Image.file(
              ImagesService().getByFilename(assetsMap['blink']!)!,
              width: size.width * 3.5,
            ),
          ),
        ),
        if (widget.isShownLogo)
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.topCenter,
              child: SlideTransition(
                position: _offsetAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: const AppLogo(),
                ),
              ),
            ),
          ),
        widget.child,
      ],
    );
  }
}
