import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yamaiter/common/constants/assets_constants.dart';
import 'package:yamaiter/common/enum/ad_status.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';
import 'package:yamaiter/presentation/widgets/cached_image_widget.dart';

import '../../../common/functions/open_url.dart';
import '../../../domain/entities/data/ad_entity.dart';

class AdsListViewWidget extends StatelessWidget {
  final List<AdEntity> adsList;

  const AdsListViewWidget({
    Key? key,
    required this.adsList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: ScreenUtil.screenHeight * 0.15,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 2000),
        autoPlayCurve: Curves.fastOutSlowIn,
        // enlargeCenterPage: true,
        //onPageChanged: callbackFunction,
        scrollDirection: Axis.horizontal,
      ),
      items: adsList.map((singleAd) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                openUrl(url: singleAd.url);
              },
              child: Container(
                //width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 3.0),
                //color: AppColor.deepOrange,
                child: CachedImageWidget(
                  imageUrl: singleAd.image,
                  height: ScreenUtil.screenHeight * 0.15,
                  width: double.infinity,
                  progressBarScale: 0.1,
                  isCircle: false,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
