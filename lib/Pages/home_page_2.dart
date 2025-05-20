import 'dart:math';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:go_router/go_router.dart';
import 'package:tunasauctionv2/Model/feeds.dart';
import 'package:tunasauctionv2/Providers/auth.dart';
// import 'package:tunasauctionv2/app/Widgets/cat_image_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:tunasauctionv2/app/Widgets/footer_widget.dart';
import 'package:tunasauctionv2/app/Widgets/hot_deals_widget_new.dart';
// import '../../Model/constant.dart';
import '../app/Widgets/flash_sales_widget_new.dart';
import '../app/Widgets/guide_slider.dart';
import '../app/Widgets/last_banner_widget.dart';
import '../app/Widgets/new_categories_widget.dart';
import '../app/Widgets/new_offers.dart';
import '../app/Widgets/new_slider.dart';
import '../app/Widgets/products_by_cat_home_page_widget.dart';
import 'package:tunasauctionv2/app/Widgets/article_card.dart'
    as ArticleCardWidget;
import 'package:tunasauctionv2/app/Widgets/article_data.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class HomePage2 extends StatefulWidget {
  const HomePage2({
    super.key,
  });

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  bool isLoaded = true;
  String banner1 = 'assets/image/slider_open_house1.png';
  String banner2 = 'assets/image/slider_open_house2.png';
  List<String> feeds = [
    'assets/image/slider_open_house1.png',
    'assets/image/slider_open_house2.png',
    'assets/image/slider_open_house3.png',
  ];
  String _selectedMerk = "Semua Merk";
  String _selectedSeri = "Semua Seri";
  String _selectedTahun = "Semua Tahun";
  String _selectedHarga = "Semua Harga";

  getBanner() {
    setState(() {
      isLoaded = true;
    });

    // Randomly select two banners from the local asset list
    Random random = Random();
    setState(() {
      banner1 = feeds[random.nextInt(feeds.length)];
      banner2 = feeds[random.nextInt(feeds.length)];
      isLoaded = false;
    });

    // Menampilkan dialog setelah banner1 berhasil diinisialisasi
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: EdgeInsets.zero,
            child: LayoutBuilder(
              builder: (context, constraints) {
                double dialogWidth = constraints.maxWidth > 600
                    ? 600
                    : constraints.maxWidth * 0.8;
                double dialogHeight = constraints.maxWidth > 600
                    ? 600
                    : constraints.maxHeight * 0.5;

                return SizedBox(
                  width: dialogWidth,
                  height: dialogHeight,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/image/popup.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      );
    });
  }

  @override
  void initState() {
    getBanner();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Gunakan kIsWeb untuk menentukan platform
    final isWeb = kIsWeb;
    // Untuk mobile, kita cek lebar layar atau jika bukan web
    final isMobile = !isWeb || MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: AdaptiveTheme.of(context).mode.isDark == true
          ? null
          : const Color.fromARGB(255, 247, 240, 240),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width >= 1100
                  ? MediaQuery.of(context).size.height / 2
                  : MediaQuery.of(context).size.height / 3,
              width: double.infinity,
              child: const NewSliderWidget(),
            ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: isMobile
                  ? Column(
                      children: [
                        FilterWidget(
                          selectedMerk: _selectedMerk,
                          selectedSeri: _selectedSeri,
                          selectedTahun: _selectedTahun,
                          selectedHarga: _selectedHarga,
                          onMerkChanged: (value) {
                            setState(() {
                              _selectedMerk = value;
                            });
                          },
                          onSeriChanged: (value) {
                            setState(() {
                              _selectedSeri = value;
                            });
                          },
                          onTahunChanged: (value) {
                            setState(() {
                              _selectedTahun = value;
                            });
                          },
                          onHargaChanged: (value) {
                            setState(() {
                              _selectedHarga = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        const JadwalLelangWidget(),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: FilterWidget(
                            selectedMerk: _selectedMerk,
                            selectedSeri: _selectedSeri,
                            selectedTahun: _selectedTahun,
                            selectedHarga: _selectedHarga,
                            onMerkChanged: (value) {
                              setState(() {
                                _selectedMerk = value;
                              });
                            },
                            onSeriChanged: (value) {
                              setState(() {
                                _selectedSeri = value;
                              });
                            },
                            onTahunChanged: (value) {
                              setState(() {
                                _selectedTahun = value;
                              });
                            },
                            onHargaChanged: (value) {
                              setState(() {
                                _selectedHarga = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 3,
                          child: const JadwalLelangWidget(),
                        ),
                      ],
                    ),
            ),
            const Gap(40),
            const LastBannerWidget(),
            const Gap(40),
            const HotDealsWidgetNew(),
            const Gap(40),
            const NewOffers(),
            // if (isWeb) const Gap(40),
            // if (isWeb) Padding(
            //   padding: MediaQuery.of(context).size.width >= 1100
            //       ? const EdgeInsets.only(left: 50, right: 50)
            //       : EdgeInsets.zero,
            //   child: const GuidesSliderWIdget(),
            // ),
            const Gap(40),
            if (isWeb) const TestimonialWidget(),
            const Gap(40),
            if (isWeb) const FAQAndVideoWidget(),
            // Mengganti kode pada bagian Informasi Terkini untuk menambahkan padding yang konsisten
            const Gap(40),
            if (isWeb)
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal:
                        MediaQuery.of(context).size.width >= 1100 ? 32 : 16),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/image/Newss.png',
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Informasi Terkini",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

            if (isWeb) const Gap(20),
            if (isWeb)
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal:
                        MediaQuery.of(context).size.width >= 1100 ? 32 : 16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        MediaQuery.of(context).size.width > 1100 ? 4 : 1,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 4 / 3.5,
                  ),
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return ArticleCardWidget.ArticleCard(
                      title: article.title,
                      imageAsset: article.imageAsset,
                      category: article.category,
                      date: article.date,
                    );
                  },
                ),
              ),
            if (isWeb) const Gap(32),
            // Hanya tampilkan footer di web
            if (isWeb) const FooterWidget(),
          ],
        ),
      ),
      // Jangan tampilkan bottomNavigationBar sama sekali di scaffold ini
      // karena sudah ada di scaffold utama
    );
  }
}

