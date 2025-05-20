// ignore_for_file: avoid_print
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../Model/constant.dart';

class CatsTabs extends StatefulWidget {
  final List<String> data;
  const CatsTabs({super.key, required this.data});

  @override
  State<CatsTabs> createState() => _CatsTabsState();
}

class _CatsTabsState extends State<CatsTabs> with TickerProviderStateMixin {
  TabController? controller;
  int indexTab = 0;
  @override
  void initState() {
    controller = TabController(length:11, vsync: this);
    controller!.addListener(() {
      setState(() {
        indexTab = controller!.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  bool selectedDiscount = false;
  bool liveauctionsall = false;
  bool selectedHome = false;
  bool selectedOpenHouse = false;
  bool selectedBrand = false;
  bool vendors = false;
  bool selectedHotDeal = false;
  bool liveauctions = false;
  bool belinipls = false;
  bool riwayatlelangs = false;
  bool prosedurs = false;
  bool liveauctionnew = false;
  bool news = false;
  bool titipjual = false;
  bool bpmonitoring = false;
  bool managementmonitoring = false;


  @override
  Widget build(BuildContext context) {
    return TabBar(
        overlayColor: MaterialStateProperty.all(Colors.white),
        padding: const EdgeInsets.only(left: 0, right: 200),
        controller: controller,
        isScrollable: true,
        tabs: [
          // DropdownButtonHideUnderline(
          //   child: DropdownButton2(
          //     isExpanded: true,
          //
          //     dropdownStyleData: const DropdownStyleData(width: 200),
          //     isDense: true,
          //     customButton: Container(
          //       color: Colors.white,
          //       height: 50,
          //       width: 200,
          //       child:  Padding(
          //         padding: const EdgeInsets.only(left: 8, right: 8),
          //         child: Row(children: [
          //           Icon(
          //             Icons.widgets_outlined,
          //             color: appColor,
          //
          //             //  color: Color.fromRGBO(48, 30, 2, 1),
          //           ),
          //           const Gap(20),
          //           Text(
          //             'Categories',
          //             style: TextStyle(
          //                 color: appColor, fontWeight: FontWeight.bold),
          //           ),
          //           const Gap(20),
          //           Icon(
          //             Icons.arrow_drop_down_outlined,
          //             color: appColor,
          //             //  color: Color.fromRGBO(48, 30, 2, 1),
          //           )
          //         ]),
          //       ),
          //     ),
          //     items: widget.data
          //         .map((item) => DropdownMenuItem<String>(
          //               value: item,
          //               child: ListTile(
          //                 contentPadding: EdgeInsets.zero,
          //                 trailing: const Icon(
          //                   Icons.chevron_right,
          //                   color: Colors.grey,
          //                 ),
          //                 title: Text(
          //                   item,
          //                   style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w200),
          //                   overflow: TextOverflow.ellipsis,
          //                 ),
          //               ),
          //             ))
          //         .toList(),
          //     // value: selectedValue,
          //     onChanged: (value) {
          //       setState(() {
          //         context.go('/products/$value');
          //         // context.pop();
          //       });
          //     },
          //   ),
          // ),
          InkWell(
            hoverColor: Colors.transparent,
            onHover: (value) {
              setState(() {
                selectedHome = value;
              });
            },
            onTap: () {
              context.go('/');
            },
            child: Tab(
              child: Text(
                'Home',
                style: TextStyle(
                  color: selectedHome == true ? appColor : Colors.white, // Pastikan warna teks terlihat di semua state
                  fontWeight: FontWeight.bold, // Tambahkan fontWeight untuk mempertegas teks
                ),
              ),
            ),
          ),

          InkWell(
              hoverColor: Colors.transparent,
              onHover: (value) {
                setState(() {
                  selectedOpenHouse = value;
                });
              },
              onTap: () {
                context.go('/products-all-category');
              },
              child: Tab(
                child: Text(
                  'Open House',
                  style: TextStyle(
                      color: selectedOpenHouse == true ? appColor : null),
                ),
              )),
          InkWell(
              hoverColor: Colors.transparent,
              onHover: (value) {
                setState(() {
                  selectedDiscount = value;
                });
              },
              onTap: () {
                context.go('/flash-sales');
              },
              child: Tab(
                child: Text(
                  'Jadwal Lelang',
                  style: TextStyle(
                      color: selectedDiscount == true ? appColor : null),
                ),
              )),
          InkWell(
              hoverColor: Colors.transparent,
              onHover: (value) {
                setState(() {
                  liveauctions = value;
                });
              },
              onTap: () {
                context.go('/live-auction-all');
              },
              child: Tab(
                child: Text(
                  'Live Auction',
                  style: TextStyle(
                      color: liveauctions == true ? appColor : null),
                ),
              )),
          InkWell(
              hoverColor: Colors.transparent,
              onHover: (value) {
                setState(() {
                  belinipls = value;
                });
              },
              onTap: () {
                context.go('/hot-deals');
              },
              child: Tab(
                child: Text(
                  'Beli NIPL',
                  style: TextStyle(
                      color: belinipls == true ? appColor : null),
                ),
              )),
          // InkWell(
          //     hoverColor: Colors.transparent,
          //     onHover: (value) {
          //       setState(() {
          //         riwayatlelangs = value;
          //       });
          //     },
          //     onTap: () {
          //       context.go('/riwayat-lelangs');
          //     },
          //     child: Tab(
          //       child: Text(
          //         'Riwayat Lelang',
          //         style: TextStyle(
          //             color: riwayatlelangs == true ? appColor : null),
          //       ),
          //     )),
          InkWell(
              hoverColor: Colors.transparent,
              onHover: (value) {
                setState(() {
                  prosedurs = value;
                });
              },
              onTap: () {
                context.go('/about');
              },
              child: Tab(
                child: Text(
                  'Prosedur',
                  style: TextStyle(
                      color: vendors == true ? appColor : null),
                ),
              )),
          // InkWell(
          //     hoverColor: Colors.transparent,
          //     onHover: (value) {
          //       setState(() {
          //         liveauctionnew = value;
          //       });
          //     },
          //     onTap: () {
          //       context.go('/live-auction-new');
          //     },
          //     child: Tab(
          //       child: Text(
          //         'Live Auction New',
          //         style: TextStyle(
          //             color: vendors == true ? appColor : null),
          //       ),
          //     )),
          // InkWell(
          //     hoverColor: Colors.transparent,
          //     onHover: (value) {
          //       setState(() {
          //         news = value;
          //       });
          //     },
          //     onTap: () {
          //       context.go('/news');
          //     },
          //     child: Tab(
          //       child: Text(
          //         'News',
          //         style: TextStyle(
          //             color: news == true ? appColor : null),
          //       ),
          //     )),
          // InkWell(
          //     hoverColor: Colors.transparent,
          //     onHover: (value) {
          //       setState(() {
          //         titipjual = value;
          //       });
          //     },
          //     onTap: () {
          //       context.go('/news-detail');
          //     },
          //     child: Tab(
          //       child: Text(
          //         'Titip Jual',
          //         style: TextStyle(
          //             color: titipjual == true ? appColor : null),
          //       ),
          //     )),
          // InkWell(
          //     hoverColor: Colors.transparent,
          //     onHover: (value) {
          //       setState(() {
          //         bpmonitoring = value;
          //       });
          //     },
          //     onTap: () {
          //       context.go('/vendors');
          //     },
          //     child: Tab(
          //       child: Text(
          //         'BP Monitoring',
          //         style: TextStyle(
          //             color: bpmonitoring == true ? appColor : null),
          //       ),
          //     )),
          // InkWell(
          //     hoverColor: Colors.transparent,
          //     onHover: (value) {
          //       setState(() {
          //         managementmonitoring = value;
          //       });
          //     },
          //     onTap: () {
          //       context.go('/managementmonitorings');
          //     },
          //     child: Tab(
          //       child: Text(
          //         'Management Monitoring',
          //         style: TextStyle(
          //             color: managementmonitoring == true ? appColor : null),
          //       ),
          //     )),
          // InkWell(
          //     hoverColor: Colors.transparent,
          //     onHover: (value) {
          //       setState(() {
          //         liveauctions = value;
          //       });
          //     },
          //     onTap: () {
          //       context.go('/live-auction-all');
          //     },
          //     child: Tab(
          //       child: Text(
          //         'Live Auction All',
          //         style: TextStyle(
          //             color: liveauctions == true ? appColor : null),
          //       ),
          //     )),
        ],
        unselectedLabelColor: Colors.white,
        unselectedLabelStyle: const TextStyle(fontSize: 16),
        labelColor: appColor,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: Colors.transparent);
  }
}
