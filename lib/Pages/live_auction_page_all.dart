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
import '../app/Widgets/vendor_widget_main.dart';


class LiveAuctionsPage extends StatefulWidget {
  const LiveAuctionsPage({super.key});

  @override
  State<LiveAuctionsPage> createState() => _LiveAuctionsPageState();
}

class _LiveAuctionsPageState extends State<LiveAuctionsPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(20),
            Center(
              child: Column(
                children: [
                  Text(
                    'Live Auction',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Gap(10),
                  Text(
                    'Pilih maksimum 4 jadwal lelang yang ingin Anda ikuti',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
            ),
            const Gap(20),
            _buildAuctionNavPills(),
            const Gap(20),
            _buildLocationDropdown(),
            const Gap(20),
            _buildSectionTitle('Sedang Berlangsung'),
            _buildUpcomingAuctions(screenWidth),
            const Gap(20),
            _buildSectionTitle('Akan Datang'),
            _buildUpcomingAuctions(screenWidth),
            const Gap(20),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildAuctionNavPills() {
    return Center(
      child: Wrap(
        spacing: 10,
        children: [
          _buildNavPill('Semua', false),
          _buildNavPill('Mobil', true),
          _buildNavPill('Motor', false),
          _buildNavPill('HVE', false),
        ],
      ),
    );
  }

  Widget _buildNavPill(String label, bool isActive) {
    return ChoiceChip(
      label: Text(label),
      selected: isActive,
      onSelected: (bool selected) {},
      backgroundColor: Colors.grey[200],
      selectedColor: Colors.blueAccent,
    );
  }

  Widget _buildLocationDropdown() {
    return SizedBox(
      width: 200,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Lokasi',
          border: OutlineInputBorder(),
        ),
        items: [
          DropdownMenuItem(value: 'Semua Lokasi', child: Text('Semua Lokasi')),
          DropdownMenuItem(value: 'IBID SURABAYA', child: Text('IBID SURABAYA')),
          DropdownMenuItem(value: 'IBID JAKARTA', child: Text('IBID JAKARTA')),
        ],
        onChanged: (value) {},
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingAuctions(double screenWidth) {
    int crossAxisCount = screenWidth > 1200
        ? 4
        : screenWidth > 800
        ? 3
        : 1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 10 / 4,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return _buildAuctionCard(context);
        },
      ),
    );
  }

  Widget _buildAuctionCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go('/live-auctions'); // Ubah navigasi ke direct biasa
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tunas Auction Bekasi',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const Gap(4),
              Text('30 Jan', style: TextStyle(fontSize: 15)),
              Text('13:00 WIB', style: TextStyle(fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }
}
