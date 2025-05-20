import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tunasauctionv2/Model/products_model.dart';
import 'package:tunasauctionv2/Model/sub_categories_model.dart';
import 'package:tunasauctionv2/app/Widgets/footer_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as modalSheet;
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;

import '../../Model/constant.dart';
import '../app/Widgets/product_widget_main.dart';

class ProductAllCategoryPage extends StatefulWidget {
  final String category;
  const ProductAllCategoryPage({super.key, required this.category});

  @override
  State<ProductAllCategoryPage> createState() => _ProductAllCategoryPageState();
}

class _ProductAllCategoryPageState extends State<ProductAllCategoryPage> {
  String imageUrl = '';
  List<String> imageUrls = [
    'assets/image/slider_open_house1.png',
    'assets/image/slider_open_house2.png',
    'assets/image/slider_open_house3.png',
  ];

  // Filter variables
  String? selectedBrand;
  String? selectedMerk;
  String? selectedTipe;
  String? selectedModel;
  String? selectedSilinder;
  String? selectedTransmisi;
  String? selectedBahanBakar;
  String? selectedSegmen;

  // Hardcoded filter options
  final List<String> brands = ['Toyota', 'Honda', 'Suzuki', 'Mitsubishi', 'Daihatsu'];
  final List<String> merks = ['Avanza', 'Brio', 'Ertiga', 'Xpander', 'Terios'];
  final List<String> tipes = ['MPV', 'Hatchback', 'SUV', 'Sedan', 'LCGC'];
  final List<String> models = ['1.5', '1.3', '1.0', '1.8', '2.0'];
  final List<String> silinders = ['4 Silinder', '3 Silinder', '6 Silinder'];
  final List<String> transmisis = ['Automatic', 'Manual', 'CVT'];
  final List<String> bahanBakars = ['Bensin', 'Solar', 'Hybrid', 'Listrik'];
  final List<String> segmens = ['Low', 'Medium', 'High', 'Luxury'];

  getCate() {
    context.loaderOverlay.show();
    FirebaseFirestore.instance
        .collection('Categories')
        .where('category', isEqualTo: widget.category)
        .get()
        .then((value) {
      setState(() {
        context.loaderOverlay.hide();
        for (var element in value.docs) {
          setState(() {
            imageUrl = element['image'];
          });
          print('Image URL is $imageUrl');
          print('Category is ${widget.category}');
        }
      });
    });
  }

  List<ProductsModel> products = [];
  List<ProductsModel> initProducts = [];
  bool isLoaded = true;

  getProducts() async {
    setState(() {
      isLoaded = true;
    });
    context.loaderOverlay.show();
    FirebaseFirestore.instance
        .collection('Products')
        .snapshots()
        .listen((event) {
      setState(() {
        isLoaded = false;
      });
      context.loaderOverlay.hide();
      products.clear();
      for (var element in event.docs) {
        var prods = ProductsModel.fromMap(element, element.id);
        setState(() {
          products.add(prods);
          initProducts = products;
        });
      }
    });
  }

  List<SubCategoriesModel> retails = [];
  getSubCollections() {
    return FirebaseFirestore.instance
        .collection('Collections')
        .snapshots()
        .listen((value) {
      retails.clear();
      for (var element in value.docs) {
        setState(() {
          var fetchServices =
          SubCategoriesModel.fromMap(element.data(), element.id);
          retails.add(fetchServices);
        });
      }
    });
  }

  @override
  void initState() {
    getCate();
    getSubCollections();
    getProducts();
    getCurrency();
    super.initState();
  }

  void resetToInitialList() {
    setState(() {
      products = List.from(initProducts);
      selectedBrand = null;
      selectedMerk = null;
      selectedTipe = null;
      selectedModel = null;
      selectedSilinder = null;
      selectedTransmisi = null;
      selectedBahanBakar = null;
      selectedSegmen = null;
    });
  }

  String? sortBy;
  String currency = '';

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

  void sortProductsFromLowToHigh() {
    setState(() {
      products.sort((a, b) => a.unitPrice1.compareTo(b.unitPrice1));
    });
  }

  void sortProductsFromHighToLow() {
    setState(() {
      products.sort((a, b) => b.unitPrice1.compareTo(a.unitPrice1));
    });
  }

