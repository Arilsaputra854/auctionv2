import 'dart:convert';
import 'package:http/http.dart' as http;

class MetaSeoService {
  final String apiUrl = "https://api.tunasauctiondev.tunasgroup.com/v1/event-management/setting-web";

  Future<Map<String, dynamic>> getMetaData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          return data[0] as Map<String, dynamic>;
        }
      }
      throw Exception('Failed to load meta data');
    } catch (e) {
      // Return default values if API fails
      return {
        "author": "Tunas Auction",
        "description": "Tunas Auction",
        "keywords": "Flutter, Dart, SEO, Meta, Web, Tunas Auction, Auction, Lelang"
      };
    }
  }
}