import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tunasauctionv2/app/Widgets/footer_widget.dart';

class NewsDetailPage extends StatefulWidget {
  const NewsDetailPage({super.key});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('News Detail'),
      //   backgroundColor: Colors.green,
      // ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 800),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumb Navigation
                  Row(
                    children: [
                      _buildBreadcrumbLink(context, 'Home', '/'),
                      Text(' / '),
                      _buildBreadcrumbLink(context, 'Blog', '/blog'),
                      Text(' / '),
                      _buildBreadcrumbLink(context, 'GoFood', '/blog/gofood'),
                      Text(' / '),
                      Text(
                        'GoFood PAS Sekarang Jadi GoFood Hemat!',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),

                  // Title
                  Text(
                    'GoFood PAS Sekarang Jadi GoFood Hemat!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  // Subtitle
                  Text(
                    'GoFood / 09 Dec 2024',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),

                  SizedBox(height: 16),

                  // Featured Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      'https://cdn-site.gojek.com/uploads/HEMAT_Blog_1456x818_36d507eef0/HEMAT_Blog_1456x818_36d507eef0.jpg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),

                  SizedBox(height: 16),

                  // Content
                  Text(
                    "Mau makan puas tanpa ribet? Sekarang gak perlu mikirin ongkir, voucher, atau syarat tambahan! 🎉 GoFood PAS sekarang jadi GoFood Hemat—solusi hemat buat makan enak. Dengan harga maksimal hanya Rp22.000,00 udah termasuk ongkir, TANPA SYARAT. Gak perlu khawatir lagi tentang harga makanan dan pengiriman – semuanya inklusif dan ramah di kantong!",
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),

                  SizedBox(height: 16),

                  // Subsection Title
                  Text(
                    'Apa itu GoFood Hemat?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "GoFood Hemat menawarkan pengalaman pesan makanan yang tetap hemat dan praktis. Cukup pilih makanan, cemilan, atau minuman favoritmu, semua sudah termasuk ongkir dengan total biaya maksimal Rp22.000,00 saja. Berikut rincian harganya:",
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),

                  SizedBox(height: 8),

                  // List of Details
                  _buildBulletPoint('Harga Makanan: Semua menu maksimal Rp18.000,00'),
                  _buildBulletPoint('Ongkir & Biaya Penanganan: Maksimal Rp4.000,00'),

                  SizedBox(height: 16),

                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      'https://cdn-site.gojek.com/uploads/User_Journey_Blog_1456x818_a04a52b558/User_Journey_Blog_1456x818_a04a52b558.jpg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),

                  SizedBox(height: 16),

                  // Steps
                  Text(
                    'Cara Beli Makan Pakai GoFood Hemat',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  _buildNumberedPoint('Buka aplikasi Gojek dan klik ikon GoFood Hemat'),
                  _buildNumberedPoint('Pilih makanan, cemilan, atau minuman pilihan kamu dan lihat berbagai restoran dari setiap makanan'),
                  _buildNumberedPoint('Pilih makanan yang kamu inginkan dari restoran'),
                  _buildNumberedPoint('Lanjut ke pembayaran, dan total pembelian-mu Rp22.000,00 sudah termasuk ongkir, tanpa syarat!'),


                ],
              ),
            ),
          ),
        ),

      ),

    );

  }

  Widget _buildBreadcrumbLink(BuildContext context, String text, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Text(
        text,
        style: TextStyle(color: Colors.blue),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('• ', style: TextStyle(fontSize: 16)),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
      ],
    );
  }

  Widget _buildNumberedPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('1. ', style: TextStyle(fontSize: 16)),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
      ],
    );
  }
}
