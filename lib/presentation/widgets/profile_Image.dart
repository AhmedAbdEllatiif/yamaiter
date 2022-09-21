import 'dart:io';

import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final double? minRadius;
  final double? maxRadius;
  final String image;

  const ProfileImage({Key? key, this.minRadius, this.maxRadius, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      minRadius: minRadius,
      maxRadius: maxRadius,
      backgroundImage: FileImage(
        File(image),
      ),
    );
  }
}
