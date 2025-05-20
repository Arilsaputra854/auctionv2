// import 'package:adaptive_theme/adaptive_theme.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:go_router/go_router.dart';
// import 'package:loader_overlay/loader_overlay.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:tunasauctionv2/app/Widgets/footer_widget.dart';
// import 'package:tunasauctionv2/app/Widgets/product_widget_main.dart';
// import '../../Model/products_model.dart';
//
// class HotSalesPage extends StatefulWidget {
//   const HotSalesPage({super.key});
//
//   @override
//   State<HotSalesPage> createState() => _HotSalesPageState();
// }
//
// class _HotSalesPageState extends State<HotSalesPage> {
//   List<ProductsModel> products = [];
//   bool isLoaded = true;
//
//   // Variabel untuk menyimpan pilihan pengguna
//   String? _selectedObject;
//   String? _selectedType;
//   String? _selectedLocation;
//   String? _selectedSchedule;
//   int _jumlahNPL = 1;
//
//   // Data lokasi dan jadwal (ganti dengan data yang sesuai)
//   List<String> _locations = ['Lokasi A', 'Lokasi B', 'Lokasi C'];
//   List<String> _schedules = ['Jadwal 1', 'Jadwal 2', 'Jadwal 3'];
//
//   getProducts() async {
//     setState(() {
//       isLoaded = true;
//     });
//     context.loaderOverlay.show();
//     FirebaseFirestore.instance
//         .collection('Hot Deals')
//         .snapshots()
//         .listen((event) {
//       setState(() {
//         isLoaded = false;
//       });
//       context.loaderOverlay.hide();
//       products.clear();
//       for (var element in event.docs) {
//         var prods = ProductsModel.fromMap(element, element.id);
//         setState(() {
//           products.add(prods);
//         });
//       }
//     });
//   }
//
//   @override
//   void initState() {
//     getProducts();
//     super.initState();
//   }
//
//   // Widget untuk card NPL
//   Widget _buildNPLCard(String itemName, int quantity, String total, String location, String schedule) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               itemName,
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text(location),
//             Text(schedule),
//             SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Qty: $quantity'),
//                 Text('Total: $total'),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: AdaptiveTheme.of(context).mode.isDark == true
//             ? null
//             : const Color.fromARGB(255, 247, 240, 240),
//         body: SingleChildScrollView(
//           child: Column(
//               children: [
//         //   Container(
//         //   height: MediaQuery.of(context).size.width >= 1100
//         //       ? 200
//         //       : 150,
//         //   width: double.infinity,
//         //   decoration: BoxDecoration(
//         //     image: DecorationImage(
//         //       fit: MediaQuery.of(context).size.width >= 1100
//         //           ? BoxFit.cover
//         //           : BoxFit.fill,
//         //       image: const NetworkImage(
//         //           'https://tunasauction.s3.ap-southeast-1.amazonaws.com/slider_images/71305367b64c7be0afa9294b3c57266f_1735786195.jpeg'),
//         //     ),
//         //   ),
//         // ),
//         Padding(
//           padding: MediaQuery.of(context).size.width >= 1100
//               ? const EdgeInsets.only(left: 60, right: 50)
//               : const EdgeInsets.all(0),
//           child: Column(
//             children: [
//               const Gap(20),
//               if (MediaQuery.of(context).size.width >= 1100)
//                 Align(
//                   alignment: MediaQuery.of(context).size.width >= 1100
//                       ? Alignment.centerLeft
//                       : Alignment.center,
//                   child: Row(
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           context.go('/');
//                         },
//                         child: const Text(
//                           'Home',
//                           style: TextStyle(fontSize: 10),
//                         ),
//                       ),
//                       const Text(
//                         '/ Beli Nipl',
//                         style: TextStyle(fontSize: 10),
//                       ),
//                     ],
//                   ),
//                 ),
//               Align(
//                 alignment: MediaQuery.of(context).size.width >= 1100
//                     ? Alignment.centerLeft
//                     : Alignment.center,
//                 child: const Text(
//                   'BELI NIPL',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                   ),
//                 ),
//               ),
//               const Gap(10),
//             ],
//           ),
//         ),
//         // Card untuk pilihan NPL
//         LayoutBuilder(
//         builder: (BuildContext context, BoxConstraints constraints) {
//       if (constraints.maxWidth < 600) {
//         // Jika lebar layar kurang dari 600 (handphone)
//         return Column(
//             children: [
//         Card(
//         margin: const EdgeInsets.all(16.0),
//     child: Padding(
//     padding: const EdgeInsets.all(16.0),
//     child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//     // Bagian untuk "Pilih Objek Lelang"
//     Text(
//     'Pilih Objek Lelang',
//     style: TextStyle(
//     fontWeight: FontWeight.bold, fontSize: 14),
//     ),
//     SizedBox(height: 8.0),
//     SingleChildScrollView(
//     scrollDirection: Axis.horizontal,
//     child: Row(
//     children: [
//     _buildObjectBox(
//     'Mobil',
//     'assets/image/carnipl.jpg',
//     _selectedObject == 'Mobil'),
//     _buildObjectBox(
//     'Motor',
//     'assets/image/motornipl.png',
//     _selectedObject == 'Motor'),
//     _buildObjectBox(
//     'HVE',
//     'assets/image/hvnipl.png',
//     _selectedObject == 'HVE'),
//     ],
//     ),
//     ),
//     // Bagian untuk "Pilih Tipe NPL"
//     // Bagian untuk "Lokasi"
//     SizedBox(height: 16.0),
//     Text(
//     'Lokasi',
//     style: TextStyle(
//     fontWeight: FontWeight.bold, fontSize: 14),
//     ),
//     SizedBox(height: 8.0),
//     TextField(
//     readOnly: true,
//     decoration: InputDecoration(
//     hintText: 'Pilih Kota/Cabang',
//     border: OutlineInputBorder(),
//     suffixIcon: Icon(Icons.location_on),
//     contentPadding: EdgeInsets.symmetric(
//     horizontal: 10, vertical: 8),
//     ),
//     onTap: () {
//     // Aksi saat TextField ditekan (misalnya, menampilkan dialog untuk memilih lokasi)
//     },
//     ),
//     // Bagian untuk "Jadwal"
//     SizedBox(height: 16.0),
//     Text(
//     'Jadwal',
//     style: TextStyle(
//     fontWeight: FontWeight.bold, fontSize: 14),
//     ),
//     SizedBox(height: 8.0),
//     TextField(
//     readOnly: true,
//     decoration: InputDecoration(
//     hintText: 'Pilih Jadwal',
//     border: OutlineInputBorder(),
//     suffixIcon: Icon(Icons.calendar_today),
//     contentPadding: EdgeInsets.symmetric(
//     horizontal: 10, vertical: 8),
//     ),
//     onTap: () {
//     // Aksi saat TextField ditekan (misalnya, menampilkan date picker)
//     },
//     ),
//     // Bagian untuk "Jumlah NPL"
//     SizedBox(height: 16.0),
//     Text(
//     'Jumlah NPL',
//     style: TextStyle(
//     fontWeight: FontWeight.bold, fontSize: 14),
//     ),
//     SizedBox(height: 8.0),
//     Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//     IconButton(
//     onPressed: () {
//     setState(() {
//     if (_jumlahNPL > 1) {
//     _jumlahNPL--;
//     }
//     });
//     },
//     icon: Icon(Icons.remove),
//     padding: EdgeInsets.zero,
//     constraints: BoxConstraints(),
//     ),
//     Text(_jumlahNPL.toString()),
//     IconButton(
//     onPressed: () {
//     setState(() {
//     _jumlahNPL++;
//     });
//     },
//     icon: Icon(Icons.add),
//     padding: EdgeInsets.zero,
//     constraints: BoxConstraints(),
//     ),
//     ],
//     ),
//     // Tombol "Tambahkan ke keranjang"
//     SizedBox(height: 16.0),
//     ElevatedButton(
//     onPressed: () {
//     // Menampilkan dialog saat tombol ditekan
//     showDialog(
//     context: context,
//     builder: (BuildContext context) {
//     return LayoutBuilder(
//     builder: (BuildContext context,
//     BoxConstraints constraints) {
//     if (constraints.maxWidth < 600) {
//     // Jika lebar layar kurang dari 600 (handphone)
//     return AlertDialog(
//     title:
//     Text('Konfirmasi Pembayaran'),
//     content: Column(
//     mainAxisSize: MainAxisSize.min,
//     children: [
//     // Bagian untuk menampilkan informasi NPL yang dipilih
//     // Misalnya:
//     Text(
//     'Objek Lelang: ${_selectedObject ?? '-'}'),
//     Text('Jumlah NPL: $_jumlahNPL'),
//     // ... tambahkan informasi lain yang relevan
//     SizedBox(height: 16),
//     // Form untuk input data pembayaran
//     // Anda bisa menyesuaikan field sesuai kebutuhan
//     DropdownButtonFormField<
//     String>(
//     decoration: InputDecoration(
//     labelText:
//     'Tipe Pembayaran'),
//     value: 'TRANSFER', // Ganti dengan nilai default atau variabel yang sesuai
//     items: [
//     'TRANSFER',
//     '...',
//     '...'
//     ] // Ganti dengan pilihan tipe pembayaran
//         .map((String value) =>
//     DropdownMenuItem(
//     value: value,
//     child: Text(value),
//     ))
//         .toList(),
//     onChanged: (value) {
//     // Aksi saat tipe pembayaran berubah
//     },
//     ),
//     DropdownButtonFormField<
//     String>(
//     decoration: InputDecoration(
//     labelText: 'Bank'),
//     value:
//     'BCA 221 304 0049', // Ganti dengan nilai default atau variabel yang sesuai
//     items: [
//     'BCA 221 304 0049',
//     '...',
//     '...'
//     ] // Ganti dengan pilihan bank
//         .map((String value) =>
//     DropdownMenuItem(
//     value: value,
//     child: Text(value),
//     ))
//         .toList(),
//     onChanged: (value) {
//     // Aksi saat bank berubah
//     },
//     ),
//     TextFormField(
//     decoration: InputDecoration(
//     labelText:
//     'Jumlah Pembayaran'),
//     initialValue:
//     '1.000.000', // Ganti dengan nilai default atau variabel yang sesuai
//     keyboardType:
//     TextInputType.number,
//     onChanged: (value) {
//     // Aksi saat jumlah pembayaran berubah
//     },
//     ),
//     ElevatedButton(
//     onPressed: () {
//     // Aksi saat tombol "Choose File" ditekan
//     },
//     child: Text('Choose File'),
//     ),
//     Text('No file chosen'),
//     Text(
//     '*max upload size 10240 KB'),
//     ],
//     ),
//     actions: [
//     TextButton(
//     onPressed: () {
//     Navigator.of(context).pop(); // Menutup dialog
//     },
//     child: Text('Batal'),
//     ),
//     ElevatedButton(
//     onPressed: () {
//     // Aksi saat tombol "Upload Bukti Transfer" ditekan
//     // Misalnya: memproses pembayaran, menyimpan data, dll.
//     Navigator.of(context).pop(); // Menutup dialog
//     },
//     child: Text(
//     'Upload Bukti Transfer'),
//     ),
//     ],
//     );
//     } else {
//     // Jika lebar layar lebih dari 600 (web/tablet)
//     return AlertDialog(
//     title:
//     Text('Konfirmasi Pembayaran'),
//     content: Container(
//     width: MediaQuery.of(context)
//         .size
//         .width *
//     0.3, // Lebar dialog 70% dari lebar layar
//     child: SingleChildScrollView(
//     child: Column(
//     mainAxisSize:
//     MainAxisSize.min,
//     children: [
//     // Bagian untuk menampilkan informasi NPL yang dipilih
//     // Misalnya:
//     Text(
//     'Objek Lelang: ${_selectedObject ?? '-'}'),
//     Text(
//     'Jumlah NPL: $_jumlahNPL'),
//     // ... tambahkan informasi lain yang relevan
//     SizedBox(height: 16),
//     // Form untuk input data pembayaran
//     // Anda bisa menyesuaikan field sesuai kebutuhan
//     DropdownButtonFormField<
//     String>(
//     decoration:
//     InputDecoration(
//     labelText:
//     'Tipe Pembayaran'),
//     value: 'TRANSFER', // Ganti dengan nilai default atau variabel yang sesuai
//     items: [
//     'TRANSFER',
//     '...',
//     '...'
//     ] // Ganti dengan pilihan tipe pembayaran
//         .map((String
//     value) =>
//     DropdownMenuItem(
//     value: value,
//     child:
//     Text(value),
//     ))
//         .toList(),
//     onChanged: (value) {
//     // Aksi saat tipe pembayaran berubah
//     },
//     ),
//     DropdownButtonFormField<
//     String>(
//     decoration:
//     InputDecoration(
//     labelText:
//     'Bank'),
//     value:
//     'BCA 221 304 0049', // Ganti dengan nilai default atau variabel yang sesuai
//     items: [
//     'BCA 221 304 0049',
//     '...',
//     '...'
//     ] // Ganti dengan pilihan bank
//         .map((String
//     value) =>
//     DropdownMenuItem(
//     value: value,
//     child:
//     Text(value),
//     ))
//         .toList(),
//     onChanged: (value) {
//     // Aksi saat bank berubah
//     },
//     ),
//     TextFormField(
//     decoration:
//     InputDecoration(
//     labelText:
//     'Jumlah Pembayaran'),
//     initialValue:
//     '1.000.000', // Ganti dengan nilai default atau variabel yang sesuai
//     keyboardType:
//     TextInputType.number,
//     onChanged: (value) {
//     // Aksi saat jumlah pembayaran berubah
//     },
//     ),
//     ElevatedButton(
//     onPressed: () {
//     // Aksi saat tombol "Choose File" ditekan
//     },
//     child: Text(
//     'Choose File'),
//     ),
//     Text('No file chosen'),
//     Text(
//     '*max upload size 10240 KB'),
//     ],
//     ),
//     ),
//     ),
//     actions: [
//     TextButton(
//     onPressed: () {
//     Navigator.of(context).pop(); // Menutup dialog
//     },
//     child: Text('Batal'),
//     ),
//     ElevatedButton(
//     onPressed: () {
//     // Aksi saat tombol "Upload Bukti Transfer" ditekan
//     // Misalnya: memproses pembayaran, menyimpan data, dll.
//     Navigator.of(context).pop(); // Menutup dialog
//     },
//     child: Text(
//     'Upload Bukti Transfer'),
//       ),
//       ],
//       );
//       }
//     },
//     );
//     },
//     );
//     },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.lightGreen,
//         foregroundColor: Colors.white,
//         minimumSize: Size(double.infinity, 40),
//       ),
//       child: Text(
//         'Tambahkan ke keranjang',
//         style: TextStyle(fontSize: 14),
//       ),
//     ),
//     ],
//     ),
//     ),
//         ),
//
//             ],
//         );
//       } else {
//         // Jika lebar layar lebih dari 600 (web/tablet)
//         return Row(
//           children: [
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.5,
//               child: Card(
//                 margin: const EdgeInsets.all(16.0),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Bagian untuk "Pilih Objek Lelang"
//                       Text(
//                         'Pilih Objek Lelang',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 14),
//                       ),
//                       SizedBox(height: 8.0),
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: [
//                             _buildObjectBox(
//                                 'Mobil',
//                                 'assets/image/carnipl.jpg',
//                                 _selectedObject == 'Mobil'),
//                             _buildObjectBox(
//                                 'Motor',
//                                 'assets/image/motornipl.png',
//                                 _selectedObject == 'Motor'),
//                             _buildObjectBox(
//                                 'HVE',
//                                 'assets/image/hvnipl.png',
//                                 _selectedObject == 'HVE'),
//                           ],
//                         ),
//                       ),
//                       // Bagian untuk "Pilih Tipe NPL"
//                       // Bagian untuk "Lokasi"
//                       SizedBox(height: 16.0),
//                       Text(
//                         'Lokasi',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 14),
//                       ),
//                       SizedBox(height: 8.0),
//                       TextField(
//                         readOnly: true,
//                         decoration: InputDecoration(
//                           hintText: 'Pilih Kota/Cabang',
//                           border: OutlineInputBorder(),
//                           suffixIcon: Icon(Icons.location_on),
//                           contentPadding: EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 8),
//                         ),
//                         onTap: () {
//                           // Aksi saat TextField ditekan (misalnya, menampilkan dialog untuk memilih lokasi)
//                         },
//                       ),
//                       // Bagian untuk "Jadwal"
//                       SizedBox(height: 16.0),
//                       Text(
//                         'Jadwal',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 14),
//                       ),
//                       SizedBox(height: 8.0),
//                       TextField(
//                         readOnly: true,
//                         decoration: InputDecoration(
//                           hintText: 'Pilih Jadwal',
//                           border: OutlineInputBorder(),
//                           suffixIcon: Icon(Icons.calendar_today),
//                           contentPadding: EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 8),
//                         ),
//                         onTap: () {
//                           // Aksi saat TextField ditekan (misalnya, menampilkan date picker)
//                         },
//                       ),
//                       // Bagian untuk "Jumlah NPL"
//                       SizedBox(height: 16.0),
//                       Text(
//                         'Jumlah NPL',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 14),
//                       ),
//                       SizedBox(height: 8.0),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 if (_jumlahNPL > 1) {
//                                   _jumlahNPL--;
//                                 }
//                               });
//                             },
//                             icon: Icon(Icons.remove),
//                             padding: EdgeInsets.zero,
//                             constraints: BoxConstraints(),
//                           ),
//                           Text(_jumlahNPL.toString()),
//                           IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 _jumlahNPL++;
//                               });
//                             },
//                             icon: Icon(Icons.add),
//                             padding: EdgeInsets.zero,
//                             constraints: BoxConstraints(),
//                           ),
//                         ],
//                       ),
//                       // Tombol "Tambahkan ke keranjang"
//                       SizedBox(height: 16.0),
//                       ElevatedButton(
//                         onPressed: () {
//                           // Menampilkan dialog saat tombol ditekan
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return LayoutBuilder(
//                                 builder: (BuildContext context,
//                                     BoxConstraints constraints) {
//                                   if (constraints.maxWidth < 600) {
//                                     // Jika lebar layar kurang dari 600 (handphone)
//                                     return AlertDialog(
//                                       title:
//                                       Text('Konfirmasi Pembayaran'),
//                                       content: Column(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           // Bagian untuk menampilkan informasi NPL yang dipilih
//                                           // Misalnya:
//                                           Text(
//                                               'Objek Lelang: ${_selectedObject ?? '-'}'),
//                                           Text('Jumlah NPL: $_jumlahNPL'),
//                                           // ... tambahkan informasi lain yang relevan
//                                           SizedBox(height: 16),
//                                           // Form untuk input data pembayaran
//                                           // Anda bisa menyesuaikan field sesuai kebutuhan
//                                           DropdownButtonFormField<
//                                               String>(
//                                             decoration: InputDecoration(
//                                                 labelText:
//                                                 'Tipe Pembayaran'),
//                                             value: 'TRANSFER', // Ganti dengan nilai default atau variabel yang sesuai
//                                             items: [
//                                               'TRANSFER',
//                                               '...',
//                                               '...'
//                                             ] // Ganti dengan pilihan tipe pembayaran
//                                                 .map((String value) =>
//                                                 DropdownMenuItem(
//                                                   value: value,
//                                                   child: Text(value),
//                                                 ))
//                                                 .toList(),
//                                             onChanged: (value) {
//                                               // Aksi saat tipe pembayaran berubah
//                                             },
//                                           ),
//                                           DropdownButtonFormField<
//                                               String>(
//                                             decoration: InputDecoration(
//                                                 labelText: 'Bank'),
//                                             value:
//                                             'BCA 221 304 0049', // Ganti dengan nilai default atau variabel yang sesuai
//                                             items: [
//                                               'BCA 221 304 0049',
//                                               '...',
//                                               '...'
//                                             ] // Ganti dengan pilihan bank
//                                                 .map((String value) =>
//                                                 DropdownMenuItem(
//                                                   value: value,
//                                                   child: Text(value),
//                                                 ))
//                                                 .toList(),
//                                             onChanged: (value) {
//                                               // Aksi saat bank berubah
//                                             },
//                                           ),
//                                           TextFormField(
//                                             decoration: InputDecoration(
//                                                 labelText:
//                                                 'Jumlah Pembayaran'),
//                                             initialValue:
//                                             '1.000.000', // Ganti dengan nilai default atau variabel yang sesuai
//                                             keyboardType:
//                                             TextInputType.number,
//                                             onChanged: (value) {
//                                               // Aksi saat jumlah pembayaran berubah
//                                             },
//                                           ),
//                                           ElevatedButton(
//                                             onPressed: () {
//                                               // Aksi saat tombol "Choose File" ditekan
//                                             },
//                                             child: Text('Choose File'),
//                                           ),
//                                           Text('No file chosen'),
//                                           Text(
//                                               '*max upload size 10240 KB'),
//                                         ],
//                                       ),
//                                       actions: [
//                                         TextButton(
//                                           onPressed: () {
//                                             Navigator.of(context).pop(); // Menutup dialog
//                                           },
//                                           child: Text('Batal'),
//                                         ),
//                                         ElevatedButton(
//                                           onPressed: () {
//                                             // Aksi saat tombol "Upload Bukti Transfer" ditekan
//                                             // Misalnya: memproses pembayaran, menyimpan data, dll.
//                                             Navigator.of(context).pop(); // Menutup dialog
//                                           },
//                                           child: Text(
//                                               'Upload Bukti Transfer'),
//                                         ),
//                                       ],
//                                     );
//                                   } else {
//                                     // Jika lebar layar lebih dari 600 (web/tablet)
//                                     return AlertDialog(
//                                       title:
//                                       Text('Konfirmasi Pembayaran'),
//                                       content: Container(
//                                         width: MediaQuery.of(context)
//                                             .size
//                                             .width *
//                                             0.3, // Lebar dialog 70% dari lebar layar
//                                         child: SingleChildScrollView(
//                                           child: Column(
//                                             mainAxisSize:
//                                             MainAxisSize.min,
//                                             children: [
//                                               // Bagian untuk menampilkan informasi NPL yang dipilih
//                                               // Misalnya:
//                                               Text(
//                                                   'Objek Lelang: ${_selectedObject ?? '-'}'),
//                                               Text(
//                                                   'Jumlah NPL: $_jumlahNPL'),
//                                               // ... tambahkan informasi lain yang relevan
//                                               SizedBox(height: 16),
//                                               // Form untuk input data pembayaran
//                                               // Anda bisa menyesuaikan field sesuai kebutuhan
//                                               DropdownButtonFormField<
//                                                   String>(
//                                                 decoration:
//                                                 InputDecoration(
//                                                     labelText:
//                                                     'Tipe Pembayaran'),
//                                                 value: 'TRANSFER', // Ganti dengan nilai default atau variabel yang sesuai
//                                                 items: [
//                                                   'TRANSFER',
//                                                   '...',
//                                                   '...'
//                                                 ] // Ganti dengan pilihan tipe pembayaran
//                                                     .map((String
//                                                 value) =>
//                                                     DropdownMenuItem(
//                                                       value: value,
//                                                       child: Text(
//                                                           value),
//                                                     ))
//                                                     .toList(),
//                                                 onChanged: (value) {
//                                                   // Aksi saat tipe pembayaran berubah
//                                                 },
//                                               ),
//                                               DropdownButtonFormField<
//                                                   String>(
//                                                 decoration:
//                                                 InputDecoration(
//                                                     labelText:
//                                                     'Bank'),
//                                                 value:
//                                                 'BCA 221 304 0049', // Ganti dengan nilai default atau variabel yang sesuai
//                                                 items: [
//                                                   'BCA 221 304 0049',
//                                                   '...',
//                                                   '...'
//                                                 ] // Ganti dengan pilihan bank
//                                                     .map((String
//                                                 value) =>
//                                                     DropdownMenuItem(
//                                                       value: value,
//                                                       child: Text(
//                                                           value),
//                                                     ))
//                                                     .toList(),
//                                                 onChanged: (value) {
//                                                   // Aksi saat bank berubah
//                                                 },
//                                               ),
//                                               TextFormField(
//                                                 decoration:
//                                                 InputDecoration(
//                                                     labelText:
//                                                     'Jumlah Pembayaran'),
//                                                 initialValue:
//                                                 '1.000.000', // Ganti dengan nilai default atau variabel yang sesuai
//                                                 keyboardType:
//                                                 TextInputType
//                                                     .number,
//                                                 onChanged: (value) {
//                                                   // Aksi saat jumlah pembayaran berubah
//                                                 },
//                                               ),
//                                               ElevatedButton(
//                                                 onPressed: () {
//                                                   // Aksi saat tombol "Choose File" ditekan
//                                                 },
//                                                 child: Text(
//                                                     'Choose File'),
//                                               ),
//                                               Text('No file chosen'),
//                                               Text(
//                                                   '*max upload size 10240 KB'),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       actions: [
//                                         TextButton(
//                                           onPressed: () {
//                                             Navigator.of(context).pop(); // Menutup dialog
//                                           },
//                                           child: Text('Batal'),
//                                         ),
//                                         ElevatedButton(
//                                           onPressed: () {
//                                             // Aksi saat tombol "Upload Bukti Transfer" ditekan
//                                             // Misalnya: memproses pembayaran, menyimpan data, dll.
//                                             Navigator.of(context).pop(); // Menutup dialog
//                                           },
//                                           child: Text(
//                                               'Upload Bukti Transfer'),
//                                         ),
//                                       ],
//                                     );
//                                   }
//                                 },
//                               );
//                             },
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.lightGreen,
//                           foregroundColor: Colors.white,
//                           minimumSize: Size(double.infinity, 40),
//                         ),
//                         child: Text(
//                           'Tambahkan ke keranjang',
//                           style: TextStyle(fontSize: 14),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Column(
//                 children: [
//
//                 ],
//               ),
//             ),
//           ],
//         );
//       }
//         },
//         ),
//                 const Gap(20),
//                 const FooterWidget()
//               ],
//           ),
//         ),
//     );
//   }
//
//   // Fungsi untuk membuat box objek
//   Widget _buildObjectBox(String title, String imagePath, bool isSelected) {
//     return InkWell(
//       onTap: () {
//         setState(() {
//           _selectedObject = (_selectedObject == title) ? null : title;
//         });
//       },
//       child: Container(
//         width: 120,
//         padding: EdgeInsets.all(8.0),
//         margin: EdgeInsets.only(right: 8.0),
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: isSelected ? Colors.lightGreen : Colors.grey,
//             width: 2.0,
//           ),
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         child: Column(
//           children: [
//             Align(
//               alignment: Alignment.topLeft,
//               child: Container(
//                 width: 10.0,
//                 height: 10.0,
//                 decoration: BoxDecoration(
//                   color: isSelected ? Colors.green : Colors.transparent,
//                   shape: BoxShape.circle,
//                 ),
//               ),
//             ),
//             SizedBox(height: 8.0),
//             Image.asset(imagePath, height: 50.0),
//             SizedBox(height: 8.0),
//             Text(
//               title,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 12,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tunasauctionv2/app/Widgets/footer_widget.dart';
import 'package:tunasauctionv2/app/Widgets/product_widget_main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../Model/products_model.dart';

class HotSalesPage extends StatefulWidget {
  const HotSalesPage({super.key});

  @override
  State<HotSalesPage> createState() => _HotSalesPageState();
}

class _HotSalesPageState extends State<HotSalesPage> {
  List<ProductsModel> products = [];
  bool isLoaded = true;

  // Variabel untuk menyimpan pilihan pengguna
  String? _selectedObject;
  String? _selectedType;
  String? _selectedLocation;
  String? _selectedSchedule;
  int _jumlahNPL = 1;

  // Data lokasi dan jadwal
  List<Map<String, dynamic>> _locations = [];
  List<Map<String, dynamic>> _schedules = [];
  bool _isLoadingLocations = false;
  bool _isLoadingSchedules = false;

  // Fungsi untuk mengambil data lokasi dari API
  Future<void> _fetchLocations() async {
    setState(() {
      _isLoadingLocations = true;
    });
    try {
      final response = await http.get(
        Uri.parse('https://api.tunasauctiondev.tunasgroup.com/v1/location-management/location-option'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _locations = data.map((item) => {
            'id': item['id'],
            'name': item['name']
          }).toList();
        });
      } else {
        throw Exception('Failed to load locations');
      }
    } catch (e) {
      print('Error fetching locations: $e');
    } finally {
      setState(() {
        _isLoadingLocations = false;
      });
    }
  }

  // Fungsi untuk mengambil data jadwal dari API
  Future<void> _fetchSchedules() async {
    setState(() {
      _isLoadingSchedules = true;
    });
    try {
      final response = await http.get(
        Uri.parse('https://api.tunasauctiondev.tunasgroup.com/v1/event-management/slider-event'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _schedules = data.map((item) => {
            'id': item['id'],
            'event_date': item['event_date'],
            'location': item['location'],
            'cat_name': item['cat_name']
          }).toList();
        });
      } else {
        throw Exception('Failed to load schedules');
      }
    } catch (e) {
      print('Error fetching schedules: $e');
    } finally {
      setState(() {
        _isLoadingSchedules = false;
      });
    }
  }

  getProducts() async {
    setState(() {
      isLoaded = true;
    });
    context.loaderOverlay.show();
    FirebaseFirestore.instance
        .collection('Hot Deals')
        .snapshots()
        .listen((event) {
      setState(() {
        isLoaded = false;
      });
      context.loaderOverlay.hide();
      products.clear();
      for (var element in event.docs) {
        var prods = ProductsModel.fromMap(element, element.id);
        setState(() {
          products.add(prods);
        });
      }
    });
  }

  @override
  void initState() {
    getProducts();
    _fetchLocations();
    _fetchSchedules();
    super.initState();
  }

  // Widget untuk card NPL
  Widget _buildNPLCard(String itemName, int quantity, String total, String location, String schedule) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              itemName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(location),
            Text(schedule),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Qty: $quantity'),
                Text('Total: $total'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdaptiveTheme.of(context).mode.isDark == true
          ? null
          : const Color.fromARGB(255, 247, 240, 240),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: MediaQuery.of(context).size.width >= 1100
                  ? const EdgeInsets.only(left: 60, right: 50)
                  : const EdgeInsets.all(0),
              child: Column(
                children: [
                  const Gap(20),
                  if (MediaQuery.of(context).size.width >= 1100)
                    Align(
                      alignment: MediaQuery.of(context).size.width >= 1100
                          ? Alignment.centerLeft
                          : Alignment.center,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              context.go('/');
                            },
                            child: const Text(
                              'Home',
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                          const Text(
                            '/ Beli Nipl',
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  Align(
                    alignment: MediaQuery.of(context).size.width >= 1100
                        ? Alignment.centerLeft
                        : Alignment.center,
                    child: const Text(
                      'BELI NIPL',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const Gap(10),
                ],
              ),
            ),
            // Card untuk pilihan NPL
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if (constraints.maxWidth < 600) {
                  // Jika lebar layar kurang dari 600 (handphone)
                  return Column(
                    children: [
                      Card(
                        margin: const EdgeInsets.all(16.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Bagian untuk "Pilih Objek Lelang"
                              Text(
                                'Pilih Objek Lelang',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              SizedBox(height: 8.0),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    _buildObjectBox(
                                        'Mobil',
                                        'assets/image/carnipl.jpg',
                                        _selectedObject == 'Mobil'),
                                    _buildObjectBox(
                                        'Motor',
                                        'assets/image/motornipl.png',
                                        _selectedObject == 'Motor'),
                                    _buildObjectBox(
                                        'HVE',
                                        'assets/image/hvnipl.png',
                                        _selectedObject == 'HVE'),
                                  ],
                                ),
                              ),
                              // Bagian untuk "Lokasi"
                              SizedBox(height: 16.0),
                              Text(
                                'Lokasi',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              SizedBox(height: 8.0),
                              _isLoadingLocations
                                  ? CircularProgressIndicator()
                                  : DropdownButtonFormField<String>(
                                value: _selectedLocation,
                                decoration: InputDecoration(
                                  hintText: 'Pilih Kota/Cabang',
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                ),
                                items: _locations.map((location) {
                                  return DropdownMenuItem<String>(
                                    value: location['name'],
                                    child: Text(location['name']),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedLocation = value;
                                  });
                                },
                              ),
                              // Bagian untuk "Jadwal"
                              SizedBox(height: 16.0),
                              Text(
                                'Jadwal',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              SizedBox(height: 8.0),
                              _isLoadingSchedules
                                  ? CircularProgressIndicator()
                                  : DropdownButtonFormField<String>(
                                value: _selectedSchedule,
                                decoration: InputDecoration(
                                  hintText: 'Pilih Jadwal',
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                ),
                                items: _schedules.map((schedule) {
                                  return DropdownMenuItem<String>(
                                    value: '${schedule['location']} - ${schedule['event_date']}',
                                    child: Text('${schedule['location']} - ${schedule['event_date']}'),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedSchedule = value;
                                  });
                                },
                              ),
                              // Bagian untuk "Jumlah NPL"
                              SizedBox(height: 16.0),
                              Text(
                                'Jumlah NPL',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (_jumlahNPL > 1) {
                                          _jumlahNPL--;
                                        }
                                      });
                                    },
                                    icon: Icon(Icons.remove),
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                  ),
                                  Text(_jumlahNPL.toString()),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _jumlahNPL++;
                                      });
                                    },
                                    icon: Icon(Icons.add),
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                  ),
                                ],
                              ),
                              // Tombol "Tambahkan ke keranjang"
                              SizedBox(height: 16.0),
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Konfirmasi Pembayaran'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text('Objek Lelang: ${_selectedObject ?? '-'}'),
                                            Text('Lokasi: ${_selectedLocation ?? '-'}'),
                                            Text('Jadwal: ${_selectedSchedule ?? '-'}'),
                                            Text('Jumlah NPL: $_jumlahNPL'),
                                            SizedBox(height: 16),
                                            DropdownButtonFormField<String>(
                                              decoration: InputDecoration(
                                                  labelText: 'Tipe Pembayaran'),
                                              value: 'TRANSFER',
                                              items: ['TRANSFER', '...', '...']
                                                  .map((String value) =>
                                                  DropdownMenuItem(
                                                    value: value,
                                                    child: Text(value),
                                                  ))
                                                  .toList(),
                                              onChanged: (value) {},
                                            ),
                                            DropdownButtonFormField<String>(
                                              decoration: InputDecoration(
                                                  labelText: 'Bank'),
                                              value: 'BCA 221 304 0049',
                                              items: ['BCA 221 304 0049', '...', '...']
                                                  .map((String value) =>
                                                  DropdownMenuItem(
                                                    value: value,
                                                    child: Text(value),
                                                  ))
                                                  .toList(),
                                              onChanged: (value) {},
                                            ),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                  labelText: 'Jumlah Pembayaran'),
                                              initialValue: '1.000.000',
                                              keyboardType: TextInputType.number,
                                              onChanged: (value) {},
                                            ),
                                            ElevatedButton(
                                              onPressed: () {},
                                              child: Text('Choose File'),
                                            ),
                                            Text('No file chosen'),
                                            Text('*max upload size 10240 KB'),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Batal'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Upload Bukti Transfer'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightGreen,
                                  foregroundColor: Colors.white,
                                  minimumSize: Size(double.infinity, 40),
                                ),
                                child: Text(
                                  'Tambahkan ke keranjang',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  // Jika lebar layar lebih dari 600 (web/tablet)
                  return Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Card(
                          margin: const EdgeInsets.all(16.0),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Bagian untuk "Pilih Objek Lelang"
                                Text(
                                  'Pilih Objek Lelang',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                                SizedBox(height: 8.0),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      _buildObjectBox(
                                          'Mobil',
                                          'assets/image/carnipl.jpg',
                                          _selectedObject == 'Mobil'),
                                      _buildObjectBox(
                                          'Motor',
                                          'assets/image/motornipl.png',
                                          _selectedObject == 'Motor'),
                                      _buildObjectBox(
                                          'HVE',
                                          'assets/image/hvnipl.png',
                                          _selectedObject == 'HVE'),
                                    ],
                                  ),
                                ),
                                // Bagian untuk "Lokasi"
                                SizedBox(height: 16.0),
                                Text(
                                  'Lokasi',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                                SizedBox(height: 8.0),
                                _isLoadingLocations
                                    ? CircularProgressIndicator()
                                    : DropdownButtonFormField<String>(
                                  value: _selectedLocation,
                                  decoration: InputDecoration(
                                    hintText: 'Pilih Kota/Cabang',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 8),
                                  ),
                                  items: _locations.map((location) {
                                    return DropdownMenuItem<String>(
                                      value: location['name'],
                                      child: Text(location['name']),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedLocation = value;
                                    });
                                  },
                                ),
                                // Bagian untuk "Jadwal"
                                SizedBox(height: 16.0),
                                Text(
                                  'Jadwal',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                                SizedBox(height: 8.0),
                                _isLoadingSchedules
                                    ? CircularProgressIndicator()
                                    : DropdownButtonFormField<String>(
                                  value: _selectedSchedule,
                                  decoration: InputDecoration(
                                    hintText: 'Pilih Jadwal',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 8),
                                  ),
                                  items: _schedules.map((schedule) {
                                    return DropdownMenuItem<String>(
                                      value: '${schedule['location']} - ${schedule['event_date']}',
                                      child: Text('${schedule['location']} - ${schedule['event_date']}'),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedSchedule = value;
                                    });
                                  },
                                ),
                                // Bagian untuk "Jumlah NPL"
                                SizedBox(height: 16.0),
                                Text(
                                  'Jumlah NPL',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (_jumlahNPL > 1) {
                                            _jumlahNPL--;
                                          }
                                        });
                                      },
                                      icon: Icon(Icons.remove),
                                      padding: EdgeInsets.zero,
                                      constraints: BoxConstraints(),
                                    ),
                                    Text(_jumlahNPL.toString()),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _jumlahNPL++;
                                        });
                                      },
                                      icon: Icon(Icons.add),
                                      padding: EdgeInsets.zero,
                                      constraints: BoxConstraints(),
                                    ),
                                  ],
                                ),
                                // Tombol "Tambahkan ke keranjang"
                                SizedBox(height: 16.0),
                                ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Konfirmasi Pembayaran'),
                                          content: Container(
                                            width: MediaQuery.of(context).size.width * 0.3,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text('Objek Lelang: ${_selectedObject ?? '-'}'),
                                                  Text('Lokasi: ${_selectedLocation ?? '-'}'),
                                                  Text('Jadwal: ${_selectedSchedule ?? '-'}'),
                                                  Text('Jumlah NPL: $_jumlahNPL'),
                                                  SizedBox(height: 16),
                                                  DropdownButtonFormField<String>(
                                                    decoration: InputDecoration(
                                                        labelText: 'Tipe Pembayaran'),
                                                    value: 'TRANSFER',
                                                    items: ['TRANSFER', '...', '...']
                                                        .map((String value) =>
                                                        DropdownMenuItem(
                                                          value: value,
                                                          child: Text(value),
                                                        ))
                                                        .toList(),
                                                    onChanged: (value) {},
                                                  ),
                                                  DropdownButtonFormField<String>(
                                                    decoration: InputDecoration(
                                                        labelText: 'Bank'),
                                                    value: 'BCA 221 304 0049',
                                                    items: ['BCA 221 304 0049', '...', '...']
                                                        .map((String value) =>
                                                        DropdownMenuItem(
                                                          value: value,
                                                          child: Text(value),
                                                        ))
                                                        .toList(),
                                                    onChanged: (value) {},
                                                  ),
                                                  TextFormField(
                                                    decoration: InputDecoration(
                                                        labelText: 'Jumlah Pembayaran'),
                                                    initialValue: '1.000.000',
                                                    keyboardType: TextInputType.number,
                                                    onChanged: (value) {},
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {},
                                                    child: Text('Choose File'),
                                                  ),
                                                  Text('No file chosen'),
                                                  Text('*max upload size 10240 KB'),
                                                ],
                                              ),
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Batal'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Upload Bukti Transfer'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.lightGreen,
                                    foregroundColor: Colors.white,
                                    minimumSize: Size(double.infinity, 40),
                                  ),
                                  child: Text(
                                    'Tambahkan ke keranjang',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            const Gap(20),
            const FooterWidget()
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membuat box objek
  Widget _buildObjectBox(String title, String imagePath, bool isSelected) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedObject = (_selectedObject == title) ? null : title;
        });
      },
      child: Container(
        width: 120,
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(right: 8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.lightGreen : Colors.grey,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 10.0,
                height: 10.0,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.green : Colors.transparent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Image.asset(imagePath, height: 50.0),
            SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}