// ignore_for_file: avoid_print

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:tunasauctionv2/Model/formatter.dart';
import 'package:tunasauctionv2/Model/menu_model.dart';
import 'package:tunasauctionv2/Providers/auth.dart';
import 'package:tunasauctionv2/app/Widgets/cart_widget.dart';
import 'package:tunasauctionv2/app/Widgets/cats_tabs.dart';
import 'package:tunasauctionv2/app/Widgets/login_form_widget.dart';
import 'package:tunasauctionv2/app/Widgets/mobile_menu.dart';
import 'package:tunasauctionv2/app/Widgets/search_widget.dart';
import '../../Model/categories.dart';
import '../../Model/constant.dart';
import 'cat_image_widget.dart';
import 'collections_expanded_tile.dart';
import 'language_widget.dart';
// ignore: library_prefixes
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as modalSheet;

class ScaffoldWidget extends StatefulWidget {
  final Widget body;
  final String path;
  const ScaffoldWidget({super.key, required this.body, required this.path});

  @override
  State<ScaffoldWidget> createState() => _ScaffoldWidgetState();
}

class _ScaffoldWidgetState extends State<ScaffoldWidget> {
  List<String> categories = [];
  num cartQuantity = 0;
  bool loaded = false;
  String? selectedValue;
  bool isLogged = false;
  String fullname = '';
  num price = 0;
  String currency = '';

  late AuthService authService;

  getFullName() {
    fullname = authService.currentUser!.name;
    // final FirebaseAuth auth = FirebaseAuth.instance;
    // User? user = auth.currentUser;
    // FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(user!.uid)
    //     .snapshots()
    //     .listen((event) {
    //   setState(() {
    //     fullname =
    //         event['fullname'].substring(0, event['fullname'].indexOf(" "));
    //   });
    //   //  print('Fullname is $fullName');
    // });
  }

