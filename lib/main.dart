// // ignore_for_file: avoid_print
//
// import 'package:easy_localization/easy_localization.dart';
import 'package:change_app_package_name/change_app_package_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:meta_seo/meta_seo.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tunasauctionv2/Model/constant.dart';
// import 'package:url_strategy/url_strategy.dart';
import 'package:tunasauctionv2/Model/user.dart';
import 'package:tunasauctionv2/Pages/bank_page.dart';
import 'package:tunasauctionv2/Pages/brand_page.dart';
import 'package:tunasauctionv2/Pages/check_out_page.dart';
import 'package:tunasauctionv2/Pages/delivery_address_page.dart';
import 'package:tunasauctionv2/Pages/favorites_page.dart';
import 'package:tunasauctionv2/Pages/flash_sales_page.dart';
import 'package:tunasauctionv2/Pages/forgot_passowrd_page.dart';
import 'package:tunasauctionv2/Pages/hot_deals_page.dart';
import 'package:tunasauctionv2/Pages/inbox_page.dart';
import 'package:tunasauctionv2/Pages/live_auction_new.dart';
import 'package:tunasauctionv2/Pages/news_detail_page.dart';
import 'package:tunasauctionv2/Pages/nipl_page.dart';
import 'package:tunasauctionv2/Pages/policy_page.dart';
import 'package:tunasauctionv2/Pages/products_by_category.dart';
import 'package:tunasauctionv2/Pages/products_all_category.dart';
import 'package:tunasauctionv2/Pages/profile_page.dart';
import 'package:tunasauctionv2/Pages/live_auction_page.dart';
import 'package:tunasauctionv2/Pages/riwayat_lelangs.dart';
import 'package:tunasauctionv2/Pages/news_page.dart';
import 'package:tunasauctionv2/Pages/news_detail_page.dart';
import 'package:tunasauctionv2/Pages/live_auction_page_all.dart';
import 'package:tunasauctionv2/Pages/search_page.dart';
import 'package:tunasauctionv2/Pages/terms_page.dart';
import 'package:tunasauctionv2/Pages/track_order_page.dart';
import 'package:tunasauctionv2/Pages/vendors_page.dart';
import 'package:tunasauctionv2/Pages/vouchers_page.dart';
import 'package:tunasauctionv2/Pages/wallet_page.dart';
import 'package:tunasauctionv2/Providers/auth.dart';
import 'package:tunasauctionv2/app/Widgets/scaffold_widget.dart';
import 'package:tunasauctionv2/firebase_options.dart';
import 'Pages/about_page.dart';
// import 'Pages/home_page.dart';
import 'Pages/home_page_2.dart';
import 'Pages/login_page.dart';
import 'Pages/order_detail_page.dart';
import 'Pages/orders_page.dart';
import 'Pages/product_details_page.dart';
import 'Pages/products_by_collection.dart';
import 'Pages/products_by_vendor.dart';
import 'Pages/signup_page.dart';
import 'Pages/track_order_detail_page.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'services/meta_seo_service.dart';


final GlobalKey<NavigatorState> _rootNavigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'shell');

bool isLogged = false;
getAuth() {
  FirebaseAuth.instance.authStateChanges().listen((User? user) async {
    if (user == null) {
      isLogged = false;

      print('Your login status is:$isLogged');
    } else {
      isLogged = true;

      print('Your login status is:$isLogged');
    }
  });
}

