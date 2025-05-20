// ignore_for_file: avoid_print
import 'package:tunasauctionv2/app/Widgets/AuctionInfoWidget.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_controller.dart' as carousel_slider;
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tunasauctionv2/Model/cart_model.dart';
import 'package:tunasauctionv2/Model/formatter.dart';
import 'package:tunasauctionv2/Model/products_model.dart';
import 'package:tunasauctionv2/app/Widgets/cat_image_widget.dart';
import 'package:tunasauctionv2/app/Widgets/footer_widget.dart';
import 'package:tunasauctionv2/app/Widgets/review_widget.dart';
import 'package:tunasauctionv2/app/Widgets/share_to_social_media_widget.dart';
import 'package:tunasauctionv2/app/Widgets/similar_items_widget.dart';

import '../../Model/constant.dart';

class ProductDetailWebViewWidget extends StatefulWidget {
  final String productID;
  const ProductDetailWebViewWidget({super.key, required this.productID});

  @override
  State<ProductDetailWebViewWidget> createState() =>
      _ProductDetailWebViewWidgetState();
}

class _ProductDetailWebViewWidgetState
    extends State<ProductDetailWebViewWidget> {

  Widget _buildDetailRow(String label, String value) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(2),
      },
      children: [
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('$label :', style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(value, textAlign: TextAlign.end),
            ),
          ],
        ),
      ],
    );
  }
  ProductsModel? productsModel;
  int current = 0;
  num quantity = 1;
  String currency = '';
  List<String> images = [];
  bool isFavorite = false;
  int selectedValue = 1;
  num selectedPrice = 0;
  num price = 0;
  int selectedTab = 1;
  String selectedProduct = '';
  // final CarouselController _controller = CarouselController();
  final carousel_slider.CarouselController _controller = carousel_slider.CarouselController();

  bool isLoading = true;
  getProductDetail() {
    context.loaderOverlay.show();
    setState(() {
      isLoading = true;
    });
    FirebaseFirestore.instance
        .collection('Products')
        .doc(widget.productID)
        .get()
        .then((event) {
      if (event.exists) {
        context.loaderOverlay.hide();
        setState(() {
          isLoading = false;
          var prod = ProductsModel.fromMap(event.data(), event.id);
          productsModel = prod;
        });
      } else {
        FirebaseFirestore.instance
            .collection('Flash Sales')
            .doc(widget.productID)
            .get()
            .then((event) {
          if (event.exists) {
            context.loaderOverlay.hide();
            setState(() {
              isLoading = false;
              var prod = ProductsModel.fromMap(event.data(), event.id);
              productsModel = prod;
            });
          } else {
            FirebaseFirestore.instance
                .collection('Hot Deals')
                .doc(widget.productID)
                .get()
                .then((event) {
              if (event.exists) {
                context.loaderOverlay.hide();
                setState(() {
                  isLoading = false;
                  var prod = ProductsModel.fromMap(event.data(), event.id);
                  productsModel = prod;
                });
              }
            });
          }
        });
      }
    });
  }

  @override
  void initState() {
    getProductDetail();
    //  getFavorite();
    getAuth();
    getCurrency();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ProductDetailWebViewWidget oldWidget) {
    getProductDetail();
    //  getFavorite();
    getAuth();
    getCurrency();
    getCurrency();
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    super.didUpdateWidget(oldWidget);
  }

  getCurrency() {
    FirebaseFirestore.instance
        .collection('Currency Settings')
        .doc('Currency Settings')
        .get()
        .then((value) {
      setState(() {
        currency = value['Currency symbol'];
      });
    });
  }

  addToFavorite(ProductsModel productsModel) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('Favorites')
        .doc(productsModel.productID)
        .set(productsModel.toMap())
        .then((val) {
      Fluttertoast.showToast(
          msg: "Product has been added to your favorites",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
    });
  }

  removeFromFavorite() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('Favorites')
        .doc(productsModel!.productID)
        .delete()
        .then((val) {
      Fluttertoast.showToast(
          msg: "Product has been removed from your favorites",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
    });
  }

  List<String> favorites = [];
  List<String> initFavorite = [];
  getFavorite() {
    List<String> cartsMain = [];
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('Favorites')
        .snapshots()
        .listen((event) {
      favorites.clear();
      for (var element in event.docs) {
        cartsMain.add(element['productID']);
        setState(() {
          favorites = cartsMain;
          initFavorite = favorites;
        });
      }
    });
  }

  bool isLogged = false;
  getAuth() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        setState(() {
          isLogged = false;
        });
      } else {
        setState(() {
          isLogged = true;
        });
        // getCart();
        // getFullName();
        getFavorite();
      }
    });
  }

  addToCart(CartModel productsModel) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('Cart')
        .doc('${productsModel.name}${getSelectedProduct()}')
        .set(productsModel.toMap())
        .then((val) {
      Fluttertoast.showToast(
          msg: "Product has been added to your cart",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).primaryColor,
          textColor: Colors.white,
          fontSize: 14.0);
    });
  }

  getSelectedProduct() {
    if (selectedProduct == '') {
      return productsModel!.unitname1;
    } else {
      return selectedProduct;
    }
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    if (isLoading == false) {
      List<String> imagesValue = [
        productsModel!.image1,
        productsModel!.image2 == ''
            ? productsModel!.image1
            : productsModel!.image2,
        productsModel!.image3 == ''
            ? productsModel!.image1
            : productsModel!.image3,
      ];
      images = imagesValue;
    }
    return Scaffold(
      backgroundColor: AdaptiveTheme.of(context).mode.isDark == true
          ? null
          : const Color.fromARGB(255, 247, 240, 240),
      body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              if (isLoading == true) const Gap(50),
              isLoading == true
                  ? Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 8,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: double
                                .infinity, // Set the width as needed
                            height: 400.0, // Set the height as needed
                            color: Colors.grey, // Set the color as needed
                          ),
                        )),
                    const Gap(40),
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: 200,
                                height: 15,
                                color: Colors
                                    .grey,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: 300,
                                height: 14,
                                color: Colors
                                    .grey,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: 400, // Set the width as needed
                                height: 15, // Set the height as needed
                                color: Colors
                                    .grey, // Set the color as needed
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: 250, // Set the width as needed
                                height: 15, // Set the height as needed
                                color: Colors
                                    .grey, // Set the color as needed
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: 290, // Set the width as needed
                                height: 15, // Set the height as needed
                                color: Colors
                                    .grey, // Set the color as needed
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
                  : Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(20),
                    Row(
                      children: [
                        const Gap(10),
                        InkWell(
                          onTap: () {
                            context.go('/');
                          },
                          child: const Text(
                            'Home',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            context.go(
                                '/products/${productsModel!.category}');
                          },
                          child: Text(
                            ' / ${productsModel!.category}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            context.go(
                                '/collection/${productsModel!.collection}');
                          },
                          child: Text(
                            ' / ${productsModel!.collection}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        Text(
                          ' / ${productsModel!.subCollection}',
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Gap(30),
                    Card(
                      shape: const BeveledRectangleBorder(),
                      elevation: 0.5,
                      color: AdaptiveTheme.of(context).mode.isDark == true
                          ? Colors.black
                          : Colors.white,
                      surfaceTintColor: Colors.white,
                      child: SizedBox(
                        width: double.infinity,
                        //  height: 500,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(10),
                            Expanded(
                                flex: 3,
                                child: Column(
                                  children: [
                                    const Gap(10),
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
                                          child: CarouselSlider.builder(
                                              carouselController:
                                              _controller,
                                              itemCount: images.length,
                                              itemBuilder: (_, index,
                                                  int pageViewIndex) {
                                                return CatImageWidget(
                                                    url: images[index],
                                                    boxFit: 'cover');
                                              },
                                              options: CarouselOptions(
                                                  onPageChanged:
                                                      (index, reason) {
                                                    setState(() {
                                                      current = index;
                                                    });
                                                  },
                                                  enlargeCenterPage: true,
                                                  aspectRatio: 0.8,
                                                  autoPlay: true,
                                                  height: MediaQuery.of(
                                                      context)
                                                      .size
                                                      .height /
                                                      1.5)),
                                        ),
                                        Align(
                                            alignment:
                                            Alignment.centerLeft,
                                            child: IconButton(
                                              iconSize: 40,
                                              onPressed: () {
                                                _controller
                                                    .previousPage();
                                              },
                                              icon: Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration:
                                                  BoxDecoration(
                                                    color: Colors.grey
                                                        .withOpacity(0.4),
                                                    shape:
                                                    BoxShape.circle,
                                                  ),
                                                  child: const Center(
                                                      child: Icon(Icons
                                                          .chevron_left))),
                                              color: Colors.white,
                                            )),
                                        Align(
                                            alignment:
                                            Alignment.centerRight,
                                            child: IconButton(
                                              iconSize: 40,
                                              onPressed: () {
                                                _controller.nextPage();
                                              },
                                              icon: Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration:
                                                  BoxDecoration(
                                                    color: Colors.grey
                                                        .withOpacity(0.4),
                                                    shape:
                                                    BoxShape.circle,
                                                  ),
                                                  child: const Center(
                                                      child: Icon(Icons
                                                          .chevron_right))),
                                              color: Colors.white,
                                            )),
                                      ],
                                    ),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.remove_red_eye_outlined, size: 16),
                                        const Gap(5),
                                        const Text('Dilihat: 5'),
                                        const Gap(10),
                                        const Icon(Icons.favorite, size: 16),
                                        const Gap(5),
                                        const Text('Difavoritkan: 5'),
                                        const Gap(10),
                                        const Icon(Icons.share, size: 16),
                                        const Gap(5),
                                        const Text('Di share: 5'),
                                      ],
                                    ),
                                    const Gap(10),
                                  ],
                                )),

                            //
                            const Gap(50),

                            Expanded(
                                flex: 3,
                                child: SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      const Gap(20),
                                      Text(
                                        productsModel!.name,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const Gap(10),
                                      const Divider(
                                          color: Color.fromARGB(
                                              255, 243, 236, 236)),
                                      const Gap(10),
                                      Row(
                                        children: [
                                          Text(
                                            '$currency${Formatter().converter(productsModel!.unitPrice1.toDouble())}',
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                          const Gap(5),

                                          const Gap(5),
                                          productsModel!
                                              .percantageDiscount ==
                                              0
                                              ? const SizedBox.shrink()
                                              : Padding(
                                            padding:
                                            const EdgeInsets
                                                .only(right: 8),
                                            child: Container(
                                                color: appColor,
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .all(3.0),
                                                  child: Text(
                                                    // '-${productsModel!.percantageDiscount}%',
                                                    'OPEN',
                                                    style:
                                                    const TextStyle(
                                                      color: Colors
                                                          .white,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                )),
                                          )
                                        ],
                                      ),
                                      const Gap(5),

                                      const Gap(5),

                                      const Gap(10),
                                      const Divider(
                                          color: Color.fromARGB(
                                              255, 243, 236, 236)),
                                      const Gap(10),
                                      const Text(
                                        'LOT : 1',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Gap(10),

                                      const Gap(20),
                                      // const Gap(10),
                                      const Divider(
                                          color: Color.fromARGB(
                                              255, 243, 236, 236)),
                                      const Gap(10),
                                      Row(
                                        children: [

                                        ],
                                      ),
                                      const Gap(20),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: ElevatedButton(
                                                style: ElevatedButton
                                                    .styleFrom(
                                                    shape:
                                                    const BeveledRectangleBorder(),
                                                    backgroundColor:
                                                    Colors
                                                        .orange),
                                                onPressed: () {
                                                  if (isLogged == false) {
                                                    context.go('/login');
                                                  } else {
                                                    addToCart(CartModel(
                                                        vendorName:
                                                        productsModel!
                                                            .vendorName,
                                                        returnDuration:
                                                        productsModel!
                                                            .returnDuration,
                                                        totalNumberOfUserRating:
                                                        productsModel!
                                                            .totalNumberOfUserRating,
                                                        totalRating:
                                                        productsModel!
                                                            .totalRating,
                                                        productID:
                                                        productsModel!
                                                            .productID,
                                                        price: selectedPrice == 0
                                                            ? (productsModel!.unitPrice1) *
                                                            quantity
                                                            : (selectedPrice *
                                                            quantity),
                                                        selectedPrice: selectedPrice == 0
                                                            ? productsModel!
                                                            .unitPrice1
                                                            : selectedPrice,
                                                        quantity: quantity
                                                            .toInt(),
                                                        selected: selectedProduct == ''
                                                            ? productsModel!
                                                            .unitname1
                                                            : selectedProduct,
                                                        description:
                                                        productsModel!
                                                            .description,
                                                        // marketID: '',
                                                        // marketName: productsModel!
                                                        //     .marketName,
                                                        uid: productsModel!
                                                            .uid,
                                                        name: productsModel!
                                                            .name,
                                                        category:
                                                        productsModel!
                                                            .category,
                                                        subCollection:
                                                        productsModel!
                                                            .subCollection,
                                                        collection:
                                                        productsModel!
                                                            .collection,
                                                        image1: productsModel!.image1,
                                                        image2: productsModel!.image2,
                                                        image3: productsModel!.image3,
                                                        unitname1: productsModel!.unitname1,
                                                        unitname2: productsModel!.unitname2,
                                                        unitname3: productsModel!.unitname3,
                                                        unitname4: productsModel!.unitname4,
                                                        unitname5: productsModel!.unitname5,
                                                        unitname6: productsModel!.unitname6,
                                                        unitname7: productsModel!.unitname7,
                                                        unitPrice1: productsModel!.unitPrice1,
                                                        unitPrice2: productsModel!.unitPrice2,
                                                        unitPrice3: productsModel!.unitPrice3,
                                                        unitPrice4: productsModel!.unitPrice4,
                                                        unitPrice5: productsModel!.unitPrice5,
                                                        unitPrice6: productsModel!.unitPrice6,
                                                        unitPrice7: productsModel!.unitPrice7,
                                                        unitOldPrice1: productsModel!.unitOldPrice1,
                                                        unitOldPrice2: productsModel!.unitOldPrice2,
                                                        unitOldPrice3: productsModel!.unitOldPrice3,
                                                        unitOldPrice4: productsModel!.unitOldPrice4,
                                                        unitOldPrice5: productsModel!.unitOldPrice5,
                                                        unitOldPrice6: productsModel!.unitOldPrice6,
                                                        unitOldPrice7: productsModel!.unitOldPrice7,
                                                        percantageDiscount: productsModel!.percantageDiscount,
                                                        vendorId: productsModel!.vendorId,
                                                        brand: productsModel!.brand));
                                                  }
                                                },
                                                child: const Text(
                                                  'Bandingkan',
                                                  style: TextStyle(
                                                      color:
                                                      Colors.white),
                                                )),
                                          ),
                                          const Gap(20),
                                          Expanded(
                                            flex: 3,
                                            child: Row(
                                              children: [
                                                favorites.contains(
                                                    productsModel!
                                                        .productID) ==
                                                    false
                                                    ? InkWell(
                                                  onTap: () {
                                                    if (isLogged ==
                                                        false) {
                                                      context.go(
                                                          '/login');
                                                    } else {
                                                      addToFavorite(
                                                          productsModel!);
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 35,
                                                    width: 35,
                                                    decoration: const BoxDecoration(
                                                        shape: BoxShape
                                                            .circle,
                                                        color: Colors
                                                            .grey),
                                                    child:
                                                    const Center(
                                                      child: Icon(
                                                        Icons
                                                            .favorite,
                                                        color: Colors
                                                            .white,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                                    : InkWell(
                                                  onTap: () {
                                                    if (isLogged ==
                                                        false) {
                                                      context.go(
                                                          '/login');
                                                    } else {
                                                      removeFromFavorite();
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 35,
                                                    width: 35,
                                                    decoration: const BoxDecoration(
                                                        shape: BoxShape
                                                            .circle,
                                                        color: Colors
                                                            .orange),
                                                    child:
                                                    const Center(
                                                      child: Icon(
                                                        Icons
                                                            .favorite,
                                                        color: Colors
                                                            .white,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const Gap(10),
                                                const Text(
                                                  'Save for later',
                                                  style: TextStyle(
                                                      fontSize: 12),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      const Gap(10),
                                      const Divider(
                                          color: Color.fromARGB(
                                              255, 243, 236, 236)),
                                      const Gap(10),
                                      ShareToSocials(
                                          productID:
                                          productsModel!.productID),
                                      const Gap(15),

                                      const Gap(30),
                                    ],
                                  ),
                                )),
                            const Gap(10),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(20),

              if (isLoading == false) const Gap(20),
              if (isLoading == false)
              // Add Auction Information widget
                AuctionInfoWidget(
                  basePrice: 'Rp. 100.000.000',
                  auctionLocation: 'Bekasi',
                  auctionDate: '12-07-2025',
                  adminFee: 'Rp. 3.000.000',
                  ppnFee: 'Rp. 1.100.000',
                  additionalCost: 'Rp. 200.000',
                  totalEstimate: 'Rp. 104.300.000',
                  physicalInfo: {
                    'nopol': 'B-XXXX-DDD',
                    'rangka': 'FSNDFSLINFJZD',
                    'mesin': 'FSNDFSLINFJZD',
                    'lokasi': 'BEKASI',
                  },
                  documentInfo: {
                    'stnk': 'ADA',
                    'pajak': '12-08-2026',
                    'bpkb': 'READY',
                    'faktur': 'T/A',
                    'keur': 'T/A',
                    'sph': 'T/A',
                  },
                  contactInfo: {
                    'pic1': '08XX-XXXX-XXXX',
                    'pic2': '08XX-XXXX-XXXX',
                  },
                  notes: 'Unit Derek, Ex BBN, Ex Ganti Nopol, Part Mesin Tidak Lengkap, Repaint, Tdk Ikut Lelang Wajib Datang House Call Mengetahui Kondisi Unit, Pemenang lelang dikenakan biaya sebesar 2,5 dan harga terbentuk',
                ),
              if (isLoading == false) const Gap(20),
              if (isLoading == false)
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: Row(
                    children: [
                      const Text(
                        'Product Terkait',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              const Gap(10),
              if (isLoading == false)
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: SimilarItemsWidget(
                    productID: productsModel!.productID,
                    category: productsModel!.category,
                  ),
                ),
              const Gap(50),
              const FooterWidget()
            ],
          )),
    );
  }
}