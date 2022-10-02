import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yamaiter/common/constants/assets_constants.dart';
import 'package:yamaiter/common/screen_utils/screen_util.dart';
import 'package:yamaiter/presentation/themes/theme_color.dart';

import '../../../domain/entities/data/ad_entity.dart';

class AdsListViewWidget extends StatelessWidget {
  final List<AdEntity> adsList;
  const AdsListViewWidget({Key? key, required this.adsList}) : super(key: key);

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
        autoPlayInterval: Duration(seconds: 5),
        autoPlayAnimationDuration: Duration(milliseconds: 2000),
        autoPlayCurve: Curves.fastOutSlowIn,
        // enlargeCenterPage: true,
        //onPageChanged: callbackFunction,
        scrollDirection: Axis.horizontal,
      ),
      items: adsList.map((singleAd) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              //width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 3.0),
              color: AppColor.deepOrange,
              child: Image.asset(
                singleAd.url,
                fit: BoxFit.cover,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
