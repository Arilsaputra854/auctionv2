import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../Model/constant.dart';
import '../../Model/formatter.dart';
import '../../Model/order_model.dart';

class NiplWidget extends StatefulWidget {
  const NiplWidget({super.key});

  @override
  State<NiplWidget> createState() => _NiplWidgetState();
}

class _NiplWidgetState extends State<NiplWidget> with SingleTickerProviderStateMixin {
  List<OrderModel2> orders = [];
  List<OrderModel2> initOrders = [];
  String currency = '';
  bool isLoading = true;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    getCurrency();
    fetchOrders();
    _tabController = TabController(length: 4, vsync: this); // Jumlah tab
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> fetchOrders() async {
    setState(() {
      isLoading = true;
    });
    context.loaderOverlay.show();
    final FirebaseAuth auth = FirebaseAuth.instance;

    User? user = auth.currentUser;

    FirebaseFirestore.instance
        .collection('Orders')
        .where('userID', isEqualTo: user!.uid)
        .snapshots(includeMetadataChanges: true)
        .listen((data) {
      context.loaderOverlay.hide();
      setState(() {
        isLoading = false;
      });
      orders.clear();
      for (var doc in data.docs) {
        if (mounted) {
          setState(() {
            orders.add(OrderModel2(
              vendorIDs: [
                ...(doc.data()['vendorIDs']).map((items) {
                  return items;
                })
              ],
              orders: [
                ...(doc.data()['orders']).map((items) {
                  return OrdersList.fromMap(items);
                })
              ],
              pickupStorename: doc.data()['pickupStorename'],
              pickupPhone: doc.data()['pickupPhone'],
              pickupAddress: doc.data()['pickupAddress'],
              instruction: doc.data()['instruction'],
              couponPercentage: doc.data()['couponPercentage'],
              couponTitle: doc.data()['couponTitle'],
              useCoupon: doc.data()['useCoupon'],
              confirmationStatus: doc.data()['confirmationStatus'],
              uid: doc.data()['uid'],
              userID: doc.data()['userID'],
              deliveryAddress: doc.data()['deliveryAddress'],
              houseNumber: doc.data()['houseNumber'],
              closesBusStop: doc.data()['closesBusStop'],
              deliveryBoyID: doc.data()['deliveryBoyID'],
              status: doc.data()['status'],
              accept: doc.data()['accept'],
              orderID: doc.data()['orderID'],
              timeCreated: doc.data()['timeCreated'].toDate(),
              total: doc.data()['total'],
              deliveryFee: doc.data()['deliveryFee'],
              acceptDelivery: doc.data()['acceptDelivery'],
              paymentType: doc.data()['paymentType'],
            ));
            initOrders = orders;
          });
        }
      }
      orders.sort((a, b) => b.timeCreated.compareTo(a.timeCreated));
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

  getOrderStatus(String status) {
    if (status == 'All') {
      resetToInitialList();
    } else {
      resetToInitialList();
      setState(() {
        orders = orders.where((element) => element.status == status).toList();
      });
    }
  }

  void resetToInitialList() {
    setState(() {
      orders = List.from(initOrders);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (MediaQuery.of(context).size.width >= 1100) const Gap(10),
          Align(
            alignment: MediaQuery.of(context).size.width >= 1100
                ? Alignment.bottomLeft
                : Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width >= 1100 ? 20 : 0),
              child: Column(
                children: [
                  Text(
                    'Management NIPL',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width >= 1100
                            ? 15
                            : 18),
                  ),
                  // TabBar untuk menggantikan dropdown
                  TabBar(
                    controller: _tabController,
                    labelColor: Colors.black,
                    tabs: const [
                      Tab(text: 'All'),
                      Tab(text: 'Tagihan'),
                      Tab(text: 'NIPL Aktif'),
                      Tab(text: 'Riwayat'),
                    ],
                    onTap: (index) {
                      switch (index) {
                        case 0:
                          getOrderStatus('All');
                          break;
                        case 1:
                          getOrderStatus('Tagihan');
                          break;
                        case 2:
                          getOrderStatus('NIPL Aktif');
                          break;
                        case 3:
                          getOrderStatus('Riwayat');
                          break;
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          if (MediaQuery.of(context).size.width >= 1100)
            const Divider(
              color: Color.fromARGB(255, 237, 235, 235),
              thickness: 1,
            ),
          const Gap(20),
          isLoading
              ? ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300]!,
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 150,
                        height: 20,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 100,
                        height: 16,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                ),
              );
            },
          )
              : orders.isEmpty
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/image/empty.jpg',
                  width: MediaQuery.of(context).size.width >= 1100
                      ? MediaQuery.of(context).size.width / 5
                      : MediaQuery.of(context).size.width / 1.5,
                  height: MediaQuery.of(context).size.width >= 1100
                      ? MediaQuery.of(context).size.width / 5
                      : MediaQuery.of(context).size.width / 1.5,
                  fit: BoxFit.contain,
                ),
              ),
              const Gap(10),
              const Text('Belum ada data NIPL'),
              const Gap(20),
            ],
          )
              : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: orders.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                OrderModel2 orderModel2 = orders[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(
                                255, 215, 214, 214))),
                    child: ListTile(
                      subtitle:
                      Text(timeago.format(orderModel2.timeCreated)),
                      leading: Text(
                        '$currency${Formatter().converter(orderModel2.total.toDouble())}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        'Order: ${orderModel2.orderID}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: InkWell(
                        onTap: () {
                          context
                              .go('/order-detail/${orderModel2.uid}');
                        },
                        child: Text(
                          'SEE DETAILS',
                          style: TextStyle(color: appColor),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
