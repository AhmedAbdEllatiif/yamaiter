import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:yamaiter/common/constants/assets_constants.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';

import '../../../common/functions/open_image.dart';
import '../../../domain/entities/data/ad_entity.dart';

class ArticleImageSliderWidget extends StatelessWidget {
  final List<String> images;

  const ArticleImageSliderWidget({Key? key, required this.images})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Images >> $images");
    return CarouselSlider(
      options: CarouselOptions(
        height: ScreenUtil.screenHeight * 0.18,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: false,
        reverse: false,
        // autoPlay: true,
        // autoPlayInterval: Duration(seconds: 5),
        // autoPlayAnimationDuration: Duration(milliseconds: 2000),
        // autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        //onPageChanged: callbackFunction,
        scrollDirection: Axis.horizontal,
      ),
      items: images.map((singleImg) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: double.infinity,
                //margin: const EdgeInsets.symmetric(horizontal: 3.0),
                color: AppColor.primaryDarkColor,
                child: GestureDetector(
                  onTap: () => openImage(
                    context,
                    image: singleImg,
                    isCircle: false,
                  ),
                  child: Hero(
                    tag: "smallImage",
                    child: CachedNetworkImage(
                      imageUrl: singleImg,
                      fit: BoxFit.cover,
                    ),
                  ),
                ));
          },
        );
      }).toList(),
    );
  }
}
