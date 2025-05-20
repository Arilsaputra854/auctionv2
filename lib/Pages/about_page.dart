
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tunasauctionv2/app/Widgets/footer_widget.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  int _selectedIndex = 0;

  final List<Widget> widgets = [
    const LelangOnsiteWidget(),
    const LelangOnlineWidget(),
    const TitipLelangWidget(),
    const BeliNIPLWidget(),
    const PelunasanWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: MediaQuery.of(context).size.width >= 1100
                ? const EdgeInsets.only(left: 100, right: 100)
                : const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // List Tile di sebelah kiri
                MediaQuery.of(context).size.width >= 1100
                    ? Expanded(
                  flex: 3,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        title: const Text('Lelang Onsite'),
                        selected: _selectedIndex == 0,
                        onTap: () => _onItemTapped(0),
                      ),
                      ListTile(
                        title: const Text('Lelang Online'),
                        selected: _selectedIndex == 1,
                        onTap: () => _onItemTapped(1),
                      ),
                      ListTile(
                        title: const Text('Titip Lelang'),
                        selected: _selectedIndex == 2,
                        onTap: () => _onItemTapped(2),
                      ),
                      ListTile(
                        title: const Text('Beli NIPL'),
                        selected: _selectedIndex == 3,
                        onTap: () => _onItemTapped(3),
                      ),
                      ListTile(
                        title: const Text('Pelunasan'),
                        selected: _selectedIndex == 4,
                        onTap: () => _onItemTapped(4),
                      ),
                    ],
                  ),
                )
                    : const SizedBox(),

                // Konten di sebelah kanan
                Expanded(
                  flex: 9,
                  child: Column(
                    children: [
                      const Gap(50),
                      widgets[_selectedIndex],
                      const Gap(50),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Gap(20),
          const FooterWidget()
        ],
      ),
    );
  }
}

// Widget untuk Lelang Onsite
class LelangOnsiteWidget extends StatelessWidget {
  const LelangOnsiteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Variabel untuk menentukan posisi gambar
    bool isImageLeft = true;

    return Column(
      children: [
        AboutContentWidget(
          title: 'CARI KENDARAAN',
          description:
          'Cari kendaraan yang diinginkan di situs Tunas Auction di menu Open House lalu cek Jadwal Lelang.',
          imagePath:
          'assets/image/undraw_undraw_shopping_bags_2ude_-1-_mnw3.svg',
          isImageLeft: isImageLeft,
        ),
        const Gap(20),
        AboutContentWidget(
          title: 'Cek Detail Kendaraan di Lokasi Lelang',
          description:
          'Lakukan cek fisik kendaraan yang dipilih beserta dokumennya saat open house di lokasi lelang Tunas.',
          imagePath: 'assets/image/undraw_undraw_shopping.svg',
          isImageLeft: !isImageLeft, // ganti posisi
        ),
        const Gap(20),
        AboutContentWidget(
          title: 'Registrasi dan Beli NIPL',
          description:
          'Lakukan pendaftaran dengan mengisi data diri dan lakukan pembelian NIPL di situs ini. Pembayaran NIPL bisa dilakukan melalui Bank Transfer.',
          imagePath: 'assets/image/undraw_undraw_shopping.svg',
          isImageLeft: isImageLeft, // ganti posisi
        ),
        const Gap(20),
        AboutContentWidget(
          title: 'Ikut lelang',
          description:
          'Setelah terdaftar sebagai peserta lelang, ikuti proses lelang langsung di tempat pelelangan. Tawar kendaraan yang diinginkan.',
          imagePath: 'assets/image/undraw_undraw_shopping.svg',
          isImageLeft: !isImageLeft, // ganti posisi
        ),
        const Gap(20),
        AboutContentWidget(
          title: 'Pelunasan atau Pengembalian Biaya',
          description:
          'Pemenang lelang wajib melakukan pelunasan sisa pembayaran paling lambat 3 hari kerja setelah lelang. Peserta yang kalah akan mendapat pengembalian 100% biaya pembelian NIPL ke nomor rekening terdaftar paling lambat 3 hari kerja setelah lelang.',
          imagePath: 'assets/image/undraw_undraw_shopping.svg',
          isImageLeft: isImageLeft, // ganti posisi
        ),
        const Gap(20),
        AboutContentWidget(
          title: 'Ambil Kendaraan',
          description:
          'Bila telah melakukan pelunasan pembayaran, peserta berhak mengambil kendaraan beserta dokumennya.',
          imagePath: 'assets/image/undraw_undraw_shopping.svg',
          isImageLeft: !isImageLeft, // ganti posisi
        ),
      ],
    );
  }
}

