import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

// Define a new AuctionInfoWidget that displays auction details similar to what's shown in the provided image
class AuctionInfoWidget extends StatelessWidget {
  final String basePrice;
  final String auctionLocation;
  final String auctionDate;
  final String adminFee;
  final String ppnFee;
  final String additionalCost;
  final String totalEstimate;
  final Map<String, String> physicalInfo;
  final Map<String, String> documentInfo;
  final Map<String, String> contactInfo;
  final String notes;

  const AuctionInfoWidget({
    Key? key,
    required this.basePrice,
    required this.auctionLocation,
    required this.auctionDate,
    required this.adminFee,
    required this.ppnFee,
    required this.additionalCost,
    required this.totalEstimate,
    required this.physicalInfo,
    required this.documentInfo,
    required this.contactInfo,
    required this.notes,
  }) : super(key: key);

  Widget _buildInfoColumn(String title, String value, {bool isBold = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildDownloadButton() {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
        minimumSize: const Size(80, 20),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: const Text(
        'Download Doc',
        style: TextStyle(fontSize: 11, color: Colors.blue),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, {Widget? trailing}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label :',
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Card(
        shape: const BeveledRectangleBorder(),
        elevation: 0.5,
        color: AdaptiveTheme.of(context).mode.isDark ? Colors.black : Colors.white,
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with base price and auction location/date
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            right: BorderSide(color: Colors.grey, width: 0.5),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('Harga Dasar :'),
                            const SizedBox(height: 8),
                            Text(
                              basePrice,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('Lokasi Lelang'),
                            const SizedBox(height: 8),
                            Text(
                              '$auctionLocation, $auctionDate',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Estimasi Penawaran section
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                alignment: Alignment.center,
                child: const Text(
                  'Estimasi Penawaran',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),

              // Fee breakdown section
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            right: BorderSide(color: Colors.grey, width: 0.5),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('BIAYA ADMIN'),
                            const SizedBox(height: 4),
                            Text(
                              adminFee,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              '*Belum termasuk biaya notarial',
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            right: BorderSide(color: Colors.grey, width: 0.5),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('PPN 1.1 %'),
                            const SizedBox(height: 4),
                            Text(
                              ppnFee,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              '*Mengacu tarif terbaru',
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('ADD COST'),
                            const SizedBox(height: 4),
                            Text(
                              additionalCost,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Total estimate
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      totalEstimate,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const Text(
                      '*Harga Estimasi penawaran tidak mengikat',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),

              // Physical info and Document info sections
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Physical info section
                  Expanded(
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.grey, width: 0.5),
                      ),
                      margin: const EdgeInsets.all(4),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Info Fisik',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            _buildInfoItem('Nopol', physicalInfo['nopol'] ?? ''),
                            _buildInfoItem('Nomor Rangka', physicalInfo['rangka'] ?? ''),
                            _buildInfoItem('Nomor Mesin', physicalInfo['mesin'] ?? ''),
                            _buildInfoItem('Lokasi Unit', physicalInfo['lokasi'] ?? ''),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Document info section
                  Expanded(
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.grey, width: 0.5),
                      ),
                      margin: const EdgeInsets.all(4),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Info Dokumen',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            _buildInfoItem('STNK', documentInfo['stnk'] ?? '', trailing: _buildDownloadButton()),
                            _buildInfoItem('Notice Pajak', documentInfo['pajak'] ?? '', trailing: _buildDownloadButton()),
                            _buildInfoItem('BPKB', documentInfo['bpkb'] ?? '', trailing: _buildDownloadButton()),
                            _buildInfoItem('Faktur', documentInfo['faktur'] ?? '', trailing: _buildDownloadButton()),
                            _buildInfoItem('Keur', documentInfo['keur'] ?? '', trailing: _buildDownloadButton()),
                            _buildInfoItem('SPH', documentInfo['sph'] ?? '', trailing: _buildDownloadButton()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Notes and Contact sections
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Notes section
                  Expanded(
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.grey, width: 0.5),
                      ),
                      margin: const EdgeInsets.all(4),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Catatan :',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              notes,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Contact section
                  Expanded(
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.grey, width: 0.5),
                      ),
                      margin: const EdgeInsets.all(4),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Kontak',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            _buildInfoItem('PIC 1', contactInfo['pic1'] ?? ''),
                            _buildInfoItem('PIC 2', contactInfo['pic2'] ?? ''),
                            const SizedBox(height: 16),
                            // Help buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    const Text('Tertarik ?', style: TextStyle(fontSize: 10)),
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.blue),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Row(
                                        children: [
                                          Text('NIPL', style: TextStyle(fontSize: 12, color: Colors.blue)),
                                          Icon(Icons.thumb_up, color: Colors.blue, size: 16),
                                        ],
                                      ),
                                    ),
                                    const Text('Join NIPL', style: TextStyle(fontSize: 10, color: Colors.blue)),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text('Pelajari', style: TextStyle(fontSize: 10)),
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          '?',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Text('Lebih Lanjut', style: TextStyle(fontSize: 10)),
                                  ],
                                ),
                                const Column(
                                  children: [
                                    Icon(Icons.message, color: Colors.green, size: 24),
                                    Text('WA me', style: TextStyle(fontSize: 10)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}