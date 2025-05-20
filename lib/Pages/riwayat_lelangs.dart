import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tunasauctionv2/Model/user.dart';
import 'package:tunasauctionv2/app/Widgets/footer_widget.dart';
import 'package:tunasauctionv2/app/Widgets/orders_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../app/Widgets/vendor_widget_main.dart';

class RiwayatLelangsPage extends StatefulWidget {
  const RiwayatLelangsPage({super.key});

  @override
  State<RiwayatLelangsPage> createState() => _RiwayatLelangsPageState();
}

class _RiwayatLelangsPageState extends State<RiwayatLelangsPage> {
  List<UserModel> products = [];
  bool isLoaded = true;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      context.go('/login');
    } else {
      getProducts();
    }
  }

  getProducts() async {
    setState(() {
      isLoaded = true;
    });
    context.loaderOverlay.show();

    FirebaseFirestore.instance
        .collection('vendors')
        .where('approval', isEqualTo: true)
        .snapshots()
        .listen((event) {
      setState(() {
        isLoaded = false;
      });
      context.loaderOverlay.hide();

      products.clear();
      for (var element in event.docs) {
        try {
          // Konversi data Firestore ke format JSON yang diharapkan UserModel
          Map<String, dynamic> vendorData = element.data();
          Map<String, dynamic> userJson = {
            'id': vendorData['id'] ?? 0,
            'group_id': vendorData['group_id'] ?? 0,
            'name': vendorData['name'] ?? '',
            'email': vendorData['email'] ?? '',
            'status': vendorData['status'] ?? 'active',
            'is_deleted': vendorData['is_deleted'] ?? 0,
            'is_verified': vendorData['is_verified'] ?? 0,
            'created_at': vendorData['created_at']?.toString() ?? DateTime.now().toString(),
            'updated_at': vendorData['updated_at']?.toString() ?? DateTime.now().toString(),
            'member': vendorData['member'] ?? 0,
            // Tambahkan field lain dengan nilai default jika diperlukan
          };

          var prods = UserModel.fromJson(userJson);
          setState(() {
            products.add(prods);
          });
        } catch (e) {
          print('Error processing vendor data: $e');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdaptiveTheme.of(context).mode.isDark == true
          ? null
          : const Color.fromARGB(255, 247, 240, 240),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: MediaQuery.of(context).size.width >= 1100
                  ? const EdgeInsets.only(left: 60, right: 100)
                  : const EdgeInsets.all(0),
              child: Column(
                children: [
                  const Gap(20),
                  if (MediaQuery.of(context).size.width >= 1100)
                    Align(
                      alignment: MediaQuery.of(context).size.width >= 1100
                          ? Alignment.centerLeft
                          : Alignment.center,
                    ),
                  const Gap(10),
                ],
              ),
            ),
            Card(
              shape: const BeveledRectangleBorder(),
              color: AdaptiveTheme.of(context).mode.isDark == true
                  ? Colors.black87
                  : Colors.white,
              surfaceTintColor: Colors.white,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: OrdersWidget(),
              ),
            ),
            const Gap(20),
            const FooterWidget()
          ],
        ),
      ),
    );
  }
}