// Widget untuk Lelang Online
class LelangOnlineWidget extends StatelessWidget {
  const LelangOnlineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AboutContentWidget(
          title: 'CARI KENDARAAN',
          description:
          'Cari kendaraan yang diinginkan di situs Tunas Auction di menu Open House lalu cek Jadwal Lelang.',
          imagePath:
          'assets/image/undraw_undraw_shopping_bags_2ude_-1-_mnw3.svg',
          isImageLeft: true, // Tambahkan parameter isImageLeft
        ),
        const Gap(20),
        AboutContentWidget(
          title: 'Cek Detail Kendaraan via Website',
          description:
          'Periksa spesifikasi dan detail kendaraan di website Tunas Auction.',
          imagePath: 'assets/image/undraw_undraw_shopping.svg',
          isImageLeft: false, // Tambahkan parameter isImageLeft
        ),
        const Gap(20),
        AboutContentWidget(
          title: 'Registrasi dan Beli NIPL',
          description:
          'Lakukan pendaftaran dengan mengisi data diri dan lakukan pembelian NIPL di situs ini. Pembayaran NIPL bisa dilakukan melalui Bank Transfer.',
          imagePath: 'assets/image/undraw_undraw_shopping.svg',
          isImageLeft: true, // Tambahkan parameter isImageLeft
        ),
        const Gap(20),
        AboutContentWidget(
          title: 'Pilih Jadwal Lelang',
          description:
          'Pilih kendaraan yang diinginkan. Informasi tenggat waktu lelang pada bagian informasi kendaraan.',
          imagePath: 'assets/image/undraw_undraw_shopping.svg',
          isImageLeft: false, // Tambahkan parameter isImageLeft
        ),
        const Gap(20),
        AboutContentWidget(
          title: 'Ikuti lelang Online',
          description:
          'Lakukan penawaran atau bidding secara online di Live Auction. Tawar harga sesuai dengan keinginan.',
          imagePath: 'assets/image/undraw_undraw_shopping.svg',
          isImageLeft: true, // Tambahkan parameter isImageLeft
        ),
        const Gap(20),
        AboutContentWidget(
          title: 'Pelunasan atau Pengembalian Biaya',
          description:
          'Pemenang lelang wajib melakukan pelunasan sisa pembayaran paling lambat 5 hari kerja setelah lelang. Peserta yang kalah akan mendapat pengembalian 100% biaya pembelian NIPL ke nomor rekening terdaftar paling lambat 3 hari kerja setelah lelang.',
          imagePath: 'assets/image/undraw_undraw_shopping.svg',
          isImageLeft: false, // Tambahkan parameter isImageLeft
        ),
        const Gap(20),
        AboutContentWidget(
          title: 'Ambil Kendaraan',
          description:
          'Bila telah melakukan pelunasan pembayaran, peserta berhak mengambil kendaraan beserta dokumennya.',
          imagePath: 'assets/image/undraw_undraw_shopping.svg',
          isImageLeft: true, // Tambahkan parameter isImageLeft
        ),
      ],
    );
  }
}

