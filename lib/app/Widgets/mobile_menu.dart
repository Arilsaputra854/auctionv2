import 'package:adaptive_theme/adaptive_theme.dart';
// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tunasauctionv2/Model/categories.dart';
import 'package:tunasauctionv2/app/Widgets/cat_image_widget.dart';

import '../../Model/constant.dart';
import '../../Providers/auth.dart';
import 'collections_expanded_tile.dart';

class MobileMenuWidget extends StatefulWidget {
  final bool isLogged;
  final List<CategoriesModel> cats;
  final Function moveToOrder;
  const MobileMenuWidget(
      {super.key,
      required this.isLogged,
      required this.cats,
      required this.moveToOrder});

  @override
  State<MobileMenuWidget> createState() => _MobileMenuWidgetState();
}

class _MobileMenuWidgetState extends State<MobileMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView(children: [
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Image.asset(
                color: AdaptiveTheme.of(context).mode.isDark == true
                    ? Colors.white
                    : null,
                'assets/image/tunas auction.png',
                scale: 5,
              ),
            ),
            IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(
                  Icons.close,
                  size: 30,
                  color: appColor,
                ))
          ],
        ),
        const Divider(color: Colors.grey),
        const Gap(20),
        ListTile(
          onTap: () {
            if (widget.isLogged == true) {
              context.go('/profile');
              context.pop();
            } else {
              context.go('/login');
            }
          },
          title: const Text('Profile'),
          leading: const Icon(Icons.person),
          trailing: const Icon(Icons.chevron_right),
        ),
        ListTile(
          onTap: () {
            if (widget.isLogged == true) {
              context.go('/bank');
              context.pop();
            } else {
              context.go('/login');
            }
          },
          title: const Text('Pengaturan Bank'),
          leading: const Icon(Icons.account_balance),
          trailing: const Icon(Icons.chevron_right),
        ),
        ListTile(
          onTap: () {
            if (widget.isLogged == true) {
              context.go('/nipl');
              context.pop();
            } else {
              context.go('/login');
            }
          },
          title: const Text('Management NIPL'),
          leading: const Icon(Icons.list),
          trailing: const Icon(Icons.chevron_right),
        ),
        //
        // ListTile(
        //   onTap: () {
        //     if (widget.isLogged == true) {
        //       context.go('/wallet');
        //       context.pop();
        //     } else {
        //       context.go('/login');
        //     }
        //   },
        //   title: const Text('Wallet'),
        //   leading: const Icon(Icons.wallet),
        //   trailing: const Icon(Icons.chevron_right),
        // ),
        // ListTile(
        //   onTap: () {
        //       if (widget.isLogged == true) {
        //       context.go('/orders');
        //       context.pop();
        //     } else {
        //       context.go('/login');
        //     }
        //   },
        //   title: const Text('Orders'),
        //   leading: const Icon(Icons.list),
        //   trailing: const Icon(Icons.chevron_right),
        // ),
        ListTile(
          onTap: () {
            if (widget.isLogged == true) {
              context.go('/favorites');
              context.pop();
            } else {
              context.go('/login');
            }
          },
          title: const Text('Wishlist'),
          leading: const Icon(Icons.favorite),
          trailing: const Icon(Icons.chevron_right),
        ),
        ListTile(
          onTap: () {
            if (widget.isLogged == true) {
              context.go('/orders');
              context.pop();
            } else {
              context.go('/login');
            }
          },
          title: const Text('Riwayat Lelang'),
          leading: const Icon(Icons.card_giftcard),
          trailing: const Icon(Icons.chevron_right),
        ),
        ListTile(
          onTap: () {
            if (widget.isLogged == true) {
              context.go('/voucher');
              context.pop();
            } else {
              context.go('/login');
            }
          },
          title: const Text('Voucher'),
          leading: const Icon(Icons.gavel),
          trailing: const Icon(Icons.chevron_right),
        ),
        ListTile(
          onTap: () {
            if (widget.isLogged == true) {
              context.go('/inbox');
              context.pop();
            } else {
              context.go('/login');
            }
          },
          title: const Text('Inbox'),
          leading: const Icon(Icons.notifications),
          trailing: const Icon(Icons.chevron_right),
        ),
        // ListTile(
        //   onTap: () {
        //     if (widget.isLogged == true) {
        //       context.go('/delivery-addresses');
        //       context.pop();
        //     } else {
        //       context.go('/login');
        //     }
        //   },
        //   title: const Text('Address Book'),
        //   leading: const Icon(Icons.room),
        //   trailing: const Icon(Icons.chevron_right),
        // ),
        // ListTile(
        //   onTap: () {
        //     if (widget.isLogged == true) {
        //       context.go('/track-order');
        //       context.pop();
        //     } else {
        //       context.go('/login');
        //     }
        //   },
        //   title: const Text('Track Order'),
        //   leading: const Icon(Icons.room),
        //   trailing: const Icon(Icons.chevron_right),
        // ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Text(
        //     'Categories',
        //     style: TextStyle(fontWeight: FontWeight.bold, color: appColor),
        //   ),
        // ),
        // ListView.builder(
        //     physics: const BouncingScrollPhysics(),
        //     shrinkWrap: true,
        //     itemCount: widget.cats.length,
        //     itemBuilder: (context, index) {
        //       CategoriesModel categoriesModel = widget.cats[index];
        //       return ExpansionTile(
        //         leading: SizedBox(
        //           height: 50,
        //           width: 50,
        //           child: Padding(
        //             padding: const EdgeInsets.all(5.0),
        //             child: ClipRRect(
        //               borderRadius: BorderRadius.circular(5),
        //               child: CatImageWidget(
        //                 url: categoriesModel.image,
        //                 boxFit: 'cover',
        //               ),
        //             ),
        //           ),
        //         ),
        //         title: Text(categoriesModel.category),
        //         children: [
        //           CollectionsExpandedTile(
        //             cat: categoriesModel.category,
        //           )
        //         ],
        //       );
        //     }),
        // const Divider(
        //   color: Colors.grey,
        //   thickness: 2,
        // ),
        // const Gap(10),
        // SwitchListTile(
        //   title: const Text('Theme'),
        //   value: AdaptiveTheme.of(context).mode.isDark,
        //   onChanged: (value) {
        //     if (value) {
        //       AdaptiveTheme.of(context).setDark();
        //     } else {
        //       AdaptiveTheme.of(context).setLight();
        //     }
        //   },
        // ),
        widget.isLogged == true
            ? ListTile(
                onTap: () {
                  AuthService().signOut(context);
                  context.pop();
                },
                title: const Text('Logout'),
                leading: const Icon(Icons.logout),
                // trailing: const Icon(Icons.chevron_right),
              )
            : ListTile(
                onTap: () {
                  context.go('/login');
                },
                title: const Text('Login'),
                leading: const Icon(Icons.login),
                // trailing: const Icon(Icons.chevron_right),
              ),
      ]),
    );
  }
}
