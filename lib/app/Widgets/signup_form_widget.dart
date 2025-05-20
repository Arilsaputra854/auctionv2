import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tunasauctionv2/Model/constant.dart';
import 'package:tunasauctionv2/Providers/auth.dart';

class SignupFormWidget extends StatefulWidget {
  const SignupFormWidget({super.key});

  @override
  State<SignupFormWidget> createState() => _SignupFormWidgetState();
}

class _SignupFormWidgetState extends State<SignupFormWidget> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _emailFieldKey = GlobalKey<FormBuilderFieldState>();
  bool showPassword = true;
  String fullname = '';
  String email = '';
  String mobile = '';
  String password = '';
  String dailCode = '+62';
  // String playerId = '';
  // String getOnesignalKey = '';
  // String referralCode = '';
  // bool referralStatus = false;
  // num? reward;
  String? sumberMendaftar;
  int agreedToTerms = 0;

  @override
  void initState() {
    // getReferralStatus();
    super.initState();
  }

  // getReferralStatus() {
  //   FirebaseFirestore.instance
  //       .collection('Referral System')
  //       .doc('Referral System')
  //       .snapshots()
  //       .listen((value) {
  //     setState(() {
  //       referralStatus = value['Status'];
  //       reward = value['Referral Amount'];
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      height: 800,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
    child: SingleChildScrollView(  // Move SingleChildScrollView here
          child: FormBuilder(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MediaQuery.of(context).size.width >= 1100
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (MediaQuery.of(context).size.width <= 1100) const Gap(10),
                if (MediaQuery.of(context).size.width <= 1100)
                  Image.asset(
                    'assets/image/tunas auction.png',
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                const Gap(10),
                Align(
                  alignment: MediaQuery.of(context).size.width >= 1100
                      ? Alignment.bottomLeft
                      : Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width >= 1100 ? 50 : 0),
                    child: Text(
                      'Silahkan Lengkapi Data Diri Anda.',
                      style: TextStyle(
                          color: appColor,
                          fontWeight: FontWeight.bold,
                          fontSize:
                          MediaQuery.of(context).size.width >= 1100 ? 20 : 15),
                    ),
                  ),
                ),
                const Gap(20),

                // Full Name Field
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
                    name: 'full_name',
                    onChanged: (v) {
                      setState(() {
                        fullname = v!;
                      });
                    },
                    decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: AdaptiveTheme.of(context).mode.isDark == true
                              ? Colors.black
                              : null,
                        ),
                        filled: true,
                        border: InputBorder.none,
                        fillColor: const Color.fromARGB(255, 236, 234, 234),
                        hintText: 'Full Name'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                ),
                const SizedBox(height: 20),

                // Email Field
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
                    key: _emailFieldKey,
                    name: 'email',
                    decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: AdaptiveTheme.of(context).mode.isDark == true
                              ? Colors.black
                              : null,
                        ),
                        filled: true,
                        border: InputBorder.none,
                        fillColor: const Color.fromARGB(255, 236, 234, 234),
                        hintText: 'Email'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ]),
                  ),
                ),
                const SizedBox(height: 20),

                // mobile Number Field
                SizedBox(
                  width: MediaQuery.of(context).size.width >= 1100
                      ? MediaQuery.of(context).size.width / 2
                      : MediaQuery.of(context).size.width / 1.2,
                  child: Row(
                    children: [
                      CountryCodePicker(
                        dialogTextStyle: TextStyle(
                          color: AdaptiveTheme.of(context).mode.isDark == true
                              ? Colors.black
                              : null,
                        ),
                        showDropDownButton: true,
                        onChanged: (v) {
                          setState(() {
                            dailCode = v.dialCode!;
                          });
                        },
                        initialSelection: 'ID',
                        showFlagDialog: true,
                        comparator: (a, b) => b.name!.compareTo(a.name!),
                      ),
                      Expanded(
                        flex: 6,
                        child: FormBuilderTextField(
                          style: TextStyle(
                            color: AdaptiveTheme.of(context).mode.isDark == true
                                ? Colors.black
                                : null,
                          ),
                          onChanged: (v) {
                            setState(() {
                              mobile = v!;
                            });
                          },
                          name: 'number',
                          maxLength: 10,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              color: AdaptiveTheme.of(context).mode.isDark == true
                                  ? Colors.black
                                  : null,
                            ),
                            filled: true,
                            counterText: "",
                            border: InputBorder.none,
                            fillColor: const Color.fromARGB(255, 236, 234, 234),
                            hintText: '',
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.numeric()
                          ]),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Password Field
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
                        password = v!;
                      });
                    },
                    name: 'password',
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: AdaptiveTheme.of(context).mode.isDark == true
                            ? Colors.black
                            : null,
                      ),
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
                    ),
                    obscureText: showPassword,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                ),
                const SizedBox(height: 20),

                // Confirm Password Field
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
                    name: 'confirm_password',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: AdaptiveTheme.of(context).mode.isDark == true
                            ? Colors.black
                            : null,
                      ),
                      filled: true,
                      border: InputBorder.none,
                      fillColor: const Color.fromARGB(255, 236, 234, 234),
                      hintText: 'Confirm Password',
                      suffixIcon: (_formKey.currentState?.fields['confirm_password']
                          ?.hasError ??
                          false)
                          ? const Icon(Icons.error, color: Colors.red)
                          : const Icon(Icons.check, color: Colors.green),
                    ),
                    obscureText: true,
                    validator: (value) =>
                    _formKey.currentState?.fields['password']?.value != value
                        ? 'No coinciden'
                        : null,
                  ),
                ),

                // // Referral Field (if enabled)
                // if (referralStatus == true) const SizedBox(height: 20),
                // if (referralStatus == true)
                //   SizedBox(
                //     width: MediaQuery.of(context).size.width >= 1100
                //         ? MediaQuery.of(context).size.width / 2
                //         : MediaQuery.of(context).size.width / 1.2,
                //     child: FormBuilderTextField(
                //       style: TextStyle(
                //         color: AdaptiveTheme.of(context).mode.isDark == true
                //             ? Colors.black
                //             : null,
                //       ),
                //       onChanged: (v) {
                //         setState(() {
                //           referralCode = v!;
                //         });
                //       },
                //       name: 'text',
                //       decoration: InputDecoration(
                //         hintStyle: TextStyle(
                //           color: AdaptiveTheme.of(context).mode.isDark == true
                //               ? Colors.black
                //               : null,
                //         ),
                //         filled: true,
                //         border: InputBorder.none,
                //         fillColor: const Color.fromARGB(255, 236, 234, 234),
                //         hintText: 'Referensi Tunas Auction Dari',
                //       ),
                //     ),
                //   ),

                // Sumber Mendaftar Dropdown
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width >= 1100
                      ? MediaQuery.of(context).size.width / 2
                      : MediaQuery.of(context).size.width / 1.2,
                  child: FormBuilderDropdown<String>(
                    name: 'sumber_mendaftar',
                    decoration: InputDecoration(
                      hintText: 'Sumber Mendaftar',
                      hintStyle: TextStyle(
                        color: AdaptiveTheme.of(context).mode.isDark == true
                            ? Colors.black
                            : null,
                      ),
                      filled: true,
                      border: InputBorder.none,
                      fillColor: const Color.fromARGB(255, 236, 234, 234),
                    ),
                    items: [
                      'TikTok',
                      'Facebook',
                      'Instagram',
                      'Teman/Keluarga',
                      'Lainnya'
                    ].map((source) => DropdownMenuItem(
                      value: source,
                      child: Text(source),
                    )).toList(),
                    onChanged: (value) {
                      setState(() {
                        sumberMendaftar = value;
                      });
                    },
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                ),

                // Terms and Conditions Agreement
                const SizedBox(height: 10),
                Padding(
                  padding: MediaQuery.of(context).size.width >= 1100
                      ? const EdgeInsets.only(left: 40, right: 40)
                      : const EdgeInsets.all(8.0),
                  child: FormBuilderCheckbox(
                    name: 'agree_to_terms',
                    initialValue: false,
                    onChanged: (value) {
                      setState(() {
                        agreedToTerms = value == true ? 1 : 0;
                      });
                    },
                    title: RichText(
                      text: TextSpan(
                          text: 'Anda telah mengetahui dan menyetujui',
                          style: TextStyle(
                            color: AdaptiveTheme.of(context).mode.isDark == true
                                ? Colors.white
                                : Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' Syarat & Ketentuan serta Kebijakan Privasi',
                                style: TextStyle(
                                  color: appColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.go('/terms');
                                  }),
                            const TextSpan(
                              text: ' dari Tunas Auction',
                            )
                          ]),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.equal(
                        true,
                        errorText: 'Anda harus menyetujui syarat dan ketentuan',
                      ),
                    ]),
                  ),
                ),

                // Register Button
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.loaderOverlay.show();

                        // Prepare the data to send
                        final mobileNumber = '$dailCode$mobile';

                        AuthService()
                            .signUp(
                          email,
                          password,
                          fullname,
                          mobileNumber,
                          sumberMendaftar!,
                          agreedToTerms,
                          context,
                        )
                            .then((value) {
                          context.loaderOverlay.hide();
                        });
                      }
                    },
                    child: Text(
                      'DAFTAR',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const Gap(20)
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}