// Widget untuk Titip Lelang
class TitipLelangWidget extends StatelessWidget {
  const TitipLelangWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AboutContentWidget(
          title: 'Isi Formulir Titip Lelang di Website Tunas Auction',
          description:
          'Lakukan pendaftaran dengan mengisi data diri dan informasi kendaraan yang ingin dititipkan.',
          imagePath: 'assets/image/undraw_undraw_car_sales.svg',
          isImageLeft: true, // Tambahkan parameter isImageLeft
        ),
        const Gap(20),
        AboutContentWidget(
          title: 'Pilih Jadwal Inspeksi Kendaraan',
          description:
          'Tentukan jadwal dan lokasi pool Tunas Auction terdekat untuk inspeksi kendaraan yang akan dilelang.',
          imagePath: 'assets/image/undraw_undraw_car_dealership.svg',
          isImageLeft: false, // Tambahkan parameter isImageLeft
        ),
        AboutContentWidget(
          title: 'Datang ke pool Tunas Auction untuk Proses Inspeksi',
          description:
          'Bawa kendaraan sesuai dengan jadwal dan lokasi inspeksi yang telah dipilih. Hasil inspeksi beserta rekomendasi harga langsung dapat diketahui.',
          imagePath: 'assets/image/undraw_undraw_car_dealership.svg',
          isImageLeft: true, // Tambahkan parameter isImageLeft
        ),
      ],
    );
  }
}

// Widget untuk Beli NIPL
class BeliNIPLWidget extends StatelessWidget {
  const BeliNIPLWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AboutContentWidget(
          title: 'Pilih Objek dan Jadwal Lelang',
          description:
          'Lakukan pilihan objel/kendaraan dilanjutkan dengan memilih jadwal lelang.',
          imagePath: 'assets/image/undraw_mobile_payments_re_7udl.svg',
          isImageLeft: true, // Tambahkan parameter isImageLeft
        ),
        const Gap(20),
        AboutContentWidget(
          title: 'Masukkan Jumlah NIPL yang akan dibeli',
          description: 'Tentukan jumlah pebelian NIPL sesuai keinginan.',
          imagePath: 'assets/image/undraw_undraw_shopping_bags_2ude_-1-_mnw3.svg',
          isImageLeft: false, // Tambahkan parameter isImageLeft
        ),
        const Gap(20),
        AboutContentWidget(
          title: 'Cek Total Tagihan NIPL yang harus dibayar',
          description: 'Cek transaksi pembelian NIPL pada tagihan.',
          imagePath: 'assets/image/undraw_undraw_wallet.svg',
          isImageLeft: true, // Tambahkan parameter isImageLeft
        ),
        const Gap(20),
        AboutContentWidget(
          title: 'Lakukan Pembayaran',
          description:
          'Lakukan pembayaran NIPL melalui channel pembayaran yang tersedia.',
          imagePath: 'assets/image/undraw_undraw_wallet.svg',
          isImageLeft: false, // Tambahkan parameter isImageLeft
        ),
      ],
    );
  }
}

// Widget untuk Pelunasan
class PelunasanWidget extends StatelessWidget {
  const PelunasanWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AboutContentWidget(
          title: 'Cek Sisa Tagihan Pelunasan',
          description:
          'Lakukan pengecekan informasi tagihan di website Tunas Auction atau cek email yang kami kirimkan yang berisi informasi detail pembayaran beserta informasi Rekening Tunas Auction.',
          imagePath: 'assets/image/undraw_empty_cart_co35.svg',
          isImageLeft: true, // Tambahkan parameter isImageLeft
        ),
        const Gap(20),
        AboutContentWidget(
          title: 'Pembayaran/Pelunasan',
          description: 'lakukan pembayaran tagihan sesuai nominal yang dikirimkan.',
          imagePath: 'assets/image/undraw_undraw_payment_methods.svg',
          isImageLeft: false, // Tambahkan parameter isImageLeft
        ),
      ],
    );
  }
}

// Widget reusable untuk menampilkan konten
class AboutContentWidget extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final bool isImageLeft;

  const AboutContentWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.isImageLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1100
        ? Row(
      children: [
        // Gunakan isImageLeft untuk menentukan posisi elemen
        if (isImageLeft) ...[
          Expanded(
            flex: 6,
            child: SvgPicture.asset(
              imagePath,
              height: 300,
              width: double.infinity,
            ),
          ),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const Gap(10),
                Text(description),
              ],
            ),
          ),
        ] else ...[
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const Gap(10),
                Text(description),
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: SvgPicture.asset(
              imagePath,
              height: 300,
              width: double.infinity,
            ),
          ),
        ],
      ],
    )
        : Column(
      children: [
        SvgPicture.asset(
          imagePath,
          height: 300,
          width: double.infinity,
        ),
        const Gap(10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const Gap(10),
            Text(description),

          ],

        ),

      ],

    );


  }
}