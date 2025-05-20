

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_controller.dart' as carousel_slider;
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
import 'package:tunasauctionv2/Model/SliderItem.dart';
import 'dart:convert';

import '../../Model/constant.dart';

class NewSliderWidget extends StatefulWidget {
  const NewSliderWidget({super.key});

  @override
  State<NewSliderWidget> createState() => _NewSliderWidgetState();
}

class _NewSliderWidgetState extends State<NewSliderWidget> {
  int _current = 0;
  final carousel_slider.CarouselController _controller = carousel_slider.CarouselController();
  List<SliderItem> sliderItems = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchSliderData();
  }

  Future<void> _fetchSliderData() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.tunasauctiondev.tunasgroup.com/v1/slider-management/slider-header'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          sliderItems = data.map((item) => SliderItem.fromJson(item)).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load slider data: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching slider data: $e';
        isLoading = false;
      });
    }
  }

  void onImageTap(int index) {
    final item = sliderItems[index];
    print('Gambar ke-$index di-tap');
    print('Link: ${item.link}');

    // Anda bisa menambahkan logika navigasi berdasarkan link
    if (item.link.startsWith('http')) {
      // Buka URL eksternal
      // context.push(item.link);
    } else if (item.link.isNotEmpty && item.link != '.') {
      // Navigasi ke route internal
      // context.push('/${item.link}');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildLoadingState();
    }

    if (errorMessage.isNotEmpty) {
      return _buildErrorState();
    }

    if (sliderItems.isEmpty) {
      return _buildEmptyState();
    }

    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: Stack(
            children: [
              CarouselSlider.builder(
                carouselController: _controller,
                itemCount: sliderItems.length,
                itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                  final item = sliderItems[itemIndex];
                  final imageUrl = item.imageApps ?? item.image;

                  return GestureDetector(
                    onTap: () => onImageTap(itemIndex),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AdaptiveTheme.of(context).mode.isDark == true
                              ? Colors.black87
                              : null,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(imageUrl),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height / 1,
                  aspectRatio: 1,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: MediaQuery.of(context).size.width >= 1100 ? true : false,
                  autoPlayInterval: const Duration(seconds: 10),
                  autoPlayAnimationDuration: const Duration(milliseconds: 1500),
                  autoPlayCurve: Curves.slowMiddle,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: sliderItems.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 12.0,
                        height: 12.0,
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(_current == entry.key ? 0.9 : 0.4),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  iconSize: 30,
                  onPressed: () {
                    _controller.previousPage();
                  },
                  icon: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: appColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(child: Icon(Icons.chevron_left)),
                  ),
                  color: Colors.white,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  iconSize: 30,
                  onPressed: () {
                    _controller.nextPage();
                  },
                  icon: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: appColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(child: Icon(Icons.chevron_right)),
                  ),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Container(
      height: MediaQuery.of(context).size.height / 1,
      color: Colors.grey[200],
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorState() {
    return Container(
      height: MediaQuery.of(context).size.height / 1,
      color: Colors.grey[200],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(errorMessage),
            ElevatedButton(
              onPressed: _fetchSliderData,
              child: Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: MediaQuery.of(context).size.height / 1,
      color: Colors.grey[200],
      child: Center(
        child: Text('No slider data available'),
      ),
    );
  }
}