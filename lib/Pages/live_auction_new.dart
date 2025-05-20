import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tunasauctionv2/app/Widgets/footer_widget.dart';

class LiveAuctionNew extends StatefulWidget {
  const LiveAuctionNew({super.key});

  @override
  State<LiveAuctionNew> createState() => _LiveAuctionNewState();
}

class _LiveAuctionNewState extends State<LiveAuctionNew> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Gap(20),
          _buildAuctionCard(),
          _buildLotNavigation(),
          const FooterWidget(),
        ],
      ),
    );
  }

  Widget _buildAuctionCard() {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 10),
            _buildCarDetails(),
            const SizedBox(height: 10),
            _buildBidSection(),
            const SizedBox(height: 10),
            _buildNPLSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "IBID SURABAYA",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            "LOT 73",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildCarDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://via.placeholder.com/150',
                width: 120,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "TOYOTA AGYA G 1.2 (2024)",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text("Harga Dasar: Rp 132.500.000"),
                  Text(
                    "Harga Sekarang: Rp 149.000.000",
                    style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBidSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Penawaran Saat Ini",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildBidItem("Rp 149.000.000"),
        _buildBidItem("Rp 148.500.000"),
        _buildBidItem("Rp 148.000.000"),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text("Tawar dengan kelipatan Rp 500.000"),
        ),
      ],
    );
  }

  Widget _buildNPLSection() {
    return Column(
      children: [
        const SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            hintText: "Pilih Nomor NPL",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text("Beli NPL"),
        ),
      ],
    );
  }

  Widget _buildBidItem(String price) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            price,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const Text("Penawar Lain", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildLotNavigation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text("LOT SEBELUMNYA", style: TextStyle(fontWeight: FontWeight.bold)),
          Text("LOT SELANJUTNYA", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