  getCart() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;
    firestore
        .collection('users')
        .doc(user!.uid)
        .collection('Cart')
        .snapshots()
        .listen((val) {
      num tempTotal =
          val.docs.fold(0, (tot, doc) => tot + doc.data()['quantity']);
      num totalPrice =
          val.docs.fold(0, (tot, doc) => tot + doc.data()['price']);
      setState(() {
        cartQuantity = tempTotal;
        price = totalPrice;
      });
    });
  }

  getCategoriesTabs() {
    setState(() {
      loaded = false;
    });
    context.loaderOverlay.show();
    List<String> dataMain = [
      // "Home", "View All Categories"
    ];
    FirebaseFirestore.instance
        .collection('Categories')
        // .limit()
        .snapshots()
        .listen((event) {
      for (var element in event.docs) {
        context.loaderOverlay.hide();
        setState(() {
          loaded = true;
        });
        dataMain.add(element['category']);
        setState(() {
          categories = dataMain;
        });
      }
    });
  }

  openDrawerHome() {
    _scaffoldHome.currentState!.openDrawer();
  }

  final GlobalKey<ScaffoldState> _scaffoldHome = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    authService = context.read<AuthService>();
    getCategoriesTabs();
    getAllCats();

    getCats();
    // _retrieveToken();
    getCurrency();
    //getToken();
    getAuth();
    super.initState();
  }

  bool isVerified = false;
  getAuth() {
    if (authService.currentUser == null) {
      setState(() {
        isLogged = false;
        cartQuantity = 0;
        price = 0;
      });
    } else {
      setState(() {
        isLogged = true;
      });
      //getCart();
      getFullName();
    }

    // FirebaseAuth.instance.authStateChanges().listen((User? user) async {
    //   if (user == null) {
    //     setState(() {
    //       isLogged = false;
    //       cartQuantity = 0;
    //       price = 0;
    //     });
    //   } else {
    //     setState(() {
    //       isLogged = true;
    //     });
    //     getCart();
    //     getFullName();
    //   }
    // });
  }

  List<CategoriesModel> cats = [];
  getCats() {
    return FirebaseFirestore.instance
        .collection('Categories')
        .snapshots()
        .listen((value) {
      cats.clear();
      for (var element in value.docs) {
        setState(() {
          var fetchServices =
              CategoriesModel.fromMap(element.data(), element.id);
          cats.add(fetchServices);
        });
      }
    });
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

  int currentIndex = 1;

  moveToOrder() {
    setState(() {
      context.go('/orders');
      currentIndex = 3;
      context.pop();
    });
  }

  List<CategoriesModel> allCats = [];
  bool isLoading = false;
  getAllCats() {
    setState(() {
      isLoading = true;
    });
    List<CategoriesModel> categories = [];
    return FirebaseFirestore.instance
        .collection('Categories')
        .snapshots()
        .listen((value) {
      setState(() {
        isLoading = false;
      });
      allCats.clear();
      for (var element in value.docs) {
        setState(() {
          var fetchServices =
              CategoriesModel.fromMap(element.data(), element.id);
          categories.add(fetchServices);
          allCats = categories;
          //  cats.add(CategoriesModel(category: "View All", image: ''));
        });
      }
    });
  }

  showBottomSheetTab() {
    modalSheet.showBarModalBottomSheet(
        expand: true,
        bounce: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const Gap(20),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: const Text(
                            'Categories',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const Gap(10),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: allCats.length,
                        itemBuilder: (context, index) {
                          CategoriesModel categoriesModel = allCats[index];
                          return ExpansionTile(
                            leading: SizedBox(
                              height: 50,
                              width: 50,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: CatImageWidget(
                                    url: categoriesModel.image,
                                    boxFit: 'cover',
                                  ),
                                ),
                              ),
                            ),
                            title: Text(categoriesModel.category),
                            children: [
                              CollectionsExpandedTile(
                                cat: categoriesModel.category,
                              )
                            ],
                          );
                        }),
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    print(
        'ScaffoldWidget parameters - body: ${widget.body}, path: ${widget.path}');
    //print('Path is ${widget.path}');
    String hi = 'Hi';
    String account = 'Account';
    String items = 'items';
    return Scaffold(
      bottomNavigationBar: MediaQuery.of(context).size.width >= 1100
          ? null
          : BottomNavigationBar(
              selectedItemColor: appColor,
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              onTap: (index) {
                if (index == 0) {
                  context.go('/');
                  currentIndex = index;
                } else if (index == 1) {
                  context.go('/products-all-category');
                  currentIndex = index;
                } else if (index == 2) {
                  // Tambahkan navigasi ke halaman Jadwal Lelang
                  context.go(
                      '/flash-sales'); // pastikan rute untuk jadwal lelang ada
                  currentIndex = index;
                } else if (index == 3) {
                  context.go(
                      '/live-auction-all'); // pastikan rute live auction ada
                  currentIndex = index;
                } else if (index == 4) {
                  // context.go('/profile'); // pastikan rute live auction ada
                  // currentIndex = index;
                  openDrawerHome();
                }
              },
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.event),
                  label: 'Open House',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.calendar_today),
                  label: 'Jadwal Lelang',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.gavel),
                  label: 'Live Auction',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.person_2_outlined),
                  label: 'Profile',
                ),
              ],
            ),
      key: _scaffoldHome,
      endDrawer: Drawer(
        shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.zero)),
        width: MediaQuery.of(context).size.width >= 1100
            ? MediaQuery.of(context).size.width / 3
            : double.infinity,
        child: const CartWidget(),
      ),
      drawer: MediaQuery.of(context).size.width >= 1100
          ? null
          : Drawer(
              shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.zero)),
              // width: MediaQuery.of(context).size.width >= 1100
              //     ? MediaQuery.of(context).size.width / 3
              //     : double.infinity,
              width: double.infinity,
              child: MobileMenuWidget(
                moveToOrder: moveToOrder,
                isLogged: isLogged,
                cats: cats,
              )),
      body: Column(
        children: [
          // New section for web devices only
          if (MediaQuery.of(context).size.width >= 1100)
            Container(
              color: Colors.grey[100], // Light grey background
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Hotline (left side)
                  Row(
                    children: [
                      const Icon(Icons.phone, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        'Hotline: 1500-123',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),

                  // Pusat Bantuan and Tentang Kami (right side)
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          // Navigate to help center
                          context.go('/pusat-bantuan');
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          minimumSize: Size.zero,
                        ),
                        child: Text(
                          'Pusat Bantuan',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      TextButton(
                        onPressed: () {
                          // Navigate to about us
                          context.go('/tentang-kami');
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          minimumSize: Size.zero,
                        ),
                        child: Text(
                          'Tentang Kami',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          Expanded(
            child: Scaffold(
              appBar: AppBar(
                forceMaterialTransparency: true,
                toolbarHeight:
                    MediaQuery.of(context).size.width >= 1100 ? 90 : null,
                leadingWidth:
                    MediaQuery.of(context).size.width >= 1100 ? 350 : 200,
                automaticallyImplyLeading: false,
                leading: MediaQuery.of(context).size.width >= 1100
                    ? InkWell(
                        hoverColor: Colors.transparent,
                        onTap: () {
                          context.go('/');
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Transform.scale(
                            scale: 0.7,
                            child: Image.asset(
                              'assets/image/tunas auction.png',
                              color:
                                  AdaptiveTheme.of(context).mode.isDark == true
                                      ? Colors.white
                                      : null,
                            ),
                          ),
                        ),
                      )
                    : InkWell(
                        hoverColor: Colors.transparent,
                        onTap: () {
                          context.go('/');
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Transform.scale(
                            scale: 1,
                            child: Image.asset(
                              'assets/image/tunas auction.png',
                              color:
                                  AdaptiveTheme.of(context).mode.isDark == true
                                      ? Colors.white
                                      : null,
                            ),
                          ),
                        ),
                      ),
                title: MediaQuery.of(context).size.width >= 1100
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width / 3.5,
                        height: 40,
                        child: const SearchWidget(
                          autoFocus: false,
                        ),
                      )
                    : null,
                actions: [
                  MediaQuery.of(context).size.width >= 1100
                      ? DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            dropdownStyleData:
                                const DropdownStyleData(width: 200),
                            isExpanded: true,
                            customButton: Row(
                              children: [
                                Badge(
                                  isLabelVisible:
                                      isLogged == true ? true : false,
                                  backgroundColor: appColor,
                                  alignment: Alignment.bottomRight,
                                  label: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 6,
                                  ),
                                  child: const Icon(
                                    Icons.person_outline_outlined,
                                  ),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  isLogged == true ? '$hi, $fullname' : account,
                                  style: const TextStyle(),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Icon(
                                  Icons.arrow_drop_down_outlined,
                                ),
                              ],
                            ),
                            items: [
                              ...MenuItems.firstItems.map(
                                (item) => DropdownMenuItem<MenuItem>(
                                  value: item,
                                  child: MenuItems.buildItem(item),
                                ),
                              ),
                              const DropdownMenuItem<Divider>(
                                  enabled: false, child: Divider()),
                              if (isLogged == true)
                                ...MenuItems.secondItems.map(
                                  (item) => DropdownMenuItem<MenuItem>(
                                    value: item,
                                    child: MenuItems.buildItem(item),
                                  ),
                                ),
                              if (isLogged == false)
                                ...MenuItems.secondItems2.map(
                                  (item) => DropdownMenuItem<MenuItem>(
                                    value: item,
                                    child: MenuItems.buildItem(item),
                                  ),
                                ),
                            ],
                            value: selectedValue,
                            onChanged: (value) {
                              MenuItems.onChanged(context, value! as MenuItem);
                            },
                          ),
                        )
                      : Badge(
                          isLabelVisible: isLogged == true ? true : false,
                          backgroundColor: appColor,
                          alignment: Alignment.bottomRight,
                          label: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 8,
                          ),
                          child: IconButton(
                              onPressed: () {
                                if (isLogged == true) {
                                  context.go('/profile');
                                } else {
                                  context.go('/login');
                                }
                              },
                              icon: const Icon(Icons.person_outline)),
                        ),
                  const Gap(10),
                  if (MediaQuery.of(context).size.width >= 1100)
                    AdaptiveTheme.of(context).mode.isDark == true
                        ? InkWell(
                            onTap: () {
                              AdaptiveTheme.of(context).setLight();
                            },
                            child: const Icon(Icons.light_mode))
                        : InkWell(
                            onTap: () {
                              AdaptiveTheme.of(context).setDark();
                            },
                            child: const Icon(Icons.dark_mode)),
                  if (MediaQuery.of(context).size.width >= 1100) const Gap(100)
                ],
                bottom: loaded == true
                    ? MediaQuery.of(context).size.width >= 1100
                        ? PreferredSize(
                            preferredSize: const Size.fromHeight(50),
                            child: Material(
                                color: appColor,
                                child: CatsTabs(data: categories)))
                        : const PreferredSize(
                            preferredSize: Size.fromHeight(50),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(left: 8, right: 8),
                                child: SizedBox(
                                    height: 40,
                                    child: SearchWidget(autoFocus: false)),
                              ),
                            ))
                    : null,
              ),
              body: Stack(
                children: [
                  widget.body,
                  widget.path == '/terms' ||
                          widget.path == '/about' ||
                          widget.path == '/policy' ||
                          widget.path == '/checkout'
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.only(top: 300, right: 20),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                _scaffoldHome.currentState!.openEndDrawer();
                              },
                              child: Image.asset(
                                'assets/image/Group 57.png',
                                width: 75,
                                height: 75,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
