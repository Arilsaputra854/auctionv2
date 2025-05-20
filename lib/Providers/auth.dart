import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../Model/user.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService with ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  final String _baseUrl = "https://api.tunasauctiondev.tunasgroup.com/v1/auth";

  UserModel? _currentUser;
  String _accessToken = '';
  String _tokenType = 'bearer';
  int _expiresIn = 0;
  int _notifCount = 0;
  bool? loginStatus;
  bool? signupStatus;
  bool? forgotPasswordStatus;

  // Get current user
  UserModel? get currentUser => _currentUser;

  // Get auth token
  String get accessToken => _accessToken;
  String get tokenType => _tokenType;
  int get expiresIn => _expiresIn;
  int get notifCount => _notifCount;

  // Initialize auth state
  Future<void> initialize() async {
    if (kIsWeb) {
      await _loadUserFromPrefs();
    } else {
      await _loadUserFromStorage();
    }
  }

  // Load user data from secure storage
  Future<void> _loadUserFromStorage() async {
    final token = await _storage.read(key: 'accessToken');
    final userJson = await _storage.read(key: 'userData');
    final tokenType = await _storage.read(key: 'tokenType');
    final expiresIn = await _storage.read(key: 'expiresIn');
    final notifCount = await _storage.read(key: 'notifCount');

    if (token != null && userJson != null) {
      _accessToken = token;
      _tokenType = tokenType ?? 'bearer';
      _expiresIn = int.tryParse(expiresIn ?? '0') ?? 0;
      _notifCount = int.tryParse(notifCount ?? '0') ?? 0;
      _currentUser = UserModel.fromJson(json.decode(userJson));
      loginStatus = true;
      notifyListeners();
    }
  }

  Future<void> _loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');
    final userJson = prefs.getString('userData');
    final tokenType = prefs.getString('tokenType');
    final expiresIn = prefs.getString('expiresIn');
    final notifCount = prefs.getString('notifCount');

    if (token != null && userJson != null) {
      _accessToken = token;
      _tokenType = tokenType ?? 'bearer';
      _expiresIn = int.tryParse(expiresIn ?? '0') ?? 0;
      _notifCount = int.tryParse(notifCount ?? '0') ?? 0;
      _currentUser = UserModel.fromJson(json.decode(userJson));
      loginStatus = true;

      print("DATA USER FROM PREFS ${_currentUser?.email}");
      print("TOKEN FROM PREFS ${_accessToken}");
      notifyListeners();
    }
  }

  // Save user data to secure storage
  Future<void> _saveAuthData(Map<String, dynamic> responseData) async {
    _accessToken = responseData['accessToken'];
    _tokenType = responseData['token_type'] ?? 'bearer';
    _expiresIn = responseData['expires_in'] ?? 0;
    _notifCount = responseData['notifCount'] ?? 0;
    _currentUser = UserModel.fromJson(responseData['userData']);

    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('accessToken', _accessToken);
      await prefs.setString('tokenType', _tokenType);
      await prefs.setString('expiresIn', _expiresIn.toString());
      await prefs.setString('notifCount', _notifCount.toString());
      await prefs.setString('userData', json.encode(responseData['userData']));

      print("SAVED DATA USER FROM PREFS ${_currentUser?.email}");
      print("SAVED TOKEN FROM PREFS ${_accessToken}");
    } else {
      await _storage.write(key: 'accessToken', value: _accessToken);
      await _storage.write(key: 'tokenType', value: _tokenType);
      await _storage.write(key: 'expiresIn', value: _expiresIn.toString());
      await _storage.write(key: 'notifCount', value: _notifCount.toString());
      await _storage.write(
          key: 'userData', value: json.encode(responseData['userData']));
    }
    notifyListeners();
  }

  // Clear user data
  Future<void> _clearAuthData() async {
    _accessToken = '';
    _tokenType = 'bearer';
    _expiresIn = 0;
    _notifCount = 0;
    _currentUser = null;

    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('accessToken');
      await prefs.remove('tokenType');
      await prefs.remove('expiresIn');
      await prefs.remove('notifCount');
      await prefs.remove('userData');
    } else {
      await _storage.delete(key: 'accessToken');
      await _storage.delete(key: 'tokenType');
      await _storage.delete(key: 'expiresIn');
      await _storage.delete(key: 'notifCount');
      await _storage.delete(key: 'userData');
    }

    notifyListeners();
  }

  // Auth state stream
  Stream<UserModel?> get user {
    return Stream.fromFuture(_storage.read(key: 'userData')).map((userJson) =>
        userJson != null ? UserModel.fromJson(json.decode(userJson)) : null);
  }

  // Sign in with email and password
  Future<UserModel?> signIn(
      String email, String password, BuildContext context) async {
    try {
      EasyLoading.show(status: 'logging_in');

      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      EasyLoading.dismiss();

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        await _saveAuthData(responseData);

        loginStatus = true;
        GoRouter.of(context).go('/');

        Fluttertoast.showToast(
          msg: "Login Berhasil",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          fontSize: 14.0,
        );

        return _currentUser;
      } else {
        loginStatus = false;
        final errorData = json.decode(response.body);
        print(errorData);
        Fluttertoast.showToast(
          msg: errorData['message'] ?? 'Login Gagal',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          fontSize: 14.0,
        );

        return null;
      }
    } catch (e) {
      EasyLoading.dismiss();
      loginStatus = false;

      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        fontSize: 14.0,
      );

      return null;
    }
  }

  // Register new user
  Future<UserModel?> signUp(
    String email,
    String password,
    String name,
    String mobile,
    String sumberMendaftar,
    int agreedToTerms,
    BuildContext context,
  ) async {
    try {
      EasyLoading.show(status: 'registering');

      final response = await http.post(
        Uri.parse('$_baseUrl/registerV2'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
          'name': name,
          'mobile': mobile,
          'sumber_mendaftar': sumberMendaftar,
          'agreed_terms': agreedToTerms,
        }),
      );

      EasyLoading.dismiss();

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        await _saveAuthData(responseData);

        signupStatus = true;
        GoRouter.of(context).go('/');

        Fluttertoast.showToast(
          msg: "registration_success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          fontSize: 14.0,
        );

        return _currentUser;
      } else {
        signupStatus = false;
        final errorData = json.decode(response.body);

        Fluttertoast.showToast(
          msg: errorData['message'] ?? 'registration_failed',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          fontSize: 14.0,
        );

        return null;
      }
    } catch (e) {
      EasyLoading.dismiss();
      signupStatus = false;

      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        fontSize: 14.0,
      );

      return null;
    }
  }

  // Sign out
  Future<void> signOut(BuildContext context) async {
    try {
      // Call API logout if needed
      await http.post(
        Uri.parse('$_baseUrl/logout'),
        headers: {
          'Authorization': '$_tokenType $_accessToken',
          'Content-Type': 'application/json',
        },
      );
    } catch (e) {
      // Even if logout API fails, clear local data
      print('Logout error: $e');
    }

    await _clearAuthData();
    GoRouter.of(context).go('/login');
  }

  // Forgot password
  Future<void> forgotPassword(BuildContext context, String email) async {
    try {
      EasyLoading.show(status: 'sending_email');

      final response = await http.post(
        Uri.parse('$_baseUrl/forgot-password'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email}),
      );

      EasyLoading.dismiss();

      if (response.statusCode == 200) {
        forgotPasswordStatus = true;
        GoRouter.of(context).go('/login');

        Fluttertoast.showToast(
          msg: 'check_email_for_reset',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          fontSize: 14.0,
        );
      } else {
        forgotPasswordStatus = false;
        final errorData = json.decode(response.body);

        Fluttertoast.showToast(
          msg: errorData['message'] ?? 'password_reset_failed',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          fontSize: 14.0,
        );
      }
    } catch (e) {
      EasyLoading.dismiss();
      forgotPasswordStatus = false;

      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        fontSize: 14.0,
      );
    }
  }

  // Update profile
  Future<void> updateProfile(
    String name,
    String? mobile,
    BuildContext context,
    String? avatar,
    String? address,
  ) async {
    try {
      EasyLoading.show(status: 'updating_profile');

      final response = await http.put(
        Uri.parse('$_baseUrl/profile'),
        headers: {
          'Authorization': '$_tokenType $_accessToken',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': name,
          'mobile': mobile,
          'avatar': avatar,
          'address': address,
        }),
      );

      EasyLoading.dismiss();

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        await _saveAuthData(responseData);

        Fluttertoast.showToast(
          msg: "profile_updated",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          fontSize: 14.0,
        );
      } else {
        final errorData = json.decode(response.body);

        Fluttertoast.showToast(
          msg: errorData['message'] ?? 'update_failed',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          fontSize: 14.0,
        );
      }
    } catch (e) {
      EasyLoading.dismiss();

      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        fontSize: 14.0,
      );
    }
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    await _loadUserFromStorage();
    return _accessToken.isNotEmpty && _currentUser != null;
  }

  // Get authorization header
  Map<String, String> getAuthHeader() {
    return {
      'Authorization': '$_tokenType $_accessToken',
      'Content-Type': 'application/json',
    };
  }

  // Refresh notification count
  Future<void> refreshNotifCount() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/notifications/count'),
        headers: getAuthHeader(),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _notifCount = responseData['count'] ?? 0;
        await _storage.write(key: 'notifCount', value: _notifCount.toString());
        notifyListeners();
      }
    } catch (e) {
      print('Error refreshing notification count: $e');
    }
  }
}
// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:easy_localization/easy_localization.dart';
// import 'package:go_router/go_router.dart';
// import 'package:http/http.dart' as http;
// import 'package:tunasauctionv2/utils/app_storage.dart'; // Pastikan path sesuai
// import '../../Model/user.dart';
//
// class AuthService with ChangeNotifier {
//   final AppStorage storage = getStorage();
//   final String _baseUrl = "https://api.tunasuactiondev.tunasgroup.com/v1/auth";
//
//   UserModel? _currentUser;
//   String _accessToken = '';
//   String _tokenType = 'bearer';
//   int _expiresIn = 0;
//   int _notifCount = 0;
//   bool? loginStatus;
//   bool? signupStatus;
//   bool? forgotPasswordStatus;
//
//   // Get current user
//   UserModel? get currentUser => _currentUser;
//
//   // Get auth token
//   String get accessToken => _accessToken;
//   String get tokenType => _tokenType;
//   int get expiresIn => _expiresIn;
//   int get notifCount => _notifCount;
//
//   // Initialize auth state
//   Future<void> initialize() async {
//     try {
//       debugPrint('Initializing auth service...');
//       await _loadUserFromStorage();
//       debugPrint('Initialization complete. User: $_currentUser');
//     } catch (e) {
//       debugPrint('Error initializing auth: $e');
//       await _clearAuthData(); // Reset state jika error
//     }
//   }
//
//   // Load user data from storage
//   Future<void> _loadUserFromStorage() async {
//     try {
//       final token = await storage.read('accessToken');
//       final userJson = await storage.read('userData');
//       final tokenType = await storage.read('tokenType');
//       final expiresIn = await storage.read('expiresIn');
//       final notifCount = await storage.read('notifCount');
//
//       if (token != null && userJson != null) {
//         _accessToken = token;
//         _tokenType = tokenType ?? 'bearer';
//         _expiresIn = int.tryParse(expiresIn ?? '0') ?? 0;
//         _notifCount = int.tryParse(notifCount ?? '0') ?? 0;
//         _currentUser = UserModel.fromJson(json.decode(userJson));
//         notifyListeners();
//       }
//     } catch (e) {
//       debugPrint('Error loading user from storage: $e');
//       rethrow;
//     }
//   }
//
//   // Save auth data to storage
//   Future<void> _saveAuthData(Map<String, dynamic> responseData) async {
//     try {
//       debugPrint('Saving auth data: $responseData');
//
//       _accessToken = responseData['accessToken'] as String;
//       _tokenType = responseData['token_type']?.toString() ?? 'bearer';
//       _expiresIn = responseData['expires_in'] as int? ?? 0;
//       _notifCount = responseData['notifCount'] as int? ?? 0;
//       _currentUser = UserModel.fromJson(responseData['userData']);
//
//       // Simpan ke storage
//       await Future.wait([
//         storage.write('accessToken', _accessToken),
//         storage.write('tokenType', _tokenType),
//         storage.write('expiresIn', _expiresIn.toString()),
//         storage.write('notifCount', _notifCount.toString()),
//         storage.write('userData', json.encode(responseData['userData'])),
//       ]);
//
//       notifyListeners();
//       debugPrint('Auth data saved successfully');
//     } catch (e) {
//       debugPrint('Error saving auth data: $e');
//       await _clearAuthData(); // Bersihkan data jika error
//       rethrow;
//     }
//   }
//
//   // Clear auth data
//   Future<void> _clearAuthData() async {
//     try {
//       debugPrint('Clearing auth data...');
//       _accessToken = '';
//       _tokenType = 'bearer';
//       _expiresIn = 0;
//       _notifCount = 0;
//       _currentUser = null;
//
//       await storage.clear();
//       notifyListeners();
//       debugPrint('Auth data cleared successfully');
//     } catch (e) {
//       debugPrint('Error clearing auth data: $e');
//     }
//   }
//
//   // Auth state stream
//   Stream<UserModel?> get user {
//     return Stream.fromFuture(storage.read('userData'))
//         .map((userJson) => userJson != null
//         ? UserModel.fromJson(json.decode(userJson))
//         : null);
//   }
//
//   // Sign in with email and password
//   Future<UserModel?> signIn(
//       String email, String password, BuildContext context) async {
//     try {
//       EasyLoading.show(status: 'logging_in');
//       debugPrint('Attempting login with email: $email');
//
//       final response = await http.post(
//         Uri.parse('$_baseUrl/login'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode({
//           'email': email,
//           'password': password,
//         }),
//       );
//
//       debugPrint('Login response: ${response.statusCode} - ${response.body}');
//
//       EasyLoading.dismiss();
//
//       if (response.statusCode == 200) {
//         final responseData = json.decode(response.body);
//         await _saveAuthData(responseData);
//
//         loginStatus = true;
//         debugPrint('Login successful for user: ${_currentUser?.email}');
//
//         Fluttertoast.showToast(
//           msg: "Login Berhasil",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.TOP,
//           timeInSecForIosWeb: 2,
//           fontSize: 14.0,
//         );
//
//         return _currentUser;
//       } else {
//         loginStatus = false;
//         final errorData = json.decode(response.body);
//         debugPrint('Login failed: ${errorData['message']}');
//
//         Fluttertoast.showToast(
//           msg: errorData['message'] ?? 'Login Gagal',
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.CENTER,
//           timeInSecForIosWeb: 2,
//           fontSize: 14.0,
//         );
//
//         return null;
//       }
//     } catch (e) {
//       EasyLoading.dismiss();
//       loginStatus = false;
//       debugPrint('Login error: $e');
//
//       Fluttertoast.showToast(
//         msg: 'connection_error',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 2,
//         fontSize: 14.0,
//       );
//
//       return null;
//     }
//   }
//
//   // Register new user
//   Future<UserModel?> signUp(
//       String email,
//       String password,
//       String name,
//       String mobile,
//       String sumberMendaftar,
//       int agreedToTerms,
//       BuildContext context,
//       ) async {
//     try {
//       EasyLoading.show(status: 'registering');
//       debugPrint('Attempting registration for email: $email');
//
//       final response = await http.post(
//         Uri.parse('$_baseUrl/registerV2'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode({
//           'email': email,
//           'password': password,
//           'name': name,
//           'mobile': mobile,
//           'sumber_mendaftar': sumberMendaftar,
//           'agreed_terms': agreedToTerms,
//         }),
//       );
//
//       debugPrint('Registration response: ${response.statusCode} - ${response.body}');
//       EasyLoading.dismiss();
//
//       if (response.statusCode == 201) {
//         final responseData = json.decode(response.body);
//         await _saveAuthData(responseData);
//
//         signupStatus = true;
//         debugPrint('Registration successful for user: ${_currentUser?.email}');
//
//         Fluttertoast.showToast(
//           msg: "registration_success",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.TOP,
//           timeInSecForIosWeb: 2,
//           fontSize: 14.0,
//         );
//
//         return _currentUser;
//       } else {
//         signupStatus = false;
//         final errorData = json.decode(response.body);
//         debugPrint('Registration failed: ${errorData['message']}');
//
//         Fluttertoast.showToast(
//           msg: errorData['message'] ?? 'registration_failed',
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.CENTER,
//           timeInSecForIosWeb: 2,
//           fontSize: 14.0,
//         );
//
//         return null;
//       }
//     } catch (e) {
//       EasyLoading.dismiss();
//       signupStatus = false;
//       debugPrint('Registration error: $e');
//
//       Fluttertoast.showToast(
//         msg: 'connection_error',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 2,
//         fontSize: 14.0,
//       );
//
//       return null;
//     }
//   }
//
//   // Sign out
//   Future<void> signOut(BuildContext context) async {
//     try {
//       debugPrint('Attempting logout...');
//
//       // Call API logout jika diperlukan
//       if (_accessToken.isNotEmpty) {
//         await http.post(
//           Uri.parse('$_baseUrl/logout'),
//           headers: {
//             'Authorization': '$_tokenType $_accessToken',
//             'Content-Type': 'application/json',
//           },
//         );
//       }
//     } catch (e) {
//       debugPrint('Logout API error: $e');
//       // Tetap lanjut clear local data meskipun API gagal
//     }
//
//     await _clearAuthData();
//     debugPrint('Logout completed');
//     GoRouter.of(context).go('/login');
//   }
//
//   // Check if user is logged in
//   Future<bool> isLoggedIn() async {
//     await _loadUserFromStorage();
//     final isLoggedIn = _accessToken.isNotEmpty && _currentUser != null;
//     debugPrint('isLoggedIn check: $isLoggedIn');
//     return isLoggedIn;
//   }
//
//   // Get authorization header
//   Map<String, String> getAuthHeader() {
//     return {
//       'Authorization': '$_tokenType $_accessToken',
//       'Content-Type': 'application/json',
//     };
//   }
//
//   // Refresh notification count
//   Future<void> refreshNotifCount() async {
//     try {
//       debugPrint('Refreshing notification count...');
//       final response = await http.get(
//         Uri.parse('$_baseUrl/notifications/count'),
//         headers: getAuthHeader(),
//       );
//
//       if (response.statusCode == 200) {
//         final responseData = json.decode(response.body);
//         _notifCount = responseData['count'] ?? 0;
//         await storage.write('notifCount', _notifCount.toString());
//         notifyListeners();
//         debugPrint('Notification count updated: $_notifCount');
//       }
//     } catch (e) {
//       debugPrint('Error refreshing notification count: $e');
//     }
//   }
//
//   // Forgot password
//   Future<void> forgotPassword(BuildContext context, String email) async {
//     try {
//       EasyLoading.show(status: 'sending_email');
//       debugPrint('Sending forgot password request for email: $email');
//
//       final response = await http.post(
//         Uri.parse('$_baseUrl/forgot-password'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode({'email': email}),
//       );
//
//       debugPrint('Forgot password response: ${response.statusCode} - ${response.body}');
//       EasyLoading.dismiss();
//
//       if (response.statusCode == 200) {
//         forgotPasswordStatus = true;
//         debugPrint('Forgot password email sent to: $email');
//
//         Fluttertoast.showToast(
//           msg: 'check_email_for_reset',
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.CENTER,
//           timeInSecForIosWeb: 2,
//           fontSize: 14.0,
//         );
//       } else {
//         forgotPasswordStatus = false;
//         final errorData = json.decode(response.body);
//         debugPrint('Forgot password failed: ${errorData['message']}');
//
//         Fluttertoast.showToast(
//           msg: errorData['message'] ?? 'password_reset_failed',
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.CENTER,
//           timeInSecForIosWeb: 2,
//           fontSize: 14.0,
//         );
//       }
//     } catch (e) {
//       EasyLoading.dismiss();
//       forgotPasswordStatus = false;
//       debugPrint('Forgot password error: $e');
//
//       Fluttertoast.showToast(
//         msg: 'connection_error',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 2,
//         fontSize: 14.0,
//       );
//     }
//   }
// }