  // Since we don't have these fields in the model, we'll just show all products
  // when filters are selected (as we can't actually filter by these fields)
  void filterProducts() {
    // In a real implementation, you would filter the products list here
    // based on the selected filter values

    // For now, we'll just show all products
    setState(() {
      products = List.from(initProducts);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AdaptiveTheme.of(context).mode.isDark == true
            ? null
            : const Color.fromARGB(255, 247, 240, 240),
        body: SingleChildScrollView(
          child: Column(children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 1.0,
              ),
              items: imageUrls.map((imageUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: AssetImage(imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            const Gap(20),
            if (MediaQuery.of(context).size.width >= 1100)
              Align(
                alignment: MediaQuery.of(context).size.width >= 1100
                    ? Alignment.centerLeft
                    : Alignment.center,
                child: Padding(
                  padding: MediaQuery.of(context).size.width >= 1100
                      ? const EdgeInsets.only(left: 60, right: 120)
                      : const EdgeInsets.all(0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          context.go('/');
                        },
                        child: const Text(
                          'Home',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Text(
                        '/ ${widget.category}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            if (MediaQuery.of(context).size.width >= 1100) const Gap(10),
            MediaQuery.of(context).size.width >= 1100
                ? Padding(
              padding: MediaQuery.of(context).size.width >= 1100
                  ? const EdgeInsets.only(left: 50, right: 50)
                  : const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 2,
                      child: Card(
                        shape: const BeveledRectangleBorder(),
                        surfaceTintColor: Colors.white,
                        color:
                        AdaptiveTheme.of(context).mode.isDark == true
                            ? Colors.black87
                            : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ListTile(
                                  title: const Text(
                                    'Filter',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: TextButton(
                                    child: const Text(
                                      'Clear All',
                                      style: TextStyle(
                                          color: Colors.grey),
                                    ),
                                    onPressed: () {
                                      resetToInitialList();
                                    },
                                  ),
                                ),

                                // Brand Filter
                                ExpansionTile(
                                  title: const Text('Brand'),
                                  children: [
                                    DropdownButtonFormField<String>(
                                      value: selectedBrand,
                                      items: brands.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedBrand = newValue;
                                        });
                                        filterProducts();
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                      ),
                                    ),
                                  ],
                                ),

                                // Merk Filter
                                ExpansionTile(
                                  title: const Text('Merk'),
                                  children: [
                                    DropdownButtonFormField<String>(
                                      value: selectedMerk,
                                      items: merks.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedMerk = newValue;
                                        });
                                        filterProducts();
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                      ),
                                    ),
                                  ],
                                ),

                                // Tipe Filter
                                ExpansionTile(
                                  title: const Text('Tipe'),
                                  children: [
                                    DropdownButtonFormField<String>(
                                      value: selectedTipe,
                                      items: tipes.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedTipe = newValue;
                                        });
                                        filterProducts();
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                      ),
                                    ),
                                  ],
                                ),

                                // Model Filter
                                ExpansionTile(
                                  title: const Text('Model'),
                                  children: [
                                    DropdownButtonFormField<String>(
                                      value: selectedModel,
                                      items: models.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedModel = newValue;
                                        });
                                        filterProducts();
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                      ),
                                    ),
                                  ],
                                ),

                                // Silinder Filter
                                ExpansionTile(
                                  title: const Text('Silinder'),
                                  children: [
                                    DropdownButtonFormField<String>(
                                      value: selectedSilinder,
                                      items: silinders.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedSilinder = newValue;
                                        });
                                        filterProducts();
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                      ),
                                    ),
                                  ],
                                ),

                                // Transmisi Filter
                                ExpansionTile(
                                  title: const Text('Transmisi'),
                                  children: [
                                    DropdownButtonFormField<String>(
                                      value: selectedTransmisi,
                                      items: transmisis.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedTransmisi = newValue;
                                        });
                                        filterProducts();
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                      ),
                                    ),
                                  ],
                                ),

                                // Bahan Bakar Filter
                                ExpansionTile(
                                  title: const Text('Bahan Bakar'),
                                  children: [
                                    DropdownButtonFormField<String>(
                                      value: selectedBahanBakar,
                                      items: bahanBakars.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedBahanBakar = newValue;
                                        });
                                        filterProducts();
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                      ),
                                    ),
                                  ],
                                ),

                                // Segmen Filter
                                ExpansionTile(
                                  title: const Text('Segmen'),
                                  children: [
                                    DropdownButtonFormField<String>(
                                      value: selectedSegmen,
                                      items: segmens.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedSegmen = newValue;
                                        });
                                        filterProducts();
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                  const Gap(10),
                  Expanded(
                    flex: 7,
                    child: isLoaded == true
                        ? GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: MediaQuery.of(context)
                              .size
                              .width >=
                              1100
                              ? 4
                              : 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.7),
                      itemCount: 20,
                      itemBuilder:
                          (BuildContext context, int index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Container(
                                  color: Colors.grey[300],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 16,
                                      width: 120,
                                      color: Colors.grey[300],
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      height: 16,
                                      width: 80,
                                      color: Colors.grey[300],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                        : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const Gap(10),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // First Button - Download
                                InkWell(
                                  onTap: () {
                                    context.go('/unduh-daftar-lot');
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.download,
                                          size: 50, // Ukuran dikurangi sedikit
                                          color: appColor,
                                        ),
                                        const SizedBox(height: 4),
                                        const Text(
                                          'Unduh Daftar Lot',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 24), // Jarak antara tombol disesuaikan

                                // Second Button - Buy
                                InkWell(
                                  onTap: () {
                                    context.go('/hot-deals');
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.shopping_cart,
                                          size: 50, // Ukuran dikurangi sedikit
                                          color: appColor,
                                        ),
                                        const SizedBox(height: 4),
                                        const Text(
                                          'Beli NIPL',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),


                            const SizedBox(height: 16), // Spacing between buttons and product count

                            // Existing product count and sort row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Reguler Bekasi 2025-05-19 : ${products.length} Unit',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                        isExpanded: true,
                                        dropdownStyleData:
                                        const DropdownStyleData(
                                            width: 150),
                                        customButton: const Row(
                                          children: [
                                            Icon(
                                              Icons.sort,
                                            ),
                                            SizedBox(
                                              width: 7,
                                            ),
                                            Text(
                                              'Urutkan Berdasarkan',
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold),
                                              overflow:
                                              TextOverflow.ellipsis,
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Icon(
                                              Icons
                                                  .arrow_drop_down_outlined,
                                            ),
                                          ],
                                        ),
                                        items: [
                                          'Harga Termurah',
                                          'Harga Termahal',
                                          // 'Product Rating',
                                        ]
                                            .map((item) =>
                                            DropdownMenuItem<
                                                String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style:
                                                const TextStyle(
                                                  fontSize: 11,
                                                ),
                                                overflow:
                                                TextOverflow
                                                    .ellipsis,
                                              ),
                                            ))
                                            .toList(),
                                        value: sortBy,
                                        onChanged: (value) {
                                          setState(
                                                () {
                                              if (value ==
                                                  'Price:Low to High') {
                                                sortProductsFromLowToHigh();
                                              } else if (value ==
                                                  'Price:High to Low') {
                                                sortProductsFromHighToLow();
                                              }
                                            },
                                          );
                                        })),
                              ],
                            ),
                            const Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            products.isEmpty
                                ? Center(
                              child: Column(children: [
                                Icon(
                                  Icons.remove_shopping_cart,
                                  color: appColor,
                                  size: MediaQuery.of(context)
                                      .size
                                      .height /
                                      3,
                                ),
                                const Gap(10),
                                const Text('No Product Was Found')
                              ]),
                            )
                                : GridView.builder(
                              physics:
                              const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                ProductsModel productsModel =
                                products[index];
                                return Padding(
                                  padding:
                                  const EdgeInsets.all(
                                      8.0),
                                  child: ProductWidgetMain(
                                      productsModel:
                                      productsModel),
                                );
                              },
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio:
                                  MediaQuery.of(context)
                                      .size
                                      .width >=
                                      1100
                                      ? 0.7
                                      : 0.57,
                                  crossAxisCount:
                                  MediaQuery.of(context)
                                      .size
                                      .width >=
                                      1100
                                      ? 4
                                      : 2,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(8)
                ],
              ),
            )
                : SingleChildScrollView(
              child: Column(
                children: [
                  isLoaded == true
                      ? GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                        MediaQuery.of(context).size.width >=
                            1100
                            ? 4
                            : 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 0.8),
                    itemCount: 20,
                    itemBuilder: (BuildContext context, int index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Container(
                                color: Colors.grey[300],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 16,
                                    width: 120,
                                    color: Colors.grey[300],
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    height: 16,
                                    width: 80,
                                    color: Colors.grey[300],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                      : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            TextButton.icon(
                                onPressed: () {
                                  modalSheet
                                      .showBarModalBottomSheet(
                                      expand: true,
                                      bounce: true,
                                      context: context,
                                      backgroundColor:
                                      Colors.transparent,
                                      builder: (context) {
                                        return StatefulBuilder(
                                            builder: (context,
                                                setState) {
                                              return Scaffold(
                                                body: Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .all(8.0),
                                                  child:
                                                  SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        ListTile(
                                                          title:
                                                          const Text(
                                                            'Filter',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight.bold),
                                                          ),
                                                          trailing: TextButton(
                                                              onPressed: () {
                                                                resetToInitialList();
                                                                context.pop();
                                                              },
                                                              child: Text(
                                                                'Clear All',
                                                                style:
                                                                TextStyle(color: AdaptiveTheme.of(context).mode.isDark == true ? Colors.white : Colors.black),
                                                              )),
                                                        ),

                                                        // Brand Filter
                                                        ExpansionTile(
                                                          title: const Text('Brand'),
                                                          children: [
                                                            DropdownButtonFormField<String>(
                                                              value: selectedBrand,
                                                              items: brands.map((String value) {
                                                                return DropdownMenuItem<String>(
                                                                  value: value,
                                                                  child: Text(value),
                                                                );
                                                              }).toList(),
                                                              onChanged: (newValue) {
                                                                setState(() {
                                                                  selectedBrand = newValue;
                                                                });
                                                                filterProducts();
                                                              },
                                                              decoration: const InputDecoration(
                                                                border: OutlineInputBorder(),
                                                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        // Merk Filter
                                                        ExpansionTile(
                                                          title: const Text('Merk'),
                                                          children: [
                                                            DropdownButtonFormField<String>(
                                                              value: selectedMerk,
                                                              items: merks.map((String value) {
                                                                return DropdownMenuItem<String>(
                                                                  value: value,
                                                                  child: Text(value),
                                                                );
                                                              }).toList(),
                                                              onChanged: (newValue) {
                                                                setState(() {
                                                                  selectedMerk = newValue;
                                                                });
                                                                filterProducts();
                                                              },
                                                              decoration: const InputDecoration(
                                                                border: OutlineInputBorder(),
                                                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        // Tipe Filter
                                                        ExpansionTile(
                                                          title: const Text('Tipe'),
                                                          children: [
                                                            DropdownButtonFormField<String>(
                                                              value: selectedTipe,
                                                              items: tipes.map((String value) {
                                                                return DropdownMenuItem<String>(
                                                                  value: value,
                                                                  child: Text(value),
                                                                );
                                                              }).toList(),
                                                              onChanged: (newValue) {
                                                                setState(() {
                                                                  selectedTipe = newValue;
                                                                });
                                                                filterProducts();
                                                              },
                                                              decoration: const InputDecoration(
                                                                border: OutlineInputBorder(),
                                                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        // Model Filter
                                                        ExpansionTile(
                                                          title: const Text('Model'),
                                                          children: [
                                                            DropdownButtonFormField<String>(
                                                              value: selectedModel,
                                                              items: models.map((String value) {
                                                                return DropdownMenuItem<String>(
                                                                  value: value,
                                                                  child: Text(value),
                                                                );
                                                              }).toList(),
                                                              onChanged: (newValue) {
                                                                setState(() {
                                                                  selectedModel = newValue;
                                                                });
                                                                filterProducts();
                                                              },
                                                              decoration: const InputDecoration(
                                                                border: OutlineInputBorder(),
                                                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        // Silinder Filter
                                                        ExpansionTile(
                                                          title: const Text('Silinder'),
                                                          children: [
                                                            DropdownButtonFormField<String>(
                                                              value: selectedSilinder,
                                                              items: silinders.map((String value) {
                                                                return DropdownMenuItem<String>(
                                                                  value: value,
                                                                  child: Text(value),
                                                                );
                                                              }).toList(),
                                                              onChanged: (newValue) {
                                                                setState(() {
                                                                  selectedSilinder = newValue;
                                                                });
                                                                filterProducts();
                                                              },
                                                              decoration: const InputDecoration(
                                                                border: OutlineInputBorder(),
                                                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        // Transmisi Filter
                                                        ExpansionTile(
                                                          title: const Text('Transmisi'),
                                                          children: [
                                                            DropdownButtonFormField<String>(
                                                              value: selectedTransmisi,
                                                              items: transmisis.map((String value) {
                                                                return DropdownMenuItem<String>(
                                                                  value: value,
                                                                  child: Text(value),
                                                                );
                                                              }).toList(),
                                                              onChanged: (newValue) {
                                                                setState(() {
                                                                  selectedTransmisi = newValue;
                                                                });
                                                                filterProducts();
                                                              },
                                                              decoration: const InputDecoration(
                                                                border: OutlineInputBorder(),
                                                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        // Bahan Bakar Filter
                                                        ExpansionTile(
                                                          title: const Text('Bahan Bakar'),
                                                          children: [
                                                            DropdownButtonFormField<String>(
                                                              value: selectedBahanBakar,
                                                              items: bahanBakars.map((String value) {
                                                                return DropdownMenuItem<String>(
                                                                  value: value,
                                                                  child: Text(value),
                                                                );
                                                              }).toList(),
                                                              onChanged: (newValue) {
                                                                setState(() {
                                                                  selectedBahanBakar = newValue;
                                                                });
                                                                filterProducts();
                                                              },
                                                              decoration: const InputDecoration(
                                                                border: OutlineInputBorder(),
                                                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        // Segmen Filter
                                                        ExpansionTile(
                                                          title: const Text('Segmen'),
                                                          children: [
                                                            DropdownButtonFormField<String>(
                                                              value: selectedSegmen,
                                                              items: segmens.map((String value) {
                                                                return DropdownMenuItem<String>(
                                                                  value: value,
                                                                  child: Text(value),
                                                                );
                                                              }).toList(),
                                                              onChanged: (newValue) {
                                                                setState(() {
                                                                  selectedSegmen = newValue;
                                                                });
                                                                filterProducts();
                                                              },
                                                              decoration: const InputDecoration(
                                                                border: OutlineInputBorder(),
                                                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        const SizedBox(height: 20),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            filterProducts();
                                                            context.pop();
                                                          },
                                                          child: const Text('Apply Filters'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            });
                                      });
                                },
                                icon: Icon(Icons.filter,
                                    color: AdaptiveTheme.of(context)
                                        .mode
                                        .isDark ==
                                        true
                                        ? Colors.white
                                        : Colors.black),
                                label: Text(
                                  'Filter',
                                  style: TextStyle(
                                      color:
                                      AdaptiveTheme.of(context)
                                          .mode
                                          .isDark ==
                                          true
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold),
                                )),
                            const Gap(10),
                            const SizedBox(
                              height: 20,
                              child: VerticalDivider(
                                color: Colors.black,
                                thickness: 1,
                                width: 1,
                                endIndent: 2,
                                indent: 2,
                              ),
                            ),
                            const Gap(10),
                            DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                    isExpanded: true,
                                    dropdownStyleData:
                                    const DropdownStyleData(
                                        width: 150),
                                    customButton: const Row(
                                      children: [
                                        Icon(
                                          Icons.sort,
                                        ),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          'Urutkan Berdasarkan',
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold),
                                          overflow:
                                          TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Icon(
                                          Icons
                                              .arrow_drop_down_outlined,
                                        ),
                                      ],
                                    ),
                                    items: [
                                      'Price:Low to High',
                                      'Price:High to Low',
                                      'Product Rating',
                                    ]
                                        .map((item) =>
                                        DropdownMenuItem<
                                            String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style:
                                            const TextStyle(
                                              fontSize: 11,
                                            ),
                                            overflow:
                                            TextOverflow
                                                .ellipsis,
                                          ),
                                        ))
                                        .toList(),
                                    value: sortBy,
                                    onChanged: (value) {
                                      setState(
                                            () {
                                          if (value ==
                                              'Price:Low to High') {
                                            sortProductsFromLowToHigh();
                                          } else if (value ==
                                              'Price:High to Low') {
                                            sortProductsFromHighToLow();
                                          }
                                        },
                                      );
                                    })),
                          ],
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        products.isEmpty
                            ? Center(
                          child: Column(children: [
                            Icon(
                              Icons.remove_shopping_cart,
                              color: appColor,
                              size: MediaQuery.of(context)
                                  .size
                                  .height /
                                  3,
                            ),
                            const Gap(10),
                            const Text('No Product Was Found')
                          ]),
                        )
                            : GridView.builder(
                          physics:
                          const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            ProductsModel productsModel =
                            products[index];
                            return Padding(
                              padding:
                              const EdgeInsets.all(8),
                              child: InkWell(
                                  onTap: () {
                                    context.go(
                                        '/product-detail/${productsModel.uid}');
                                  },
                                  child: ProductWidgetMain(
                                      productsModel:
                                      productsModel)),
                            );
                          },
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.5,
                              crossAxisCount:
                              MediaQuery.of(context)
                                  .size
                                  .width >=
                                  1100
                                  ? 4
                                  : 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Gap(20),
            const FooterWidget()
          ]),
        ));
  }
}