import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tunasauctionv2/Model/user.dart';
import 'package:tunasauctionv2/app/Widgets/vendor_widget_main.dart';

class VendorMobileHomeWidget extends StatefulWidget {
  const VendorMobileHomeWidget({super.key});

  @override
  State<VendorMobileHomeWidget> createState() => _VendorMobileHomeWidgetState();
}

class _VendorMobileHomeWidgetState extends State<VendorMobileHomeWidget> {
  List<UserModel> products = [];
  // List<ProductsModel> productsFilter = [];
  bool isLoaded = true;

  getProducts() async {
    setState(() {
      isLoaded = true;
    });
    context.loaderOverlay.show();
    FirebaseFirestore.instance
        .collection('vendors')
        .where('approval', isEqualTo: true)
        .limit(5)
        .snapshots()
        .listen((event) {
      setState(() {
        isLoaded = false;
      });
      context.loaderOverlay.hide();
      products.clear();
      for (var element in event.docs) {
        // var prods = UserModel.fromMap(element.data(), element.id);
        setState(() {
          // products.add(prods);
        });
      }
    });
  }

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).size.width >= 1100
          ? const EdgeInsets.only(left: 50, right: 50)
          : const EdgeInsets.all(0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Vendors',
                  style: TextStyle(
                      // color: Colors.white,
                      fontFamily: 'LilitaOne',
                      // fontWeight: FontWeight.bold,
                      fontSize:
                          MediaQuery.of(context).size.width >= 1100 ? 30 : 20),
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: CountdownTimer(
              //     textStyle: TextStyle(
              //         fontWeight: FontWeight.bold,
              //         fontSize: MediaQuery.of(context).size.width >= 1100
              //             ? 18
              //             : 15),
              //     endTime:
              //         DateTime.parse(flashSales).millisecondsSinceEpoch,
              //     onEnd: () {
              //       // FirebaseFirestore.instance
              //       //     .collection('Flash Sales Products')
              //       //     .doc(productModel.uid)
              //       //     .delete();
              //       deleteAllDocumentsInCollection('Flash Sales');
              //     },
              //   ),
              // ),
              Padding(
                padding: MediaQuery.of(context).size.width >= 1100
                    ? const EdgeInsets.all(0)
                    : const EdgeInsets.all(8.0),
                child: Center(
                  child: OutlinedButton(
                    onPressed: () {
                      context.go('/vendors');
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AdaptiveTheme.of(context).mode.isDark == true
                              ? Colors.white
                              : Colors.black,
                          fontSize: MediaQuery.of(context).size.width >= 1100
                              ? 15
                              : 12),
                    ),
                  ),
                ),
              ),
            ],
          ),
          isLoaded == true
              ? Card(
                  semanticContainer: false,
                  shape: const Border.fromBorderSide(BorderSide.none),
                  color: MediaQuery.of(context).size.width >= 1100
                      ? Colors.white
                      : null,
                  elevation:
                      MediaQuery.of(context).size.width >= 1100 ? 0.5 : null,
                  child: SizedBox(
                    height: 200,
                    //   width: double.infinity,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 170.0,
                            height: double.infinity,
                            margin: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              : SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Padding(
                    padding: MediaQuery.of(context).size.width >= 1100
                        ? const EdgeInsets.only(left: 50, right: 50)
                        : const EdgeInsets.all(0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        UserModel productsModel = products[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              height: 200,
                              width: 300,
                              child: VendorWidgetMain(
                                fromHome: true,
                                  productsModel: productsModel)),
                        );
                      },
                    ),
                  ))
        ],
      ),
    );
  }
}
