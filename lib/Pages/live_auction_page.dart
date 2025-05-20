import 'dart:async';
import 'package:gap/gap.dart';
import 'package:tunasauctionv2/app/Widgets/footer_widget.dart';
import 'package:flutter/material.dart';

class LiveAuctionPage extends StatefulWidget {
  const LiveAuctionPage({Key? key}) : super(key: key);

  @override
  State<LiveAuctionPage> createState() => _LiveAuctionPageState();
}

class _LiveAuctionPageState extends State<LiveAuctionPage> {
  bool loading = false;
  bool paused = false;
  bool soldout = false;
  bool unsold = false;
  int countType = 3;
  int countValue = 15; // Changed to 15 as shown in the image
  String lastPrice = 'Rp 45.000.000';
  int lastPriceNumber = 45000000;
  bool btTawar = true; // MODE BID is enabled in the image
  List<String> bidlist = [
    'Rp. 44.500.000 0081 17: 09 : 21',
    'Rp. 44.500.000 0081 17: 09 : 21',
    'Rp. 44.500.000 0081 17: 09 : 21',
    'Rp. 44.500.000 0081 17: 09 : 21',
    'Rp. 44.500.000 0081 17: 09 : 21',
    'Rp. 44.500.000 0081 17: 09 : 21',
    'Rp. 44.500.000 0081 17: 09 : 21',
  ];
  String bidFormat = '';
  int dismissCountDown = 0;
  String bidFailed = '';
  int dismissCountDown2 = 0;
  bool niplShow = true;
  int niplCount = 115; // Changed to 115 as shown in the image
  int connectedUsers = 6; // Changed to 6 as shown in the image
  Timer? _timer;
  bool lelangBerakhir = false;
  int ulangEvent = 0;
  int networkLatency = 21; // Added network latency value from the image

