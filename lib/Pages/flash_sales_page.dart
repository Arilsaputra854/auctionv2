import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tunasauctionv2/Model/products_model.dart';
import 'package:tunasauctionv2/app/Widgets/footer_widget.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../Model/constant.dart';
import '../app/Widgets/flash_sale_product_card.dart';

class FlashSalesPage extends StatefulWidget {
  const FlashSalesPage({super.key});

  @override
  State<FlashSalesPage> createState() => _FlashSalesPageState();
}

class _FlashSalesPageState extends State<FlashSalesPage> {
  DateTime _selectedDate = DateTime.now();
  List<ProductsModel> products = [];
  bool isLoaded = true;
  int _selectedMonth = DateTime.now().month;
  int _selectedYear = DateTime.now().year;

  // Filter selections
  String? selectedCategory;
  String? selectedLocation;

  // Categories and locations from API
  List<Map<String, dynamic>> categories = [];
  List<Map<String, dynamic>> locations = [];

  // Selected filters
  Map<int, bool> selectedCategories = {};
  Map<int, bool> selectedLocations = {};

  // Dropdown visibility
  bool _showCategories = false;
  bool _showLocations = false;

  // Screen size helpers
  bool get isDesktop => MediaQuery.of(context).size.width >= 1100;
  bool get isTablet => MediaQuery.of(context).size.width >= 768 && MediaQuery.of(context).size.width < 1100;
  bool get isMobile => MediaQuery.of(context).size.width < 768;

