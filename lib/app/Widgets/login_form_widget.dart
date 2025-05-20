import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:tunasauctionv2/Model/constant.dart';
import 'package:tunasauctionv2/Providers/auth.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKeyLogin = GlobalKey<FormBuilderState>();
  final _emailFieldKeyLogin = GlobalKey<FormBuilderFieldState>();
  bool showPassword = true;
  String email = '';
  String password = '';
  String tokenID = '';
  late AuthService authService;

  getToken() async {
    String? token = authService.accessToken;
    setState(() {
      tokenID = token;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authService = context.watch<AuthService>();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (tokenID.isNotEmpty) {
        context.go('/');
      }
    });

    return SizedBox(
      width: 600, // Membatasi lebar maksimum Card
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: FormBuilder(
            key: _formKeyLogin,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MediaQuery.of(context).size.width >= 1100
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri
              children: [
                if (MediaQuery.of(context).size.width <= 1100) const Gap(10),
                if (MediaQuery.of(context).size.width <= 1100)
                  Image.asset(
                    'assets/image/tunas auction.png',
                    width: MediaQuery.of(context).size.width *
                        0.5, // Menggunakan 50% dari lebar layar
                    height: MediaQuery.of(context).size.height *
                        0.1, // Menggunakan 20% dari tinggi layar
                  ),
                const Gap(10),
                Align(
                  alignment: MediaQuery.of(context).size.width >= 1100
                      ? Alignment.bottomLeft
                      : Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left:
                            MediaQuery.of(context).size.width >= 1100 ? 50 : 0),
                    child: Text(
                      'Ayo masuk dan coba lelang Tunas Auction hari ini .',
                      style: TextStyle(
                          color: appColor,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width >= 1100
                              ? 20
                              : 15),
                    ),
                  ),
                ),
                const Gap(20),
                SizedBox(
                  width: MediaQuery.of(context).size.width >= 1100
                      ? MediaQuery.of(context).size.width / 2
                      : MediaQuery.of(context).size.width / 1.2,
                  child: FormBuilderTextField(
                    style: TextStyle(
                      color: AdaptiveTheme.of(context).mode.isDark == true
                          ? Colors.black
                          : null,
                    ),
                    onChanged: (v) {
                      setState(() {
                        email = v!;
                      });
                    },
                    key: _emailFieldKeyLogin,
                    name: 'login email',
                    decoration: InputDecoration(
                      filled: true,
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          color: AdaptiveTheme.of(context).mode.isDark == true
                              ? Colors.black
                              : null),
                      fillColor: const Color.fromARGB(255, 236, 234, 234),
                      hintText: 'Email',
                      //border: OutlineInputBorder()
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ]),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width >= 1100
                      ? MediaQuery.of(context).size.width / 2
                      : MediaQuery.of(context).size.width / 1.2,
                  child: FormBuilderTextField(
                    style: TextStyle(
                      color: AdaptiveTheme.of(context).mode.isDark == true
                          ? Colors.black
                          : null,
                    ),
                    onChanged: (value) {
                      setState(() {
                        password = value!;
                      });
                    },
                    name: 'login password',
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                          color: AdaptiveTheme.of(context).mode.isDark == true
                              ? Colors.black
                              : null),
                      suffixIcon: showPassword == true
                          ? InkWell(
                              onTap: () {
                                setState(() {
                                  showPassword = false;
                                });
                              },
                              child: const Icon(
                                Icons.visibility,
                                color: Colors.grey,
                                size: 30,
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                setState(() {
                                  showPassword = true;
                                });
                              },
                              child: const Icon(
                                Icons.visibility_off,
                                color: Colors.grey,
                                size: 30,
                              ),
                            ),
                      filled: true,
                      border: InputBorder.none,
                      fillColor: const Color.fromARGB(255, 236, 234, 234),
                      hintText: 'Password',
                      //   border: OutlineInputBorder()
                    ),
                    obscureText: showPassword,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                ),
                const Gap(10),
                SizedBox(
                  width: MediaQuery.of(context).size.width >= 1100
                      ? MediaQuery.of(context).size.width / 2
                      : MediaQuery.of(context).size.width / 1.2,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          context.go('/forgot-password');
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: appColor),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                SizedBox(
                  width: MediaQuery.of(context).size.width >= 1100
                      ? MediaQuery.of(context).size.width / 2
                      : MediaQuery.of(context).size.width / 1.2,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const BeveledRectangleBorder(),
                        backgroundColor: appColor,
                        textStyle: const TextStyle(color: Colors.white)),
                    // color: Theme.of(context).colorScheme.secondary,
                    onPressed: () {
                      if (_formKeyLogin.currentState!.validate()) {
                        context.loaderOverlay.show();
                        context.read<AuthService>()
                            .signIn(email, password, context)
                            .then((value) {
                          context.loaderOverlay.hide();
                        });
                        // Validate and save the form values
                        // _formKeyLogin.currentState?.saveAndValidate();
                        // debugPrint(_formKeyLogin.currentState?.value.toString());

                        // // On another side, can access all field values without saving form with instantValues
                        // _formKeyLogin.currentState?.validate();
                        //   debugPrint(_formKeyLogin.currentState?.instantValue.toString());
                      }
                    },
                    child: const Text(
                      'SIGN IN',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const Gap(20),
                Text(
                  'Atau masuk menggunakan',
                  style: TextStyle(
                    color: AdaptiveTheme.of(context).mode.isDark == true
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Tombol Google
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implementasikan logika login Google
                      },
                      style: ElevatedButton.styleFrom(
                        // backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.all(15),
                        shape: const CircleBorder(
                          side: BorderSide(
                              color: Colors.red), // Tambahkan border merah
                        ),
                      ),
                      child: Image.asset('assets/image/google.png',
                          height:
                              30), // Ganti dengan path gambar logo Google Anda
                    ),

                    const SizedBox(width: 20),

                    // Tombol Facebook
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implementasikan logika login Facebook
                      },
                      style: ElevatedButton.styleFrom(
                        // backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.all(15),
                        shape: const CircleBorder(
                          side: BorderSide(
                              color: Colors.blue), // Tambahkan border biru
                        ),
                      ),
                      child: Image.asset('assets/image/facebook.jpg',
                          height:
                              30), // Ganti dengan path gambar logo Facebook Anda
                    ),

                    // Tombol Twitter - dihapus sesuai permintaan
                    const SizedBox(width: 20),

                    // Tombol Apple
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implementasikan logika login Facebook
                      },
                      style: ElevatedButton.styleFrom(
                        // backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.all(15),
                        shape: const CircleBorder(
                          side: BorderSide(
                              color: Colors.black), // Tambahkan border biru
                        ),
                      ),
                      child: Image.asset('assets/image/apple.jpg',
                          height:
                              30), // Ganti dengan path gambar logo Facebook Anda
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
