import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tunasauctionv2/Model/cart_model.dart';
import 'package:tunasauctionv2/Model/formatter.dart';
import 'package:tunasauctionv2/Model/products_model.dart';
import 'package:tunasauctionv2/app/Widgets/cat_image_widget.dart';
import '../../Model/constant.dart';

class ProductWidgetMain extends StatefulWidget {
  final ProductsModel productsModel;
  const ProductWidgetMain({super.key, required this.productsModel});

  @override
  State<ProductWidgetMain> createState() => _ProductWidgetMainState();
}

class _ProductWidgetMainState extends State<ProductWidgetMain> {
  String currency = 'Rp. ';
  @override
  void initState() {
    getCurrency();
    getAuth();
    super.initState();
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

  bool isLogged = false;
  getAuth() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        setState(() {
          isLogged = false;
          carts.clear();
          favorites.clear();
        });
      } else {
        setState(() {
          isLogged = true;
        });
        getFavorites();
        getCarts();
      }
    });
  }

  addToFavorite(ProductsModel productsModel) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('Favorites')
        .doc(widget.productsModel.productID)
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
        .doc(widget.productsModel.productID)
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
  getFavorites() {
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

  void resetToInitialList() {
    setState(() {
      favorites = List.from(initFavorite);
    });
  }

  addToCart(CartModel productsModel) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('Cart')
        .doc('${productsModel.name}${productsModel.unitname1}')
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

  List<String> carts = [];
  getCarts() {
    List<String> cartsMain = [];
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('Cart')
        .snapshots()
        .listen((event) {
      carts.clear();
      for (var element in event.docs) {
        cartsMain.add(element['productID']);
        setState(() {
          carts = cartsMain;
        });
      }
    });
  }

  Future<void> deleteCart(
      String id, String productname, String selectedUnit) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;
    firestore
        .collection('users')
        .doc(user!.uid)
        .collection('Cart')
        .doc('$productname$selectedUnit')
        .delete()
        .then((value) {
      setState(() {
        carts.remove(id);
      });

      const SnackBar(
        content: Text('Product has been removed'),
      );
    });
  }

  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.go('/product-detail/${widget.productsModel.uid}');
      },
      onHover: (value) {
        setState(() {
          isHovered = value;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: AdaptiveTheme.of(context).mode.isDark == true
              ? Colors.black87
              : Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                // Car Image
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: MediaQuery.of(context).size.width >= 1100
                            ? CatImageWidget(
                          url: widget.productsModel.image1,
                          boxFit: 'cover',
                        )
                            : Image.network(
                          widget.productsModel.image1,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: FadeIn(
                        duration: const Duration(milliseconds: 100),
                        animate: isHovered,
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          width: double.infinity,
                          child: InkWell(
                            onTap: () {
                              context.go(
                                  '/product-detail/${widget.productsModel.uid}');
                            },
                            child: const Icon(
                              Icons.visibility,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                // Lot Number Badge
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Lot A001',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Grade Badge
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Grade B',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Favorite Button
                favorites.contains(widget.productsModel.productID) == true
                    ? (isHovered == false &&
                    MediaQuery.of(context).size.width >= 1100)
                    ? const SizedBox.shrink()
                    : Align(
                  alignment: Alignment.topRight,
                  child: SlideInRight(
                    duration: const Duration(milliseconds: 500),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          removeFromFavorite();
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.favorite,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                    : (isHovered == false &&
                    MediaQuery.of(context).size.width >= 1100)
                    ? const SizedBox.shrink()
                    : Align(
                  alignment: Alignment.topRight,
                  child: SlideInRight(
                    duration: const Duration(milliseconds: 500),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          if (isLogged == false) {
                            context.go('/login');
                          } else {
                            addToFavorite(widget.productsModel);
                          }
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.blue,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Car Info Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Car Name
                  Text(
                    'Toyota Avanza 1.5 MT',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Tahun 2021',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Car Details
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Price
                      Row(
                        children: [
                          Text(
                            'Harga',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'Rp. 145.000.000',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      // Nopol
                      Row(
                        children: [
                          Text(
                            'Nopol',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'B-9758-KME',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      // Jadwal
                      Row(
                        children: [
                          Text(
                            'Jadwal',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '25 Februari 2025',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      // Lokasi
                      Row(
                        children: [
                          Text(
                            'Lokasi',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'Bekasi',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Compare Button
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(double.infinity, 44),
                ),
                onPressed: () {
                  if (isLogged == false) {
                    context.go('/login');
                  } else {
                    // Handle comparison logic
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Tertarik dengan unit ini?',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(
                        Icons.chat,
                        size: 16,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}