class TestimonialWidget extends StatelessWidget {
  const TestimonialWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image/email.png', // Replace with your email icon asset
              width: 32,
              height: 32,
            ),
            const SizedBox(width: 10),
            const Text(
              "Testimoni",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Gap(20),
        Wrap(
          spacing: 20, // Horizontal spacing between cards
          runSpacing: 20, // Vertical spacing between cards
          alignment: WrapAlignment.center,
          children: const [
            TestimonialCard(
              name: 'Sung Jin Woo',
              location: 'Tunas Auction Palembang',
              date: '25 Februari 2025',
              feedback:
                  'Pelayanannya sangat bagus dan unit lelang update dan tampilan dari aplikasinya sangat user friendly',
              imageAsset: 'assets/image/testimonial1.jpeg',
            ),
            TestimonialCard(
              name: 'Kasalamat',
              location: 'Tunas Auction Palembang',
              date: '25 Februari 2025',
              feedback:
                  'Pelayanannya sangat bagus dan unit lelang update dan tampilan dari aplikasinya sangat user friendly',
              imageAsset: 'assets/image/testimonial2.jpeg',
            ),
            TestimonialCard(
              name: 'Kasalamat',
              location: 'Tunas Auction Medan',
              date: '25 Februari 2025',
              feedback:
                  'Pelayanannya sangat bagus dan unit lelang update dan tampilan dari aplikasinya sangat user friendly',
              imageAsset: 'assets/image/testimonial3.jpeg',
            ),
          ],
        ),
      ],
    );
  }
}

class TestimonialCard extends StatelessWidget {
  final String name;
  final String location;
  final String date;
  final String feedback;
  final String imageAsset;