  Map<String, dynamic> unit = {
    'location': 'Bekasi', // Updated to match the image
    'lot_name': 'A001', // Updated to match the image
    'desc': 'Toyota Avanza Veloz 1.4 MT (2018)', // Updated to match the image
    'transmission': 'Manual', // Updated to match the image
    'images': [
      {'src': 'https://tunasauction.s3.ap-southeast-1.amazonaws.com/bastk/vehicle_image.jpeg'} // Placeholder URL
    ],
    'basic_price': 45000000, // Updated to match the image
    'fuel': 'Bensin',
    'police_no': 'B-2245-KDB', // Updated to match the image
    'color': 'Hitam',
    'year': 2015, // Updated to match the image
    'stnk': '23-Juli-2025', // Updated to match the image
    'pmk41': true,
    'pmk41_ppn': 0.011, // 1.1% as shown in the image
    'auction_price11': 100000000,
    'premium_buyer11': 500000,
    'auction_price12': 150000000,
    'premium_buyer12': 750000,
    'auction_price13': 200000000,
    'premium_buyer13': 1000000,
    'auction_price14': 250000000,
    'premium_buyer14': 1250000,
    'auction_price15': 300000000,
    'premium_buyer15': 1500000,
    'auction_price_klpt': 50000000,
    'premium_buyer_naik': 250000,
    'additional_cost': 2000000,
    'extra_admin': 500000,
    'note': 'Pemenang lelang dikenakan PPN sebesar 1.1% dari harga terbentuk. Catatan ini hanya sebagai panduan, peserta lelang wajib untuk melakukan pengecekan secara langsung.',
  };

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (countValue > 0) {
          countValue--;
        } else {
          _timer?.cancel(); // Stop the timer when it reaches 0
        }
      });
    });
  }

  String formatRupiah(int number) {
    return 'Rp ${number.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  int get totalBayar {
    final lastPrice = lastPriceNumber;
    final pmk41 = unit['pmk41'] ? lastPrice * unit['pmk41_ppn'] : 0;
    int premiumBuyer = 0;

    if (lastPrice < unit['auction_price11']) {
      premiumBuyer = unit['premium_buyer11'];
    } else if (lastPrice < unit['auction_price12']) {
      premiumBuyer = unit['premium_buyer12'];
    } else if (lastPrice < unit['auction_price13']) {
      premiumBuyer = unit['premium_buyer13'];
    } else if (lastPrice < unit['auction_price14']) {
      premiumBuyer = unit['premium_buyer14'];
    } else if (lastPrice < unit['auction_price15']) {
      premiumBuyer = unit['premium_buyer15'];
    } else {
      premiumBuyer = unit['premium_buyer15'] +
          (lastPrice - (unit['auction_price15'] - 1)) ~/
              unit['auction_price_klpt'] *
              unit['premium_buyer_naik'];
    }

    final additionalCost = unit['additional_cost'];
    final extraAdmin = unit['extra_admin'];

    return (lastPrice + pmk41 + premiumBuyer + additionalCost + extraAdmin)
        .toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Row(
      //     children: [
      //       Image.asset(
      //         'assets/tunas_auction_logo.png', // Update with your actual asset path
      //         height: 30,
      //       ),
      //       const SizedBox(width: 8),
      //       const Text('Live Auction'),
      //     ],
      //   ),
      //   actions: [
      //     IconButton(icon: const Icon(Icons.favorite), onPressed: () {}),
      //     IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
      //     IconButton(icon: const Icon(Icons.person), onPressed: () {}),
      //   ],
      // ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sub navbar
            // Container(
            //   color: Colors.blue,
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //   child: Row(
            //     children: [
            //       TextButton(
            //         onPressed: () {},
            //         child: const Text('Home', style: TextStyle(color: Colors.white)),
            //       ),
            //       TextButton(
            //         onPressed: () {},
            //         child: const Text('Open House', style: TextStyle(color: Colors.white)),
            //       ),
            //       TextButton(
            //         onPressed: () {},
            //         child: const Text('Jadwal Lelang', style: TextStyle(color: Colors.white)),
            //       ),
            //       TextButton(
            //         onPressed: () {},
            //         child: const Text('Live Auction', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            //       ),
            //       TextButton(
            //         onPressed: () {},
            //         child: const Text('Beli NIPL', style: TextStyle(color: Colors.white)),
            //       ),
            //       TextButton(
            //         onPressed: () {},
            //         child: const Text('Prosedur', style: TextStyle(color: Colors.white)),
            //       ),
            //     ],
            //   ),
            // ),
            // Live Auction Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.live_tv, color: Colors.blue[800]),
                  const SizedBox(width: 8),
                  Text(
                    'Live Auction',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                ],
              ),
            ),

            // Main Content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Lot Header and Actions
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Lot Number with PPN Badge
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.blue[800],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'Lot A001',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'Plus PPN 1.1%',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Action buttons
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.favorite_border),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.compare_arrows),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.share),
                              onPressed: () {},
                            ),
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.chat),
                              label: const Text('Tertarik dengan unit ini?'),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.blue,
                                backgroundColor: Colors.white,
                                side: BorderSide(color: Colors.blue),
                              ),
                            ),
                            const SizedBox(width: 16),
                            // MODE BID Switch
                            Row(
                              children: [
                                Switch(
                                  value: btTawar,
                                  onChanged: (value) {
                                    setState(() {
                                      btTawar = value;
                                    });
                                  },
                                  activeColor: Colors.green,
                                ),
                                const Text('MODE BID'),
                                const SizedBox(width: 8),
                                Icon(Icons.wifi, color: Colors.green),
                                Text('$networkLatency ms'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Car Title and NIPL Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Car Title
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            unit['desc'],
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Lokasi: ${unit['location']}',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      // NIPL Info
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Total NIPL: $niplCount'),
                            Text('$connectedUsers Users Connected'),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Main Content Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Column: Car Image and Details
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Car Image
                            Container(
                              height: 300,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage(unit['images'][0]['src']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Thumbnail Images
                            SizedBox(
                              height: 60,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 6, // Use actual image count
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 60,
                                    height: 60,
                                    margin: const EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(4),
                                      image: DecorationImage(
                                        image: NetworkImage(unit['images'][0]['src']),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Car Details
                            buildDetailTable(),
                          ],
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Middle Column: Bid List and Controls
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            // Top Row - Simulation and Countdown
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Simulasi Penawaran
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Simulasi Penawaran',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        buildSimulationRow('Harga Penawaran', 'Rp. 45.000.000'),
                                        buildSimulationRow('PMK 41', 'Rp. 102.300'),
                                        buildSimulationRow('Administrasi', 'Rp. 500.000'),
                                        buildSimulationRow('Additional Cost', 'Rp. 2.000.000'),
                                        buildSimulationRow('Extra Admin', 'Rp. 500.000'),
                                        const Divider(),
                                        buildSimulationRow('Total', 'Rp. 51.000.000', isBold: true),
                                        const SizedBox(height: 8),
                                        const Text(
                                          '*Note: Simulasi penawaran ini hanya sebagai panduan bukan acuan dalam penawaran.',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 16),

                                // Countdown Timer
                                Container(
                                  width: 120,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    children: [
                                      const Text(
                                        'COUNT KE 3',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '$countValue',
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // Bid List
                            Container(
                              height: 240,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListView.builder(
                                itemCount: bidlist.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.grey.shade200,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Rp. 44.500.000'),
                                        Text('0081'),
                                        Text('17: 09 : 21'),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Notes and Bidding Button
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Catatan
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Catatan',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          'Pemenang lelang dikenakan PPN sebesar 1.1% dari harga terbentuk. Catatan ini hanya sebagai panduan, peserta lelang wajib untuk melakukan pengecekan secara langsung.',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 16),

                                // Bidding Area
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Harga Penawaran:',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Rp. 45.000.000',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue[700],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 48,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            foregroundColor: Colors.white,
                                          ),
                                          child: const Text(
                                            'Tawar Lot A001',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Gap(50),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }

  Widget buildDetailTable() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(2),
      },
      children: [
        buildTableRow('Harga Dasar', formatRupiah(unit['basic_price'])),
        buildTableRow('Bahan Bakar', unit['fuel']),
        buildTableRow('Nomer Polisi', unit['police_no']),
        buildTableRow('Warna', unit['color']),
        buildTableRow('Tahun', unit['year'].toString()),
        buildTableRow('Transmisi', unit['transmission']),
        buildTableRow('STNK', unit['stnk']),
      ],
    );
  }

  TableRow buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(label),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget buildSimulationRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value),
        ],
      ),
    );
  }
}