main() async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await dotenv.load(fileName: ".env");
  //Stripe.publishableKey = dotenv.env['StripePublishableKey']!;
  // Stripe.publishableKey =
  //     "pk_test_51Gxh6MLks7i6gqGhRQksiizAVlzvxizYuctHxObUwuf3r3hMAmjfzNZLNeZEjzQJRtqY4utaabu2RbxshbaY32L600cx4ald7d";
  // Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  // Stripe.urlScheme = 'flutterstripe';
  // await Stripe.instance.applySettings();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // if (!kIsWeb) {
  //   await setupFlutterNotifications();
  // }
  // usePathUrlStrategy();
  setPathUrlStrategy();
  if (kIsWeb) {
    MetaSEO().config();
  }
  // await EasyLocalization.ensureInitialized();
  // requestPermission();
  final authService = AuthService();
  await authService.initialize();


  getAuth();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(
    MultiProvider(
      providers: [
        // Provide AuthService instance
        ChangeNotifierProvider<AuthService>(
          create: (_) => authService,
        ),

        // Provide UserModel stream
        StreamProvider<UserModel?>(
          create: (context) => authService.user,
          initialData: null,
          catchError: (_, __) => null,
        ),
      ],
      child: MyApp(
        savedThemeMode: savedThemeMode,
      ),
    ),
  );

  // runApp(MultiProvider(
  //   // providers: [
  //   //   StreamProvider<UserModel>.value(
  //   //     value: AuthService().user,
  //   //     initialData: UserModel(
  //   //       photoUrl: '',
  //   //       displayName: '',
  //   //       email: '',
  //   //       phonenumber: '',
  //   //       token: '',
  //   //       uid: '',
  //   //     ),
  //   //   ),
  //   // ],
  //     providers: [
  //       // Provide AuthService instance
  //       ChangeNotifierProvider<AuthService>(
  //         create: (_) => authService,
  //       ),
  //
  //       // Provide UserModel stream
  //       StreamProvider<UserModel?>(
  //         create: (context) => authService.user,
  //         initialData: null,
  //         catchError: (_, __) => null,
  //       ),
  //     ],
  //     child: EasyLocalization(
  //         supportedLocales: const [
  //           Locale('es', 'ES'),
  //           Locale('en', 'US'),
  //           Locale('pt', 'PT')
  //         ],
  //         path: 'assets/languagesFile',
  //         fallbackLocale: const Locale('en', 'US'),
  //         child: MyApp(
  //           savedThemeMode: savedThemeMode,
  //         ))));
}

class MyApp extends StatefulWidget {
  final AdaptiveThemeMode? savedThemeMode;
  const MyApp({super.key, this.savedThemeMode});

  @override
  State<MyApp> createState() => _MyAppState();
}

void initialization() async {
  FlutterNativeSplash.remove();
}