  const TestimonialCard({
    Key? key,
    required this.name,
    required this.location,
    required this.date,
    required this.feedback,
    required this.imageAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 2,
      child: Container(
        width: 380,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section with profile picture, name, stars, and location
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black12,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile picture
                  CircleAvatar(
                    backgroundImage: AssetImage(imageAsset),
                    radius: 24,
                  ),
                  const SizedBox(width: 12),
                  // Name and stars
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: List.generate(
                          5,
                          (index) => const Icon(
                            Icons.star,
                            color: Colors.green,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Vertical divider
                  const Spacer(),
                  Container(
                    height: 50,
                    width: 1,
                    color: Colors.black12,
                  ),
                  const SizedBox(width: 12),
                  // Location and date
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        location,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Testimonial text
            Container(
              height: 150, // Menambahkan fixed height untuk area feedback
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Text(
                  feedback,
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FAQWidget extends StatefulWidget {
  const FAQWidget({Key? key}) : super(key: key);

  @override
  State<FAQWidget> createState() => _FAQWidgetState();
}

class _FAQWidgetState extends State<FAQWidget> {
  // Track which FAQ items are expanded
  final List<bool> _expandedItems = List.generate(faqList.length, (_) => false);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.shade100,
              ),
              padding: const EdgeInsets.all(10),
              child: const Icon(
                Icons.question_mark,
                color: Colors.blue,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "FAQ",
              style: TextStyle(
                fontSize: isMobile ? 18 : 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: () {
                // TODO: Navigate to full FAQ page
              },
              icon: const Icon(Icons.chevron_right, color: Colors.blue),
              label: const Text(
                "FAQ",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: faqList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
                child: ExpansionTile(
                  onExpansionChanged: (expanded) {
                    setState(() {
                      _expandedItems[index] = expanded;
                    });
                  },
                  trailing: Icon(
                    _expandedItems[index]
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  title: Text(
                    faqList[index].question,
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 16,
                      fontWeight: FontWeight.w500,
                      color:
                          _expandedItems[index] ? Colors.blue : Colors.black87,
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Text(
                        faqList[index].answer,
                        style: TextStyle(
                          fontSize: isMobile ? 12 : 14,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class VideoTutorialWidget extends StatefulWidget {
  const VideoTutorialWidget({Key? key}) : super(key: key);

  @override
  State<VideoTutorialWidget> createState() => _VideoTutorialWidgetState();
}

class _VideoTutorialWidgetState extends State<VideoTutorialWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId:
          'AaU0c15cnjk', // Replace with your actual YouTube video ID
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        showLiveFullscreenButton: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red.shade100,
              ),
              padding: const EdgeInsets.all(10),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.red,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "Video kami",
              style: TextStyle(
                fontSize: isMobile ? 18 : 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: () {
                // TODO: Navigate to videos page
              },
              icon: const Icon(Icons.chevron_right, color: Colors.red),
              label: const Text(
                "Video kami",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.red,
            progressColors: const ProgressBarColors(
              playedColor: Colors.red,
              handleColor: Colors.redAccent,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class FAQAndVideoWidget extends StatelessWidget {
  const FAQAndVideoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isTablet = MediaQuery.of(context).size.width < 1100 &&
        MediaQuery.of(context).size.width >= 600;

    // Helper function to create container with padding
    Widget _buildSectionContainer(Widget child) {
      return Container(
        padding: EdgeInsets.all(isMobile ? 16 : 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
        ),
        child: child,
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 32),
      child: isMobile || isTablet
          ? Column(
              children: [
                _buildSectionContainer(const FAQWidget()),
                const SizedBox(height: 24),
                _buildSectionContainer(const VideoTutorialWidget()),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildSectionContainer(const FAQWidget()),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: _buildSectionContainer(const VideoTutorialWidget()),
                ),
              ],
            ),
    );
  }
}

// Keep the FAQ class and list data as is
class FAQ {
  final String question;
  final String answer;

  FAQ({required this.question, required this.answer});
}

final List<FAQ> faqList = [
  FAQ(
    question: "Apakah lelang di Tunas Auction aman dan terpercaya?",
    answer:
        "Ya, lelang di Tunas Auction aman dan terpercaya. Tunas Auction telah mendapatkan izin dari Kementerian Perdagangan dan diawasi oleh Otoritas Jasa Keuangan (OJK).",
  ),
  FAQ(
    question:
        "Berapa lama waktu maksimal pelunasan untuk unit yang dimenangkan?",
    answer:
        "Waktu maksimal pelunasan adalah 5 hari kerja setelah lelang berakhir.",
  ),
  FAQ(
    question: "Bagaimana cara mengikuti lelang di Tunas Auction?",
    answer:
        "Untuk mengikuti lelang, Anda harus melakukan registrasi sebagai peserta lelang melalui situs web atau aplikasi kami. Setelah registrasi, Anda dapat memilih kendaraan yang diinginkan dan memasang penawaran",
  ),
  FAQ(
    question: "Apa saja yang di lelangkan oleh Tunas Auction?",
    answer:
        "Tunas Auction melelang berbagai jenis kendaraan seperti mobil, motor, dan heavy equipment, serta barang elektronik dan barang lainnya yang masih dalam kondisi baik dan memiliki surat-surat lengkap.",
  ),
  FAQ(
    question: "Apa saja yang di lelangkan oleh Tunas Auction?",
    answer:
        "Tunas Auction melelang berbagai jenis kendaraan seperti mobil, motor, dan heavy equipment, serta barang elektronik dan barang lainnya yang masih dalam kondisi baik dan memiliki surat-surat lengkap.",
  ),
  FAQ(
    question: "Apa saja yang di lelangkan oleh Tunas Auction?",
    answer:
        "Tunas Auction melelang berbagai jenis kendaraan seperti mobil, motor, dan heavy equipment, serta barang elektronik dan barang lainnya yang masih dalam kondisi baik dan memiliki surat-surat lengkap.",
  ),
  // Keep other FAQ items as needed
];

class FilterWidget extends StatefulWidget {
  final String selectedMerk;
  final String selectedSeri;
  final String selectedTahun;
  final String selectedHarga;
  final Function(String) onMerkChanged;
  final Function(String) onSeriChanged;
  final Function(String) onTahunChanged;
  final Function(String) onHargaChanged;

  const FilterWidget({
    Key? key,
    required this.selectedMerk,
    required this.selectedSeri,
    required this.selectedTahun,
    required this.selectedHarga,
    required this.onMerkChanged,
    required this.onSeriChanged,
    required this.onTahunChanged,
    required this.onHargaChanged,
  }) : super(key: key);

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  String _selectedCategory = 'MOBIL'; // Kategori yang dipilih

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian Atas: Selected Category (Card)
            Text( authService.currentUser?.name != null? 
              'Selamat Pagi ${authService.currentUser?.name}, sedang mencari lelang apa?' : 
              "Selamat Datang, sedang mencari lelang apa?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryCard('MOBIL', Icons.directions_car),
                  const SizedBox(width: 16),
                  _buildCategoryCard('MOTOR', Icons.motorcycle),
                  // const SizedBox(width: 16),
                  // _buildCategoryCard('LIFESTYLE', Icons.shopping_bag),
                  const SizedBox(width: 16),
                  _buildCategoryCard('HVE', Icons.home),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Bagian Bawah: Dropdown Filter
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: widget.selectedMerk,
                    onChanged: (value) => widget.onMerkChanged(value!),
                    items: [
                      'Semua Merk',
                      'DELL',
                      'HP',
                      'LENOVO',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      labelText: 'Merk',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: widget.selectedSeri,
                    onChanged: (value) => widget.onSeriChanged(value!),
                    items: [
                      'Semua Seri',
                      'Seri 1',
                      'Seri 2',
                      'Seri 3',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      labelText: 'Seri',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: widget.selectedTahun,
                    onChanged: (value) => widget.onTahunChanged(value!),
                    items: [
                      'Semua Tahun',
                      '2020',
                      '2021',
                      '2022',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      labelText: 'Tahun',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: widget.selectedHarga,
                    onChanged: (value) => widget.onHargaChanged(value!),
                    items: [
                      'Semua Harga',
                      '< 1 Juta',
                      '1 - 2 Juta',
                      '2 - 3 Juta',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      labelText: 'Harga',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement search functionality
              },
              child: const Text('Cari'),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk membuat card kategori dengan ikon
  Widget _buildCategoryCard(String kategori, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = kategori;
        });
      },
      child: Card(
        color: _selectedCategory == kategori ? Colors.green : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(
                icon,
                color:
                    _selectedCategory == kategori ? Colors.white : Colors.black,
                size: 40,
              ),
              const SizedBox(height: 8),
              Text(
                kategori,
                style: TextStyle(
                  color: _selectedCategory == kategori
                      ? Colors.white
                      : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class JadwalLelangWidget extends StatefulWidget {
  const JadwalLelangWidget({Key? key}) : super(key: key);

  @override
  State<JadwalLelangWidget> createState() => _JadwalLelangWidgetState();
}

class _JadwalLelangWidgetState extends State<JadwalLelangWidget> {
  String _selectedCategory = 'MOBIL'; // Kategori yang dipilih

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian Atas: Kategori (Tab)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Jadwal Lelang Terdekat',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: Navigasi ke halaman "Lihat Semua"
                  },
                  child: const Text(
                    'Lihat Semua',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryTab('MOBIL'),
                  const SizedBox(width: 16),
                  _buildCategoryTab('MOTOR'),
                  const SizedBox(width: 16),
                  // _buildCategoryTab('LIFESTYLE'),
                  // const SizedBox(width: 16),
                  _buildCategoryTab('HVE'),
                  const SizedBox(width: 16),
                  // _buildCategoryTab('SCRAP', isNew: true),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Bagian Bawah: Card Jadwal Lelang
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildJadwalCard(
                    kategori: 'MOBIL',
                    tanggal: '30 Jan',
                    jam: '13.00 WIB',
                    lokasi: 'MEDAN',
                    imageUrl:
                        'https://via.placeholder.com/150', // Ganti dengan URL gambar
                  ),
                  const SizedBox(width: 16),
                  _buildJadwalCard(
                    kategori: 'MOTOR',
                    tanggal: '30 Jan',
                    jam: '13.00 WIB',
                    lokasi: 'BALIKPAPAN',
                    imageUrl:
                        'https://via.placeholder.com/150', // Ganti dengan URL gambar
                  ),
                  const SizedBox(width: 16),
                  _buildJadwalCard(
                    kategori: 'LIFESTYLE',
                    tanggal: '30 Jan',
                    jam: '14.00 WIB',
                    lokasi: 'PALEMBANG',
                    imageUrl:
                        'https://via.placeholder.com/150', // Ganti dengan URL gambar
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk membuat kategori tab
  Widget _buildCategoryTab(String kategori, {bool isNew = false}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = kategori;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color:
              _selectedCategory == kategori ? Colors.green : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _selectedCategory == kategori ? Colors.green : Colors.grey,
          ),
        ),
        child: Row(
          children: [
            Text(
              kategori,
              style: TextStyle(
                color:
                    _selectedCategory == kategori ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (isNew)
              Container(
                margin: const EdgeInsets.only(left: 8),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'New',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Widget untuk membuat card jadwal lelang
  Widget _buildJadwalCard({
    required String kategori,
    required String tanggal,
    required String jam,
    required String lokasi,
    required String imageUrl,
  }) {
    return Card(
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            // Gambar Kategori
            Image.network(
              'https://tunasauction.s3.ap-southeast-1.amazonaws.com/bastk/384b5bdbe32117213b87f8f5e0604be4_1722584708.jpg',
              height: 80,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            // Label LIVE
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'LIVE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Tanggal
            Text(
              tanggal,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            // Jam
            Text(
              jam,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            // Lokasi
            Text(
              lokasi,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
