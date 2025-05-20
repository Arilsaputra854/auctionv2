
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tunasauctionv2/Model/constant.dart';
import '../app/Widgets/signup_form_widget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width >= 1100
          ? null
          : AppBar(actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichText(
            text: TextSpan(
                text: 'Sudah punya akun?',
                style: TextStyle(
                  color: AdaptiveTheme.of(context).mode.isDark == true
                      ? Colors.white
                      : Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: ' Masuk',
                      style: TextStyle(
                        color: appColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.go('/login');
                        })
                ]),
          ),
        ),
      ]),
      body: MediaQuery.of(context).size.width >= 1100
          ? Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  flex: 6, // Menaikkan flex untuk gambar
                  child: Image.asset(
                    // 'assets/image/login new.png',
                    'assets/image/tunas_cewek.png',
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    scale: 1,
                  ),
                ),
                Expanded(
                    flex: 4, // Mengurangi flex untuk form signup
                    child: Center(
                        child: SignupFormWidget()
                    )
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: () {
                context.go('/');
              },
              child: Image.asset(
                'assets/image/tunas auction.png',
                width: 250,
                height: 50,
                // scale: 30,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 15, right: 15),
              child: RichText(
                text: TextSpan(
                    text: 'Sudah Punya Akun?',
                    style: TextStyle(
                      color: AdaptiveTheme.of(context).mode.isDark == true
                          ? Colors.white
                          : Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' Masuk',
                          style: TextStyle(
                            color: appColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.go('/login');
                            })
                    ]),
              ),
            ),
          )
        ],
      )
          : Center(child: SignupFormWidget()), // Membungkus SignupFormWidget dengan Center
    );
  }
}