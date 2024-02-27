import 'package:aquae_florentis/presentation/resources/color-manager.dart';
import 'package:aquae_florentis/presentation/widgets/lottie-widget.dart';
import 'package:flutter/material.dart';

class CircleImage extends StatefulWidget {
  final DecorationImage image;
  final double size;
  const CircleImage({super.key, required this.image, required this.size});

  @override
  State<CircleImage> createState() => _CircleImageState();
}

class _CircleImageState extends State<CircleImage> {

  // Because of Networkimage loading issues in some os(e.g web, windows, macos),
  // We have to pre-load the image and show dummy🥴 animation while image is loading.


  bool imageLoaded = false;

  @override
  void initState() {
    super.initState();
    loadImage();
  }
  
  Future<void> loadImage() async{
    final ImageStream imageStream = widget.image.image.resolve(ImageConfiguration.empty);
    imageStream.addListener(ImageStreamListener((image, synchronousCall) {
      if(mounted){
        setState(() {
          imageLoaded = true;
        });
      }
    }));

  }

  @override
  Widget build(BuildContext context) {
    return imageLoaded? Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: widget.image
      ),
    ): Container(
      width: widget.size,
      height: widget.size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColorManager.tertiary
      ),
      child: LottieIcon("loading", size: widget.size, fit: BoxFit.scaleDown,repeat: true),
    );
  }
}