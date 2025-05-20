import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../Model/constant.dart';

class BankWidget extends StatefulWidget {
  const BankWidget({super.key});

  @override
  State<BankWidget> createState() => _BankWidgetState();
}

class _BankWidgetState extends State<BankWidget> {
  String fullname = '';
  String phoneNumber = '';
  String email = '';
  String referralCode = '';
  String _selectedType = 'personal'; // Default pilihan "Personal"
  double _BankCompletion = 0.25; // Nilai persentase kelengkapan profil

  getUserDetail() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .snapshots()
        .listen((event) {
      setState(() {
        fullname = event['fullname'] ?? '';
        email = event['email'] ?? '';
        phoneNumber = event['phone'] ?? '';
        referralCode = event['personalReferralCode'] ?? '';
        // ... logika untuk menghitung _BankCompletion ...
      });
    });
  }

  @override
  void initState() {
    getUserDetail();
    super.initState();
  }

  updateUser() {
    // ... fungsi untuk update data user ke Firebase ...
  }

  @override
  Widget build(BuildContext context) {
    return fullname.isEmpty
        ? Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 20.0,
            color: Colors.white,
          ),
          const Gap(16),
          Container(
            width: double.infinity,
            height: 20.0,
            color: Colors.white,
          ),
          const Gap(16),
          Container(
            width: double.infinity,
            height: 20.0,
            color: Colors.white,
          ),
        ],
      ),
    )
        : SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Informasi akun (tanpa Card)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Detail Informasi Akun',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // ... fungsi untuk edit informasi akun ...
                      },
                    ),
                  ],
                ),
                const Divider(),
                // Center(
                //   child: Stack(
                //     alignment: Alignment.bottomRight,
                //     children: [
                //       CircleAvatar(
                //         radius: 50,
                //         backgroundImage: NetworkImage(
                //             'https://via.placeholder.com/150'),
                //       ),
                //       IconButton(
                //         icon: Icon(Icons.camera_alt),
                //         onPressed: () {
                //           // ... fungsi untuk mengubah foto profil ...
                //         },
                //       ),
                //     ],
                //   ),
                // ),
                // const Gap(16),
                // // Nama
                // Text(
                //   'Nama',
                //   style: TextStyle(fontWeight: FontWeight.bold),
                // ),
                // FormBuilderTextField(
                //   initialValue: fullname,
                //   name: 'full name',
                //   decoration: InputDecoration(
                //     border: OutlineInputBorder(),
                //   ),
                //   onChanged: (v) {
                //     setState(() {
                //       fullname = v!;
                //     });
                //   },
                // ),
                // const Gap(16),
                // // Email
                // Text(
                //   'Email',
                //   style: TextStyle(fontWeight: FontWeight.bold),
                // ),
                // FormBuilderTextField(
                //   readOnly: true,
                //   initialValue: email,
                //   name: 'email',
                //   decoration: InputDecoration(
                //     border: OutlineInputBorder(),
                //   ),
                // ),
                // const Gap(16),
                // // No. Telepon
                // Text(
                //   'No Telepon',
                //   style: TextStyle(fontWeight: FontWeight.bold),
                // ),
                // FormBuilderTextField(
                //   maxLength: 14,
                //   initialValue: phoneNumber,
                //   name: 'phone number',
                //   decoration: InputDecoration(
                //     counterText: '',
                //     border: OutlineInputBorder(),
                //   ),
                //   onChanged: (v) {
                //     setState(() {
                //       phoneNumber = v!;
                //     });
                //   },
                // ),
                // const Gap(16),
                // // Pilihan "Personal" atau "Perusahaan"
                // Row(
                //   children: [
                //     Expanded(
                //       child: Card(
                //         color: _selectedType == 'personal'
                //             ? Colors.green[100]
                //             : Colors.white,
                //         child: InkWell(
                //           onTap: () {
                //             setState(() {
                //               _selectedType = 'personal';
                //             });
                //           },
                //           child: Padding(
                //             padding: const EdgeInsets.all(16.0),
                //             child: Column(
                //               children: [
                //                 Icon(
                //                   Icons.person,
                //                   color: _selectedType == 'personal'
                //                       ? Colors.green
                //                       : Colors.grey,
                //                 ),
                //                 Text('Personal'),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //     Column(
                //       // Indikator titik
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Container(
                //           width: 8,
                //           height: 8,
                //           decoration: BoxDecoration(
                //             shape: BoxShape.circle,
                //             color: Colors.grey,
                //           ),
                //         ),
                //       ],
                //     ),
                //     Expanded(
                //       child: Card(
                //         color: _selectedType == 'corporate'
                //             ? Colors.green[100]
                //             : Colors.white,
                //         child: InkWell(
                //           onTap: () {
                //             setState(() {
                //               _selectedType = 'corporate';
                //             });
                //           },
                //           child: Padding(
                //             padding: const EdgeInsets.all(16.0),
                //             child: Column(
                //               children: [
                //                 Icon(
                //                   Icons.business,
                //                   color: _selectedType == 'corporate'
                //                       ? Colors.green
                //                       : Colors.grey,
                //                 ),
                //                 Text('Perusahaan'),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                const Gap(16),
                // Field di bawah card (modifikasi di sini)
                // _selectedType == 'personal'
                //     ? _buildPersonalForm()
               _buildCorporateForm(),
              ],
            ),
          ),
          const Gap(16),
          // Tombol "Batal" dan "Simpan"
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                ),
                onPressed: () {
                  // ... fungsi untuk tombol "Batal" ...
                },
                child: Text('Batal'),
              ),
              const Gap(16),
              ElevatedButton(
                onPressed: () {
                  updateUser();
                },
                child: Text('Simpan'),
              ),
            ],
          ),
          const Gap(32),
        ],
      ),
    );
  }


  Widget _buildCorporateForm() {
    return Column(
      children: [
        // Form untuk data perusahaan
        FormBuilderTextField(
          name: 'Bank',
          decoration: InputDecoration(
            labelText: 'Bank',
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            border: OutlineInputBorder(),
          ),
        ),
        const Gap(12),
        FormBuilderTextField(
          name: 'no_rekening',
          decoration: InputDecoration(
            labelText: 'No Rekening',
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            border: OutlineInputBorder(),
          ),
        ),
        const Gap(12),
        FormBuilderTextField(
          name: 'atas_nama',
          decoration: InputDecoration(
            labelText: 'Atas Nama',
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            border: OutlineInputBorder(),
          ),
        ),
        // const Gap(12),
        // FormBuilderTextField(
        //   name: 'kota',
        //   decoration: InputDecoration(
        //     labelText: 'Kota',
        //     contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        //     border: OutlineInputBorder(),
        //   ),
        // ),
        // const Gap(12),
        // FormBuilderTextField(
        //   name: 'alamat_perusahaan',
        //   decoration: InputDecoration(
        //     labelText: 'Alamat Perusahaan',
        //     contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        //     border: OutlineInputBorder(),
        //   ),
        // ),
        // const Gap(12),
        // FormBuilderTextField(
        //   name: 'nomor_npwp_perusahaan',
        //   decoration: InputDecoration(
        //     labelText: 'Nomor NPWP Perusahaan',
        //     contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        //     border: OutlineInputBorder(),
        //   ),
        //   keyboardType: TextInputType.number,
        // ),
      ],
    );
  }
}