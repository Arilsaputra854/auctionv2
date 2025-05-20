import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tunasauctionv2/Model/constant.dart';
import 'package:tunasauctionv2/app/Widgets/login_form_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    context.loaderOverlay.hide();
    super.initState();
  }

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
                text: 'Don\'t have an account?',
                style: TextStyle(
                  color: AdaptiveTheme.of(context).mode.isDark == true
                      ? Colors.white
                      : Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: ' Sign up',
                      style: TextStyle(
                        color: appColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // ignore: avoid_print
                          print('Working');
                          context.go('/signup');
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
                    'assets/image/login new.png',
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    scale: 1,
                  ),
                ),
                Expanded(
                    flex: 4, // Mengurangi flex untuk form login
                    child: Center(
                        child: LoginFormWidget()
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
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 15, right: 15),
              child: RichText(
                text: TextSpan(
                    text: 'Don\'t have an account?',
                    style: TextStyle(
                      color: AdaptiveTheme.of(context).mode.isDark == true
                          ? Colors.white
                          : Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' Sign up',
                          style: TextStyle(
                            color: appColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.go('/signup');
                            })
                    ]),
              ),
            ),
          )
        ],
      )
          : Center(child: LoginFormWidget()),
    );
  }
}