import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class GuidesSliderWIdget extends StatefulWidget {
  const GuidesSliderWIdget({super.key});

  @override
  State<GuidesSliderWIdget> createState() => _GuidesSliderWIdgetState();
}

class _GuidesSliderWIdgetState extends State<GuidesSliderWIdget> {
  PageController? pg;
  int currentIndex = 0;

  List<Map<String, dynamic>> ourValue = [
    {
      'title': 'Crediblity',
      'desc': 'Harga Jual Dan Beli Kendaraan Yang Menguntungkan',
      'level': const Icon(Icons.handshake, color: Colors.white),
    },
    {
      'title': 'Return & Refund',
      'desc': 'Jaringan Lelang Luas Lebih dari 30 kota',
      'level': const Icon(Icons.monetization_on, color: Colors.white),
    },
    {
      'title': 'Secure Payment',
      'desc': 'Dengan jaringan partner terpercaya memastikan kendaraan terjamin',
      'level': const Icon(Icons.security, color: Colors.white),
    },
    {
      'title': '24/7 Support',
      'desc': 'Didukung aplikasi terbaik dapat dilakukan secara online dan offline',
      'level': const Icon(Icons.support, color: Colors.white),
    },
  ];

  @override
  void initState() {
    pg = PageController(initialPage: 0);
    pg!.addListener(() {
      setState(() {
        currentIndex = pg!.page!.toInt();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Judul "Mengapa Tunas Auction"
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            'Mengapa Tunas Auction',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AdaptiveTheme.of(context).mode.isDark ? Colors.white : Colors.black,
            ),
          ),
        ),
        // Container untuk gambar latar belakang dan slider
        Container(
          height: 500, // Tinggi container
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image/backgroundmengapa.png'), // Gambar latar belakang
              fit: BoxFit.cover, // Sesuaikan gambar dengan container
            ),
          ),
          child: Stack(
            children: [
              // Slider yang menimpa sebagian gambar
              Positioned(
                top: 0, // Pindahkan slider ke bagian atas
                left: 0,
                right: 0,
                child: Container(
                  height: 200, // Tinggi slider
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8), // Latar belakang semi-transparan
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: MediaQuery.of(context).size.width >= 1100
                      ? _buildDesktopView()
                      : _buildMobileView(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Tampilan untuk desktop
  Widget _buildDesktopView() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            flex: 6,
            child: ListTile(
              minLeadingWidth: 100,
              leading: Icon(
                Icons.handshake,
                size: 40,
              ),
              title: Text(
                'Harga Menguntungkan',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Harga Jual Dan Beli Kendaraan Yang Menguntungkan'),
            ),
          ),
          Flexible(
            flex: 6,
            child: ListTile(
              minLeadingWidth: 100,
              leading: Icon(Icons.location_on, size: 40),
              title: Text(
                'Jaringan Luas',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Jaringan Lelang Luas Lebih dari 30 kota'),
            ),
          ),
          Flexible(
            flex: 6,
            child: ListTile(
              minLeadingWidth: 100,
              leading: Icon(Icons.security, size: 40),
              title: Text(
                'Partner Terpecaya',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Dengan jaringan partner terpercaya memastikan kendaraan terjamin'),
            ),
          ),
          Flexible(
            flex: 6,
            child: ListTile(
              minLeadingWidth: 100,
              leading: Icon(Icons.support, size: 40),
              title: Text(
                'Full Support',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  'Didukung aplikasi terbaik dapat dilakukan secara online dan offline'),
            ),
          ),
        ],
      ),
    );
  }

  // Tampilan untuk mobile
  Widget _buildMobileView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            height: 330,
            width: double.infinity,
            child: PageView.builder(
              itemCount: ourValue.length,
              onPageChanged: (e) {
                setState(() {
                  currentIndex = e;
                });
              },
              controller: pg,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(0.9), // Latar belakang semi-transparan
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(14, 51, 184, 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: ourValue[index]['level'],
                          ),
                        ),
                        const Gap(20),
                        Text(
                          ourValue[index]['title'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black, // Warna teks
                          ),
                        ),
                        const Gap(20),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Text(
                            ourValue[index]['desc'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black, // Warna teks
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              ourValue.length,
                  (index) => Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: currentIndex == index ? Colors.red : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}