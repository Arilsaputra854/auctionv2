import 'package:flutter/material.dart';
import '../../Model/products_model.dart';
import 'package:go_router/go_router.dart';

class FlashSaleProductCard extends StatelessWidget {
  final ProductsModel product;

  const FlashSaleProductCard({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: () {
            GoRouter.of(context).go('/products-all-category'); // Navigasi ke halaman live auction
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack( // Kembalikan Stack untuk menampilkan "LIVE" di atas gambar
              alignment: Alignment.topLeft,
              children: [
                Image.network(
                  'https://tunasauction.s3.ap-southeast-1.amazonaws.com/bastk/384b5bdbe32117213b87f8f5e0604be4_1722584708.jpg', // URL gambar hardcoded
                  height: 150,
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.purple,
                  child: const Text(
                    'LIVE',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'RABU, 8 JANUARI 2025',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Pontianak',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Mulai jam 13:00 s/d Selesai',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Lelang Kategori: MOBIL',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '146 Unit Siap Lelang',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}