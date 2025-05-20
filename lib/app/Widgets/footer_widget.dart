import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tunasauctionv2/Model/constant.dart';

class FooterWidget extends StatefulWidget {
  const FooterWidget({super.key});

  @override
  State<FooterWidget> createState() => _FooterWidgetState();
}

class _FooterWidgetState extends State<FooterWidget> {
  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _makePhoneCall(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 40, bottom: 0),
      child: Column(
        children: [
          MediaQuery.of(context).size.width >= 1100
              ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Company Information - Left column
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/image/tunas auction.png',
                        height: 60,
                      ),
                      const Gap(15),
                      const Text(
                        'PT. Mega Armada Sudeco dengan branding\nTunas Auction adalah penyedia jasa lelang\nterpercaya yang menyediakan alternatif\nlelang secara online.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                      const Gap(15),
                      // Social media icons
                      Row(
                        children: [
                          IconButton(
                            icon: Image.asset(
                              'assets/image/instagram.png',
                              height: 24,
                              width: 24,
                            ),
                            onPressed: () {
                              _launchURL(instagram);
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          const Gap(12),
                          IconButton(
                            icon: Image.asset(
                              'assets/image/twitter.jpeg',
                              height: 24,
                              width: 24,
                            ),
                            onPressed: () {
                              _launchURL(twitterLink);
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          const Gap(12),
                          IconButton(
                            icon: Image.asset(
                              'assets/image/facebook.png',
                              height: 24,
                              width: 24,
                            ),
                            onPressed: () {
                              _launchURL(facebookLink);
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          const Gap(12),
                          IconButton(
                            icon: const Icon(
                              Icons.play_circle_filled,
                              color: Colors.red,
                              size: 24,
                            ),
                            onPressed: () {
                              // YouTube link
                              _launchURL('https://youtube.com/tunasauction');
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Download Section
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Download',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const Gap(20),
                      InkWell(
                        onTap: () {
                          _launchURL('https://play.google.com/store/apps/details?id=com.tunas');
                        },
                        child: Image.asset(
                          'assets/image/playsotre.png',
                          height: 40,
                        ),
                      ),
                      const Gap(10),
                      InkWell(
                        onTap: () {
                          _launchURL('https://apps.apple.com/id/app/tunas-auction/id1562285454');
                        },
                        child: Image.asset(
                          'assets/image/appstore.png',
                          height: 40,
                        ),
                      ),
                      const Gap(20),
                      const Text(
                        'Ikuti Kami',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const Gap(10),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.circle,
                              color: Colors.blue,
                              size: 36,
                            ),
                            onPressed: () {
                              _launchURL(instagram);
                            },
                            constraints: const BoxConstraints(),
                            padding: EdgeInsets.zero,
                          ),
                          const Gap(10),
                          IconButton(
                            icon: const Icon(
                              Icons.circle,
                              color: Colors.lightBlue,
                              size: 36,
                            ),
                            onPressed: () {
                              _launchURL(twitterLink);
                            },
                            constraints: const BoxConstraints(),
                            padding: EdgeInsets.zero,
                          ),
                          const Gap(10),
                          IconButton(
                            icon: const Icon(
                              Icons.circle,
                              color: Colors.blue,
                              size: 36,
                            ),
                            onPressed: () {
                              _launchURL(facebookLink);
                            },
                            constraints: const BoxConstraints(),
                            padding: EdgeInsets.zero,
                          ),
                          const Gap(10),
                          IconButton(
                            icon: const Icon(
                              Icons.circle,
                              color: Colors.red,
                              size: 36,
                            ),
                            onPressed: () {
                              _launchURL('https://youtube.com/tunasauction');
                            },
                            constraints: const BoxConstraints(),
                            padding: EdgeInsets.zero,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Tunas Auction Section
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tunas Auction',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const Gap(20),
                      InkWell(
                        onTap: () => context.go('/hubungi-kami'),
                        child: const Text(
                          'Hubungi kami',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.8,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => context.go('/tentang-kami'),
                        child: const Text(
                          'Tentang kami',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.8,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => context.go('/lokasi-pool'),
                        child: const Text(
                          'Lokasi pool',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.8,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => context.go('/prosedur-lelang'),
                        child: const Text(
                          'Prosedur lelang',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.8,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => context.go('/faq'),
                        child: const Text(
                          'FAQ',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.8,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => context.go('/blog'),
                        child: const Text(
                          'Blog',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Layanan Section
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Layanan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const Gap(20),
                      InkWell(
                        onTap: () => context.go('/cari-objek-lelang'),
                        child: const Text(
                          'Cari Objek Lelang',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.8,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => context.go('/cari-jadwal-lelang'),
                        child: const Text(
                          'Cari Jadwal Lelang',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.8,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => context.go('/beli-nipl'),
                        child: const Text(
                          'Beli NIPL',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.8,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => context.go('/titip-jual-otomotif'),
                        child: const Text(
                          'Titip Jual Otomotif',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.8,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => context.go('/ikut-lelang'),
                        child: const Text(
                          'Ikut Lelang',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.8,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => context.go('/map'),
                        child: const Text(
                          'MAP (Market Auction Price)',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Kunjungi Kami Section
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Kunjungi kami',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const Gap(20),
                      const Text(
                        'Jl. Wibawa Mukti II KM.4 Kampung Cakung No.1, RT.001/RW.005, Jatisari, Kec. Jatiasih, Kota Bks, Jawa Barat 17462.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                      const Gap(15),
                      const Text(
                        '+ 62 821-1950-0095 (Customer Service)',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                      const Gap(5),
                      InkWell(
                        onTap: () => _makePhoneCall('tunasauction.tunasgroup.com'),
                        child: const Text(
                          'tunasauction.tunasgroup.com',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                      ),
                      const Gap(5),
                      const Text(
                        'Fax : 021 9212 1022',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
              : _buildMobileFooter(),

          // No gap needed

          // Footer bottom section
          Container(
            color: Colors.blue.shade800,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '2025 Tunas Auction All rights reserved',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Text(
                    '|',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 15),
                  InkWell(
                    onTap: () => _launchURL('https://tunasgroup.com/privacy-policy'),
                    child: const Text(
                      'Kebijakan Privasi',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileFooter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo and company info
          Image.asset(
            'assets/image/tunas auction.png',
            height: 50,
          ),
          const Gap(15),
          const Text(
            'PT. Mega Armada Sudeco dengan branding Tunas Auction adalah penyedia jasa lelang terpercaya yang menyediakan alternatif lelang secara online.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const Gap(20),

          // Download section
          const Text(
            'Download',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const Gap(15),
          Row(
            children: [
              InkWell(
                onTap: () {
                  _launchURL('https://play.google.com/store/apps/details?id=com.tunas');
                },
                child: Image.asset(
                  'assets/image/google-play-badge.png',
                  height: 40,
                ),
              ),
              const Gap(10),
              InkWell(
                onTap: () {
                  _launchURL('https://apps.apple.com/id/app/tunas-auction/id1562285454');
                },
                child: Image.asset(
                  'assets/image/app-store-badge.png',
                  height: 40,
                ),
              ),
            ],
          ),
          const Gap(30),

          // Tunas Auction Links
          const Text(
            'Tunas Auction',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const Gap(15),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () => context.go('/hubungi-kami'),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        alignment: Alignment.centerLeft,
                      ),
                      child: const Text(
                        'Hubungi kami',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.go('/tentang-kami'),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        alignment: Alignment.centerLeft,
                      ),
                      child: const Text(
                        'Tentang kami',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.go('/lokasi-pool'),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        alignment: Alignment.centerLeft,
                      ),
                      child: const Text(
                        'Lokasi pool',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () => context.go('/cari-objek-lelang'),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        alignment: Alignment.centerLeft,
                      ),
                      child: const Text(
                        'Cari Objek Lelang',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.go('/beli-nipl'),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        alignment: Alignment.centerLeft,
                      ),
                      child: const Text(
                        'Beli NIPL',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.go('/ikut-lelang'),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        alignment: Alignment.centerLeft,
                      ),
                      child: const Text(
                        'Ikut Lelang',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(30),

          // Kunjungi Kami
          const Text(
            'Kunjungi kami',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const Gap(15),
          const Text(
            'Jl. Wibawa Mukti II KM.4 Kampung Cakung No.1, RT.001/RW.005, Jatisari, Kec. Jatiasih, Kota Bks, Jawa Barat 17462.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const Gap(10),
          const Text(
            '+ 62 821-1950-0095 (Customer Service)',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const Gap(5),
          const Text(
            'tunasauction.tunasgroup.com',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const Gap(5),
          const Text(
            'Fax : 021 9212 1022',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const Gap(15),

          // Social Media Icons
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.circle, color: Colors.blue, size: 32),
                onPressed: () => _launchURL(instagram),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const Gap(15),
              IconButton(
                icon: const Icon(Icons.circle, color: Colors.lightBlue, size: 32),
                onPressed: () => _launchURL(twitterLink),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const Gap(15),
              IconButton(
                icon: const Icon(Icons.circle, color: Colors.blue, size: 32),
                onPressed: () => _launchURL(facebookLink),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const Gap(15),
              IconButton(
                icon: const Icon(Icons.circle, color: Colors.red, size: 32),
                onPressed: () => _launchURL('https://youtube.com/tunasauction'),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}