import 'package:adaptive_theme/adaptive_theme.dart';
// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tunasauctionv2/app/Widgets/delivery_address_widget.dart';
import 'package:tunasauctionv2/app/Widgets/footer_widget.dart';
import 'package:tunasauctionv2/app/Widgets/web_menu.dart';

class DeliveryAddressPage extends StatefulWidget {
  const DeliveryAddressPage({super.key});

  @override
  State<DeliveryAddressPage> createState() => _DeliveryAddressPageState();
}

class _DeliveryAddressPageState extends State<DeliveryAddressPage> {
  @override
  void initState() {
    // getProducts();
    super.initState();
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
            if (MediaQuery.of(context).size.width >= 1100)
              Padding(
                padding: MediaQuery.of(context).size.width >= 1100
                    ? const EdgeInsets.only(left: 60, right:50)
                    : const EdgeInsets.all(0),
                child: Column(
                  children: [
                    const Gap(20),
                    if (MediaQuery.of(context).size.width >= 1100)
                      Align(
                        alignment: MediaQuery.of(context).size.width >= 1100
                            ? Alignment.centerLeft
                            : Alignment.center,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                context.go('/');
                              },
                              child: const Text(
                                'Home',
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                            const Text(
                              '/ Saved Address',
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    Align(
                      alignment: MediaQuery.of(context).size.width >= 1100
                          ? Alignment.centerLeft
                          : Alignment.center,
                      child: const Text(
                        'Saved Addresses',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    const Gap(20),
                  ],
                ),
              ),
            if (MediaQuery.of(context).size.width >= 1100)
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Card(
                          shape: const BeveledRectangleBorder(),
                          color: AdaptiveTheme.of(context).mode.isDark == true
                              ? Colors.black87
                              : Colors.white,
                          surfaceTintColor: Colors.white,
                          child: const WebMenu(path: '/delivery-addresses')),
                    ),
                    const Gap(20),
                    Expanded(
                      flex: 6,
                      child: Card(
                        shape: const BeveledRectangleBorder(),
                        color: AdaptiveTheme.of(context).mode.isDark == true
                            ? Colors.black87
                            : Colors.white,
                        surfaceTintColor: Colors.white,
                        child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: DeliveryAddressWidget()),
                      ),
                    )
                  ],
                ),
              ),
            if (MediaQuery.of(context).size.width <= 1100)
              const DeliveryAddressWidget(),
            const Gap(20),
            const FooterWidget()
          ],
        ),
      ),
    );
  }
}
