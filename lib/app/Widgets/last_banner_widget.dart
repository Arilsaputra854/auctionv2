import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class LastBannerWidget extends StatefulWidget {
  const LastBannerWidget({super.key});

  @override
  State<LastBannerWidget> createState() => _LastBannerWidgetState();
}

class _LastBannerWidgetState extends State<LastBannerWidget> {
  bool isLoaded = true;
  String? banner1;

  getBanner() {
    setState(() {
      isLoaded = true;
    });

    // Gambar dari asset, misalkan path-nya ada di assets/images/
    List<String> banners = [
      'assets/image/slider_open_house1.png',
      'assets/image/slider_open_house2.png',
    ];

    Random random = Random();
    setState(() {
      banner1 = banners[random.nextInt(banners.length)];
      isLoaded = false;
    });
  }

  @override
  void initState() {
    getBanner();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1100
        ? Padding(
      padding: const EdgeInsets.only(left: 50, right: 50),
      child: SizedBox(
        height: MediaQuery.of(context).size.width >= 1100 ? 250 : 150,
        width: double.infinity,
        child: isLoaded == true
            ? Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: double.infinity,
            color: Colors.white,
          ),
        )
            : InkWell(
          onTap: () {
            context.go('/products/category1');
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                banner1!,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    )
        : SizedBox(
      height: 250,
      width: double.infinity,
      child: isLoaded == true
          ? Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: 300.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.white,
          ),
        ),
      )
          : InkWell(
        onTap: () {
          context.go('/products/category1');
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: SizedBox(
            height: double.infinity,
            width: 300,
            child: Image.asset(
              banner1!,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
