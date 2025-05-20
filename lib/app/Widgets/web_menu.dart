// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tunasauctionv2/Model/constant.dart';
import 'package:tunasauctionv2/Providers/auth.dart';

class WebMenu extends StatefulWidget {
  final String path;
  const WebMenu({super.key, required this.path});

  @override
  State<WebMenu> createState() => _WebMenuState();
}

class _WebMenuState extends State<WebMenu> {
  @override
  void initState() {
    // getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        title: const Text('Profile'),
        tileColor: widget.path == '/profile' ? Colors.grey : null,
        leading: const Icon(Icons.person),
        onTap: () {
          context.go('/profile');
        },
      ),
      ListTile(
        title: const Text('Pengaturan Bank'),
        tileColor: widget.path == '/bank' ? Colors.grey : null,
        leading: const Icon(Icons.account_balance),
        onTap: () {
          context.go('/bank');
        },
      ),

      // ListTile(
      //   title: const Text('Wallet'),
      //   tileColor: widget.path == '/wallet' ? Colors.grey : null,
      //   leading: const Icon(Icons.wallet),
      //   onTap: () {
      //     context.go('/wallet');
      //   },
      // ),
      ListTile(
        title: const Text('Wishlist'),
        tileColor: widget.path == '/favorites' ? Colors.grey : null,
        leading: const Icon(Icons.favorite),
        onTap: () {
          context.go('/favorites');
        },
      ),
      ListTile(
        title: const Text('Riwayat Lelang'),
        tileColor: widget.path == '/orders' ? Colors.grey : null,
        leading: const Icon(Icons.gavel),
        onTap: () {
          context.go('/orders');
        },
      ),
      ListTile(
        title: const Text('Management NIPL'),
        tileColor: widget.path == '/nipl' ? Colors.grey : null,
        leading: const Icon(Icons.list),
        onTap: () {
          context.go('/nipl');
        },
      ),
      // ListTile(
      //   title: const Text('Inbox'),
      //   tileColor: widget.path == '/inbox' ? Colors.grey : null,
      //   leading: const Icon(Icons.notifications),
      //   onTap: () {
      //     context.go('/inbox');
      //   },
      // ),
      ListTile(
        title: const Text('Voucher'),
        tileColor: widget.path == '/voucher' ? Colors.grey : null,
        leading: const Icon(Icons.card_giftcard),
        onTap: () {
          context.go('/voucher');
        },
      ),
      ListTile(
        title: const Text('Inbox'),
        tileColor: widget.path == '/inbox' ? Colors.grey : null,
        leading: const Icon(Icons.notifications),
        onTap: () {
          context.go('/inbox');
        },
      ),
      // ListTile(
      //   title: const Text('Address Book'),
      //   tileColor: widget.path == '/delivery-addresses' ? Colors.grey : null,
      //   leading: const Icon(Icons.room),
      //   onTap: () {
      //     context.go('/delivery-addresses');
      //   },
      // ),
      TextButton(
          onPressed: () {
            AuthService().signOut(context);
          },
          child: Text(
            'LOG OUT',
            style: TextStyle(color: appColor),
          )),
      const Gap(20)
    ]);
  }
}
