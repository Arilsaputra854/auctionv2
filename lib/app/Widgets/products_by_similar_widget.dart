import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_controller.dart' as carousel_slider;
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
import 'package:flutter/material.dart' hide CarouselController;

import 'package:go_router/go_router.dart';
import 'package:tunasauctionv2/Model/products_model.dart';
import 'product_widget_main.dart';

class ProductsBySimilarWidget extends StatefulWidget {
  final String cat;
  final String productID;
  const ProductsBySimilarWidget(
      {super.key, required this.cat, required this.productID});

  @override
  State<ProductsBySimilarWidget> createState() =>
      _ProductsBySimilarWidgetState();
}

class _ProductsBySimilarWidgetState extends State<ProductsBySimilarWidget> {
  List<ProductsModel> products = [];
  // List<ProductsModel> productsFilter = [];
  bool isLoaded = false;

  getProducts() async {
    setState(() {
      isLoaded = true;
    });
    FirebaseFirestore.instance
        .collection('Products')
        .where('category', isEqualTo: widget.cat)
        .where('productID', isNotEqualTo: widget.productID)
        .limit(7)
        .snapshots()
        .listen((event) {
      setState(() {
        isLoaded = false;
      });
      products.clear();
      for (var element in event.docs) {
        var prods = ProductsModel.fromMap(element, element.id);
        setState(() {
          products.add(prods);
        });
      }
    });
  }

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  int current = 0;
  // final CarouselController _controller = CarouselController();
  final carousel_slider.CarouselController _controller = carousel_slider.CarouselController();

  bool isHovered = false;
  bool isLast = true;
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print('cat is ${widget.cat}');
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 370,
            width: double.infinity,
            child: CarouselSlider.builder(
              carouselController: _controller,
              itemCount: products.length,
              itemBuilder: (_, index, int pageViewIndex) {
                ProductsModel productsModel = products[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () {
                        context.go('/product-detail/${productsModel.uid}');
                      },
                      child: ProductWidgetMain(productsModel: productsModel)),
                );
              },
              options: CarouselOptions(
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  initialPage: 0,
                  disableCenter: true,
                  enableInfiniteScroll: false,
                  viewportFraction: MediaQuery.of(context).size.width >= 1100
                      ? 0.18
                      : MediaQuery.of(context).size.width > 600 &&
                              MediaQuery.of(context).size.width < 1200
                          ? 0.3
                          : 0.45,
                  padEnds: false,
                  aspectRatio: 0.8,
                  reverse: false,
                  autoPlay: false,
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayAnimationDuration:
                      const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: false,
                  // onPageChanged: callbackFunction,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      current = index;
                      // ignore: avoid_print
                      print('current is $current');
                    });
                    if (index == 5) {
                      setState(() {
                        isLast = false;
                      });
                    } else {
                      setState(() {
                        isLast = true;
                      });
                    }
                  }),
            ),
          ),
          if (MediaQuery.of(context).size.width >= 1100)
            isHovered == false
                ? const SizedBox.shrink()
                : current == 0
                    ? const SizedBox.shrink()
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              _controller.previousPage();
                            },
                            child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.9),
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                    child: Icon(
                                  Icons.chevron_left,
                                  color: Colors.white,
                                ))),
                          ),
                        )),
          if (MediaQuery.of(context).size.width >= 1100)
            isHovered == false
                ? const SizedBox.shrink()
                : Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          _controller.nextPage();
                        },
                        child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.9),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                                child: Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                            ))),
                      ),
                    )),
          if (MediaQuery.of(context).size.width <= 1100)
            current == 0
                ? const SizedBox.shrink()
                : Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          _controller.previousPage();
                        },
                        child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.9),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                                child: Icon(
                              Icons.chevron_left,
                              color: Colors.white,
                            ))),
                      ),
                    )),
          if (MediaQuery.of(context).size.width <= 1100)
            Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      _controller.nextPage();
                    },
                    child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                            child: Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                        ))),
                  ),
                )),
        ],
      ),
    );
  }
}