class _MyAppState extends State<MyApp> {
  late Future<Map<String, dynamic>> _metaDataFuture;
  final MetaSeoService _metaSeoService = MetaSeoService();
  @override
  void initState() {
    FlutterNativeSplash.remove();
    _metaDataFuture = _metaSeoService.getMetaData();
    // _retrieveToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _metaDataFuture,
      builder: (context, snapshot) {
        // Handle error state
        if (snapshot.hasError) {
          if (kIsWeb) {
            // Fallback meta data jika API error
            MetaSEO meta = MetaSEO();
            meta.author(author: 'Tunas Auction');
            meta.description(description: 'Tunas Auction');
            meta.keywords(keywords: 'Flutter, Dart, SEO, Meta, Web, Tunas Auction, Auction, Lelang');
          }
        }

        // Set meta data jika data tersedia
        if (kIsWeb && snapshot.hasData) {
          final metaData = snapshot.data!;
          MetaSEO meta = MetaSEO();
          meta.author(author: metaData['author'] ?? 'Tunas Auction');
          meta.description(description: metaData['description'] ?? 'Tunas Auction');
          meta.keywords(keywords: metaData['keywords'] ?? 'Flutter, Dart, SEO, Meta, Web, Tunas Auction, Auction, Lelang');
        }

        return AdaptiveTheme(
          light: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            colorSchemeSeed: Colors.blue,
            fontFamily: 'Graphik',
          ),
          dark: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorSchemeSeed: Colors.blue,
            fontFamily: 'Graphik',
          ),
          initial: widget.savedThemeMode ?? AdaptiveThemeMode.light,
          builder: (theme, darkTheme) {
            // Pindahkan inisialisasi MetaSEO untuk route spesifik di sini jika diperlukan
            return GlobalLoaderOverlay(
              useDefaultLoading: false,
              overlayWidgetBuilder: (_) {
                return Center(
                  child: SpinKitCubeGrid(
                    color: appColor,
                    size: 50.0,
                  ),
                );
              },
              child: MaterialApp.router(
                routerConfig: router,
                // localizationsDelegates: context.localizationDelegates,
                // supportedLocales: context.supportedLocales,
                // locale: context.locale,
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  FormBuilderLocalizations.delegate,
                ],
                debugShowCheckedModeBanner: false,
                title: 'Balai Lelang No 1 Di Indonesia | Tunas Auction',
                theme: theme,
                darkTheme: darkTheme,
              ),
            );
          },
        );
      },
    );
  }
  final GoRouter router =
  GoRouter(navigatorKey: _rootNavigatorKey, initialLocation: '/', routes: [
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) => const LoginPage(),
      // redirect: (context, state) {
      //   if (isLogged == false) {
      //     return '/login';
      //   } else {
      //     return '/';
      //   }
      // }
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (BuildContext context, GoRouterState state) =>
      const ForgotPasswordPage(),
    ),
    GoRoute(
        path: '/track-order',
        builder: (BuildContext context, GoRouterState state) =>
        const TrackOrderPage(),
        redirect: (context, state) {
          if (isLogged == false) {
            return '/login';


          } else {
            return '/track-order';
          }
        }),
    GoRoute(
      path: '/tracking-detail/:orderID',
      builder: (BuildContext context, GoRouterState state) =>
          TrackOrderDetailPage(orderID: state.pathParameters['orderID']!),
      // redirect: (context, state) {
      //   if (isLogged == false) {
      //     return '/login';
      //   } else {
      //     return '/tracking-detail/:orderID';
      //   }
      // }
    ),
    GoRoute(
      path: '/signup',
      builder: (BuildContext context, GoRouterState state) =>
      const SignupPage(),
      // redirect: (context, state) {
      //   if (isLogged == false) {
      //     return '/signup';
      //   } else {
      //     return '/';
      //   }
      // }
    ),
    GoRoute(
        path: '/checkout',
        builder: (BuildContext context, GoRouterState state) =>
        const CheckoutPage(),
        redirect: (context, state) {
          if (isLogged == false) {
            return '/login';
          } else {
            return '/checkout';
          }
        }),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (_, GoRouterState state, child) {
        return ScaffoldWidget(
          body: child,
          path: state.fullPath.toString(),
        );
      },
      routes: [
        GoRoute(
            path: '/',
            builder: (BuildContext context, GoRouterState state) {
              // Add MetaSEO just into Web platform condition
              if (kIsWeb) {
                // Define MetaSEO object
                MetaSEO meta = MetaSEO();
                // add meta seo data for web app as you want
                meta.ogTitle(ogTitle: 'Home page');
                meta.description(description: 'Home page');
                meta.keywords(
                    keywords:
                    'Flutter, Dart, SEO, Meta, Web, Tunas Auction, Auction, Lelang');
              }
              // return const HomePage();
              return const HomePage2();
            }),
        GoRoute(
          path: '/terms',
          builder: (BuildContext context, GoRouterState state) =>
          const TermsPage(),
        ),
        GoRoute(
          path: '/policy',
          builder: (BuildContext context, GoRouterState state) =>
          const PolicyPage(),
        ),
        GoRoute(
          path: '/brand/:category',
          builder: (BuildContext context, GoRouterState state) => BrandPage(
            category: state.pathParameters['category']!,
          ),
        ),
        GoRoute(
            path: '/wallet',
            builder: (BuildContext context, GoRouterState state) =>
            const WalletPage(),
            redirect: (context, state) {
              if (isLogged == false) {
                return '/login';
              } else {
                return '/wallet';
              }
            }),
        GoRoute(
            path: '/profile',
            builder: (BuildContext context, GoRouterState state) =>
            const ProfilePage(),
            redirect: (context, state) {
              if (isLogged == false) {
                return '/login';
              } else {
                return '/profile';
              }
            }),
        GoRoute(
            path: '/live-auction-all',
            builder: (BuildContext context, GoRouterState state) =>
            const LiveAuctionsPage(),
            redirect: (context, state) {
              if (isLogged == false) {
                return '/login';
              } else {
                return '/live-auction-all';
              }
            }),
        GoRoute(
            path: '/bank',
            builder: (BuildContext context, GoRouterState state) =>
            const BankPage(),
            redirect: (context, state) {
              if (isLogged == false) {
                return '/login';
              } else {
                return '/bank';
              }
            }),
        GoRoute(
            path: '/nipl',
            builder: (BuildContext context, GoRouterState state) =>
            const NiplPage(),
            redirect: (context, state) {
              if (isLogged == false) {
                return '/login';
              } else {
                return '/nipl';
              }
            }),
        GoRoute(
            path: '/favorites',
            builder: (BuildContext context, GoRouterState state) =>
            const FavoritesPage(),
            redirect: (context, state) {
              if (isLogged == false) {
                return '/login';
              } else {
                return '/favorites';
              }
            }),
        GoRoute(
            path: '/orders',
            builder: (BuildContext context, GoRouterState state) =>
            const OrdersPage(),
            redirect: (context, state) {
              if (isLogged == false) {
                return '/login';
              } else {
                return '/orders';
              }
            }),
        GoRoute(
            path: '/voucher',
            builder: (BuildContext context, GoRouterState state) =>
            const VoucherPage(),
            redirect: (context, state) {
              if (isLogged == false) {
                return '/login';
              } else {
                return '/voucher';
              }
            }),
        GoRoute(
            path: '/delivery-addresses',
            builder: (BuildContext context, GoRouterState state) =>
            const DeliveryAddressPage(),
            redirect: (context, state) {
              if (isLogged == false) {
                return '/login';
              } else {
                return '/delivery-addresses';
              }
            }),
        GoRoute(
            path: '/inbox',
            builder: (BuildContext context, GoRouterState state) =>
            const InboxPage(),
            redirect: (context, state) {
              if (isLogged == false) {
                return '/login';
              } else {
                return '/inbox';
              }
            }),
        GoRoute(
          path: '/product-detail/:id',
          builder: (BuildContext context, GoRouterState state) =>
              ProductDetailPage(
                productUID: state.pathParameters['id']!,
              ),
        ),
        GoRoute(
          path: '/order-detail/:id',
          builder: (BuildContext context, GoRouterState state) =>
              OderDetailPage(
                uid: state.pathParameters['id']!,
              ),
        ),
        GoRoute(
          path: '/vendor-detail/:category',
          builder: (BuildContext context, GoRouterState state) =>
              ProductByVendorPage(
                category: state.pathParameters['category']!,
              ),
        ),
        GoRoute(
          path: '/search/:id',
          builder: (BuildContext context, GoRouterState state) => SearchPage(
            productString: state.pathParameters['id']!,
          ),
        ),
        GoRoute(
          path: '/about',
          builder: (BuildContext context, GoRouterState state) =>
          const AboutPage(),
        ),
        GoRoute(
          path: '/live-auction-new',
          builder: (BuildContext context, GoRouterState state) =>
          const LiveAuctionNew(),
        ),
        GoRoute(
          path: '/riwayat-lelangs',
          builder: (BuildContext context, GoRouterState state) =>
          const RiwayatLelangsPage(),
        ),

        GoRoute(
          path: '/flash-sales',
          builder: (BuildContext context, GoRouterState state) =>
          const FlashSalesPage(),
        ),
        // GoRoute(
        //   path: '/vendors',
        //   builder: (BuildContext context, GoRouterState state) =>
        //       const VendorsPage(),
        // ),
        GoRoute(
          path: '/hot-deals',
          builder: (BuildContext context, GoRouterState state) =>
          const HotSalesPage(),
        ),
        GoRoute(
          path: '/products-all-category', // Route baru
          builder: (BuildContext context, GoRouterState state) =>
          const ProductAllCategoryPage(category: 'All Products'), // Parameter category bisa disesuaikan
        ),
        GoRoute(
          path: '/products/:category',
          builder: (BuildContext context, GoRouterState state) =>
              ProductByCategoryPage(
                category: state.pathParameters['category']!,
              ),
        ),
        // GoRoute(
        //   path: '/live-auctions',
        //   builder: (BuildContext context, GoRouterState state) => const LiveAuctionPage(),
        // ),
        GoRoute(
            path: '/live-auctions',
            builder: (BuildContext context, GoRouterState state) =>
            const LiveAuctionPage(),
            redirect: (context, state) {
              if (isLogged == false) {
                return '/login';
              } else {
                return '/live-auctions';
              }
            }),
        GoRoute(
          path: '/news',
          builder: (BuildContext context, GoRouterState state) =>
          const NewsPage(),
        ),
        GoRoute(
          path: '/news-detail',
          builder: (BuildContext context, GoRouterState state) =>
          const NewsDetailPage(),
        ),
        GoRoute(
          path: '/collection/:collection',
          builder: (BuildContext context, GoRouterState state) =>
              ProductByCollectionPage(
                category: state.pathParameters['collection']!,
              ),
        ),
      ],
    ),
  ]);
}