  @override
  void initState() {
    super.initState();
    getProducts();
    fetchCategories();
    fetchLocations();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.tunasauctiondev.tunasgroup.com/v1/eventcategory-management/eventcategory-option'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          categories = data.map((item) => {
            'id': item['id'],
            'name': item['name'],
          }).toList();

          // Initialize all categories as selected by default
          selectedCategories = {
            for (var category in categories)
              category['id']: false
          };

          if (categories.isNotEmpty) {
            selectedCategory = categories.first['name'];
          }
        });
      }
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  Future<void> fetchLocations() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.tunasauctiondev.tunasgroup.com/v1/location-management/location-option'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          locations = data.map((item) => {
            'id': item['id'],
            'name': item['name'],
          }).toList();

          // Initialize all locations as selected by default
          selectedLocations = {
            for (var location in locations)
              location['id']: false
          };

          if (locations.isNotEmpty) {
            selectedLocation = locations.first['name'];
          }
        });
      }
    } catch (e) {
      print('Error fetching locations: $e');
    }
  }

  Future<void> getProducts() async {
    setState(() {
      isLoaded = true;
    });
    context.loaderOverlay.show();
    FirebaseFirestore.instance
        .collection('Flash Sales')
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

  Future<void> _previousMonth() {
    setState(() {
      if (_selectedMonth == 1) {
        _selectedMonth = 12;
        _selectedYear--;
      } else {
        _selectedMonth--;
      }
      _selectedDate = DateTime(_selectedYear, _selectedMonth, 1);
    });
    return Future.value();
  }

  Future<void> _nextMonth() {
    setState(() {
      if (_selectedMonth == 12) {
        _selectedMonth = 1;
        _selectedYear++;
      } else {
        _selectedMonth++;
      }
      _selectedDate = DateTime(_selectedYear, _selectedMonth, 1);
    });
    return Future.value();
  }

  Widget _buildCalendarDay(int day, bool isToday, bool isSelected) {
    bool isHighlighted = day == 25 || day == 26 || day == 30 || day == 31;

    return Container(
      margin: EdgeInsets.all(isMobile ? 2 : 4),
      decoration: isSelected
          ? BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.blue.shade700, width: 2),
      )
          : isHighlighted
          ? BoxDecoration(
        color: Colors.green.shade100,
        shape: BoxShape.circle,
      )
          : isToday
          ? BoxDecoration(
        border: Border.all(color: Colors.blue),
        shape: BoxShape.circle,
      )
          : null,
      child: Center(
        child: Text(
          '$day',
          style: TextStyle(
            fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
            color: isSelected
                ? Colors.white
                : isHighlighted
                ? Colors.green.shade800
                : isToday
                ? Colors.blue
                : null,
            fontSize: isMobile ? 12 : 14,
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarHeader() {
    final daysOfWeek = ['S', 'S', 'R', 'K', 'J', 'S', 'M'];

    return Row(
      children: daysOfWeek
          .map((day) => Expanded(
        child: Center(
          child: Text(
            day,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isMobile ? 12 : 14,
            ),
          ),
        ),
      ))
          .toList(),
    );
  }

  Widget _buildCalendar() {
    DateTime firstDayOfMonth = DateTime(_selectedYear, _selectedMonth, 1);
    int firstWeekdayOfMonth = firstDayOfMonth.weekday;
    if (firstWeekdayOfMonth == 7) firstWeekdayOfMonth = 0; // Adjust for Sunday as first day
    int daysInMonth = DateTime(_selectedYear, _selectedMonth + 1, 0).day;
    int rows = ((daysInMonth + firstWeekdayOfMonth) / 7).ceil();

    List<Widget> calendarRows = [];
    calendarRows.add(_buildCalendarHeader());

    int dayCount = 1;
    for (int i = 0; i < rows; i++) {
      List<Widget> rowChildren = [];

      for (int j = 0; j < 7; j++) {
        if ((i == 0 && j < firstWeekdayOfMonth) || dayCount > daysInMonth) {
          rowChildren.add(const Expanded(child: SizedBox()));
        } else {
          final isToday = dayCount == DateTime.now().day &&
              _selectedMonth == DateTime.now().month &&
              _selectedYear == DateTime.now().year;
          final isSelected = dayCount == _selectedDate.day &&
              _selectedMonth == _selectedDate.month &&
              _selectedYear == _selectedDate.year;

          rowChildren.add(
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDate = DateTime(_selectedYear, _selectedMonth, dayCount);
                  });
                },
                child: _buildCalendarDay(dayCount, isToday, isSelected),
              ),
            ),
          );
          dayCount++;
        }
      }

      calendarRows.add(
        Row(children: rowChildren),
      );
    }

    return Column(
      children: [
        for (var row in calendarRows)
          Padding(
            padding: EdgeInsets.symmetric(vertical: isMobile ? 2.0 : 4.0),
            child: row,
          ),
      ],
    );
  }

  Widget _buildAuctionCard() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: isMobile ? 120 : 150,
                color: Colors.blue,
                child: Center(
                  child: Image.asset(
                    'assets/image/jadwal_mobil.png',
                    color: Colors.white,
                    width: isMobile ? 60 : 80,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 6 : 10,
                      vertical: isMobile ? 2 : 3
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'LIVE',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: isMobile ? 10 : 12,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 6 : 10,
                      vertical: isMobile ? 3 : 5
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Text(
                    'BID',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: isMobile ? 10 : 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kategori : ${selectedCategory ?? 'Loading...'}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isMobile ? 11 : 14,
                  ),
                ),
                SizedBox(height: isMobile ? 3 : 5),
                Text(
                  'Selasa, ${DateFormat('dd MMMM yyyy', 'id_ID').format(_selectedDate)} | 14:00 WIB',
                  style: TextStyle(fontSize: isMobile ? 10 : 12),
                ),
                Text(
                  'Lokasi : ${selectedLocation ?? 'Loading...'}',
                  style: TextStyle(fontSize: isMobile ? 10 : 12),
                ),
                SizedBox(height: isMobile ? 5 : 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Jl. Inspeksi Kanal No. 10, RT.05/RW.02, Rappocini, Kota Makassar',
                        style: TextStyle(fontSize: isMobile ? 8 : 10),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: isMobile ? 5 : 10),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 4 : 8,
                      vertical: isMobile ? 2 : 4
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '138 Unit siap lelang',
                    style: TextStyle(fontSize: isMobile ? 10 : 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category filter
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showCategories = !_showCategories;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: isMobile ? 8 : 10),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Kategori',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isMobile ? 12 : 14,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Icon(_showCategories
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              ),
              if (_showCategories) ...[
                const Divider(height: 1),
                if (categories.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else
                  ...categories.map((category) => CheckboxListTile(
                    title: Text(
                      category['name'],
                      style: TextStyle(fontSize: isMobile ? 12 : 14),
                    ),
                    value: selectedCategories[category['id']] ?? false,
                    controlAffinity: ListTileControlAffinity.leading,
                    dense: true,
                    onChanged: (bool? value) {
                      setState(() {
                        selectedCategories[category['id']] = value!;
                        if (value) {
                          selectedCategory = category['name'];
                        }
                      });
                    },
                  )).toList(),
              ],
            ],
          ),
        ),
        const SizedBox(height: 10),
        // Location filter
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showLocations = !_showLocations;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: isMobile ? 8 : 10),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Lokasi',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isMobile ? 12 : 14,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Icon(_showLocations
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              ),
              if (_showLocations) ...[
                const Divider(height: 1),
                if (locations.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else
                  ...locations.map((location) => CheckboxListTile(
                    title: Text(
                      location['name'],
                      style: TextStyle(fontSize: isMobile ? 12 : 14),
                    ),
                    value: selectedLocations[location['id']] ?? false,
                    controlAffinity: ListTileControlAffinity.leading,
                    dense: true,
                    onChanged: (bool? value) {
                      setState(() {
                        selectedLocations[location['id']] = value!;
                        if (value) {
                          selectedLocation = location['name'];
                        }
                      });
                    },
                  )).toList(),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Calendar sidebar
        Container(
          width: isTablet ? 250 : 300,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              // Month navigation
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left, color: Colors.white),
                      onPressed: _previousMonth,
                    ),
                    Text(
                      '${DateFormat('MMMM yyyy', 'id_ID').format(_selectedDate)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right, color: Colors.white),
                      onPressed: _nextMonth,
                    ),
                  ],
                ),
              ),
              // Calendar grid
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildCalendar(),
              ),
              const Divider(),
              // Filters
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildFilterSection(),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        // Main content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Jadwal lelang yang Anda bisa ikuti :',
                      style: TextStyle(
                        fontSize: isTablet ? 16 : 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left),
                        onPressed: () {
                          setState(() {
                            _selectedDate = _selectedDate.subtract(const Duration(days: 1));
                          });
                        },
                      ),
                      Text(
                        '${DateFormat('d MMMM yyyy', 'id_ID').format(_selectedDate)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right),
                        onPressed: () {
                          setState(() {
                            _selectedDate = _selectedDate.add(const Duration(days: 1));
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Products grid
              _buildAuctionGrid(),
              const SizedBox(height: 16),
              // Second row of products
              _buildAuctionGrid(itemCount: 5)
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              const Icon(Icons.calendar_today, color: Colors.blue, size: 18),
              const SizedBox(width: 8),
              const Text(
                'Jadwal Lelang',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.blue, size: 18),
            ],
          ),
        ),

        // Date navigation
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Jadwal lelang:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.chevron_left, size: 20),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () {
                      setState(() {
                        _selectedDate = _selectedDate.subtract(const Duration(days: 1));
                      });
                    },
                  ),
                  Text(
                    DateFormat('d MMM yyyy', 'id_ID').format(_selectedDate),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.chevron_right, size: 20),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () {
                      setState(() {
                        _selectedDate = _selectedDate.add(const Duration(days: 1));
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),

        const Divider(),

        // Calendar section
        ExpansionTile(
          title: Text(
            'Kalender',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          initiallyExpanded: true,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  // Month navigation
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.chevron_left, color: Colors.white, size: 20),
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          onPressed: _previousMonth,
                        ),
                        Text(
                          DateFormat('MMMM yyyy', 'id_ID').format(_selectedDate),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.chevron_right, color: Colors.white, size: 20),
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          onPressed: _nextMonth,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildCalendar(),
                ],
              ),
            ),
          ],
        ),

        // Filters section
        ExpansionTile(
          title: Text(
            'Filter',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          initiallyExpanded: false,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildFilterSection(),
            ),
          ],
        ),

        const SizedBox(height: 8),

        // Products
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildAuctionGrid(crossAxisCount: 2, itemCount: 6),
        ),
      ],
    );
  }

  Widget _buildAuctionGrid({int? crossAxisCount, int? itemCount}) {
    int gridCrossAxisCount = crossAxisCount ?? (isDesktop ? 5 : isTablet ? 3 : 2);
    int gridItemCount = itemCount ?? 10;

    return isLoaded
        ? GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridCrossAxisCount,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: isMobile ? 0.6 : isTablet ? 0.65 : 0.75,
      ),
      itemCount: gridItemCount,
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        );
      },
    )
        : GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridCrossAxisCount,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: isMobile ? 0.6 : isTablet ? 0.65 : 0.75,
      ),
      itemCount: gridItemCount,
      itemBuilder: (context, index) {
        return _buildAuctionCard();
      },
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
              padding: EdgeInsets.all(isMobile ? 8.0 : 16.0),
              child: isMobile
                  ? _buildMobileLayout()
                  : _buildDesktopLayout(),
            ),
            const FooterWidget()
          ],
        ),
      ),
      // Tambahkan bottom navigation atau floating action button untuk mobile jika diperlukan
      floatingActionButton: isMobile ? FloatingActionButton(
        onPressed: () {
          // Tampilkan filter dalam bottom sheet
          showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Filter Jadwal Lelang',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: SingleChildScrollView(
                      child: _buildFilterSection(),
                    ),
                  ),
                ],
              ),
            ),
            isScrollControlled: true,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
          );
        },
        child: const Icon(Icons.filter_list),
      ) : null,
    );
  }
}