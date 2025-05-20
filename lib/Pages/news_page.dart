//
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:tunasauctionv2/app/Widgets/footer_widget.dart';
// import 'package:tunasauctionv2/Pages/news_detail_page.dart';
//
// class NewsPage extends StatefulWidget {
//   const NewsPage({super.key});
//
//   @override
//   State<NewsPage> createState() => _NewsPageState();
// }
//
// class _NewsPageState extends State<NewsPage> {
//   final List<String> categories = [
//     "Event",
//     "Festival",
//     "Insight",
//     "Journal",
//     "Press Release",
//     "Tips",
//     "Story",
//     "News",
//     "Update",
//     "Career",
//     "Lifestyle",
//   ];
//
//   final List<String> tags = [
//     "Press Release",
//     "Engineering",
//     "Promo",
//     "Review",
//     "Data",
//     "Gosend Portal",
//     "Inspiration",
//     "Explore",
//     "Movie",
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // Header
//                 Text(
//                   "What's On Tunas Auction",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 40,
//                   ),
//                 ),
//                 const Gap(8),
//                 Text(
//                   "Our stories, latest updates, and exclusive promos. Find anything you want to know about us.",
//                   style: TextStyle(fontSize: 16),
//                   textAlign: TextAlign.center,
//                 ),
//                 const Gap(24),
//
//                 // Articles Section
//                 // GridView.builder(
//                 //   shrinkWrap: true,
//                 //   physics: NeverScrollableScrollPhysics(),
//                 //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 //     crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 1,
//                 //     crossAxisSpacing: 16,
//                 //     mainAxisSpacing: 16,
//                 //     childAspectRatio: 4 / 3.5,
//                 //   ),
//                 //   itemCount: articles.length,
//                 //   itemBuilder: (context, index) {
//                 //     final article = articles[index];
//                 //     return Center(child: ArticleCard(article: article));
//                 //   },
//                 // ),
//                 GridView.builder(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 1,
//                     crossAxisSpacing: 16,
//                     mainAxisSpacing: 16,
//                     childAspectRatio: 4 / 3.5,
//                   ),
//                   itemCount: articles.length,
//                   itemBuilder: (context, index) {
//                     final article = articles[index];
//                     return InkWell(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => NewsDetailPage(),
//                           ),
//                         );
//                       },
//                       child: ArticleCard(article: article),
//                     );
//
//                   },
//                 ),
//
//                 const Gap(32),
//
//                 // Categories Section
//                 Column(
//                   children: [
//                     Text(
//                       "Articles by Category",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                       ),
//                     ),
//                     const Gap(16),
//                     GridView.builder(
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: MediaQuery.of(context).size.width > 600 ? 6 : 3,
//                         crossAxisSpacing: 10,
//                         mainAxisSpacing: 10,
//                         childAspectRatio: 3.5 / 0.5,
//                       ),
//                       itemCount: categories.length,
//                       itemBuilder: (context, index) {
//                         final category = categories[index];
//                         return GestureDetector(
//                           onTap: () {
//                             print("Category clicked: $category");
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(12),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black12,
//                                   blurRadius: 5,
//                                   offset: Offset(0, 3),
//                                 ),
//                               ],
//                             ),
//                             alignment: Alignment.center,
//                             child: Text(
//                               category,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//
//                 const Gap(32),
//
//                 // Tags Section
//                 Column(
//                   children: [
//                     Text(
//                       "Tags",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                       ),
//                     ),
//                     const Gap(16),
//                     Wrap(
//                       alignment: WrapAlignment.center,
//                       spacing: 8.0,
//                       runSpacing: 8.0,
//                       children: tags.map((tag) {
//                         return GestureDetector(
//                           onTap: () {
//                             print("Tag clicked: $tag");
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               border: Border.all(color: Colors.grey.shade300),
//                               borderRadius: BorderRadius.circular(24),
//                             ),
//                             child: Text(
//                               tag,
//                               style: TextStyle(
//                                 color: Colors.grey.shade800,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ],
//                 ),
//
//                 const Gap(20),
//
//                 // Footer Widget
//                 const FooterWidget(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class ArticleCard extends StatefulWidget {
//   final Article article;
//
//   ArticleCard({required this.article});
//
//   @override
//   _ArticleCardState createState() => _ArticleCardState();
// }
// class _ArticleCardState extends State<ArticleCard> {
//   bool isHovered = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) => setState(() => isHovered = true),
//       onExit: (_) => setState(() => isHovered = false),
//       child: Column(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 10,
//                   offset: Offset(0, 5),
//                 ),
//               ],
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Stack(
//                 children: [
//                   AnimatedContainer(
//                     duration: Duration(milliseconds: 300),
//                     curve: Curves.easeInOut,
//                     transform: isHovered
//                         ? Matrix4.diagonal3Values(1.05, 1.05, 1.0)
//                         : Matrix4.identity(),
//                     child: Image.network(
//                       widget.article.imageAsset,
//                       height: 250,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 8.0),
//             child: Column(
//               children: [
//                 Text(
//                   widget.article.title,
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                   textAlign: TextAlign.center,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const Gap(4),
//                 Text(
//                   "${widget.article.category} / ${widget.article.date}",
//                   style: TextStyle(color: Colors.grey, fontSize: 14),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
// // Sample article data
// class Article {
//   final String title;
//   final String imageAsset;
//   final String category;
//   final String date;
//
//   Article({
//     required this.title,
//     required this.imageAsset,
//     required this.category,
//     required this.date,
//   });
// }
//
// final List<Article> articles = [
//   Article(
//     title: 'WARA-WIRI WEEKEND PASTI TENANG PAKAI KODE GOWEEKEND',
//     imageAsset: 'https://cdn-site.gojek.com/uploads/Go_Car_Weekend_Campaign_Rame_Rame_Display_Static_1200x600_6750ce17d0/Go_Car_Weekend_Campaign_Rame_Rame_Display_Static_1200x600_6750ce17d0.jpg',
//     category: 'gojek',
//     date: '21 Jan 2025',
//   ),
//   Article(
//     title: 'Kenalan sama fitur baru Edit Stasiun GoTransit',
//     imageAsset: 'https://cdn-site.gojek.com/uploads/GORIDE_GOTRANSIT_Blog_1456x818_40b725c098/GORIDE_GOTRANSIT_Blog_1456x818_40b725c098.jpg',
//     category: 'gotransit',
//     date: '20 Jan 2025',
//   ),
//   Article(
//     title: 'Promo GoFood Jajan Hemat',
//     imageAsset: 'https://cdn-site.gojek.com/uploads/HEMAT_Blog_1456x818_36d507eef0/HEMAT_Blog_1456x818_36d507eef0.jpg',
//     category: 'gofood',
//     date: '19 Jan 2025',
//   ),
//   Article(
//     title: 'Diskon untuk Pembelian Pulsa via GoPulsa',
//     imageAsset: 'https://cdn-site.gojek.com/uploads/LAYANAN_BARU_Go_Send_Instant_Hemat_Blog_2313911e5b/LAYANAN_BARU_Go_Send_Instant_Hemat_Blog_2313911e5b.png',
//     category: 'gopulsa',
//     date: '18 Jan 2025',
//   ),
//   Article(
//     title: 'Tips Aman Pakai Gojek Selama Pandemi',
//     imageAsset: 'https://cdn-site.gojek.com/uploads/YL_SMG_ARAGON_BLOG_0873b5be2d/YL_SMG_ARAGON_BLOG_0873b5be2d.jpg',
//     category: 'gojek',
//     date: '17 Jan 2025',
//   ),
//   Article(
//     title: 'Fitur Terbaru GoClub untuk Member',
//     imageAsset: 'https://cdn-site.gojek.com/uploads/Gojek_PLUS_In_App_Blog_1456x818_9e87c63fb7/Gojek_PLUS_In_App_Blog_1456x818_9e87c63fb7.jpg',
//     category: 'goclub',
//     date: '16 Jan 2025',
//   ),
//   Article(
//     title: 'Diskon untuk Pembelian Pulsa via GoPulsa',
//     imageAsset: 'https://cdn-site.gojek.com/uploads/LAYANAN_BARU_Go_Send_Instant_Hemat_Blog_2313911e5b/LAYANAN_BARU_Go_Send_Instant_Hemat_Blog_2313911e5b.png',
//     category: 'gopulsa',
//     date: '18 Jan 2025',
//   ),
//   Article(
//     title: 'Tips Aman Pakai Gojek Selama Pandemi',
//     imageAsset: 'https://cdn-site.gojek.com/uploads/YL_SMG_ARAGON_BLOG_0873b5be2d/YL_SMG_ARAGON_BLOG_0873b5be2d.jpg',
//     category: 'gojek',
//     date: '17 Jan 2025',
//   ),
//   Article(
//     title: 'Fitur Terbaru GoClub untuk Member',
//     imageAsset: 'https://cdn-site.gojek.com/uploads/Gojek_PLUS_In_App_Blog_1456x818_9e87c63fb7/Gojek_PLUS_In_App_Blog_1456x818_9e87c63fb7.jpg',
//     category: 'goclub',
//     date: '16 Jan 2025',
//   ),
// ];

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tunasauctionv2/app/Widgets/footer_widget.dart';
import 'package:tunasauctionv2/Pages/news_detail_page.dart';
import 'package:tunasauctionv2/app/Widgets/article_card.dart' as ArticleCardWidget;
import 'package:tunasauctionv2/app/Widgets/article_data.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final List<String> categories = [
    "Event",
    "Festival",
    "Insight",
    "Journal",
    "Press Release",
    "Tips",
    "Story",
    "News",
    "Update",
    "Career",
    "Lifestyle",
  ];

  final List<String> tags = [
    "Press Release",
    "Engineering",
    "Promo",
    "Review",
    "Data",
    "Gosend Portal",
    "Inspiration",
    "Explore",
    "Movie",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Anda dapat menambahkan judul atau ikon di sini
        title: const Text("News Page"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header
                const Text(
                  "What's On Tunas Auction",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                const Gap(8),
                const Text(
                  "Our stories, latest updates, and exclusive promos. Find anything you want to know about us.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const Gap(24),

                // Articles Section
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 1,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 4 / 3.5,
                  ),
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return ArticleCardWidget.ArticleCard(
                      title: article.title,
                      imageAsset: article.imageAsset,
                      category: article.category,
                      date: article.date,
                    );
                  },
                ),
                const Gap(32),

                // Categories Section
                Column(
                  children: [
                    const Text(
                      "Articles by Category",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Gap(16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 6 : 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 3.5 / 0.5,
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return GestureDetector(
                          onTap: () {
                            // Tambahkan logika untuk filter berdasarkan kategori di sini
                            print("Category clicked: $category");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              category,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const Gap(32),

                // Tags Section
                Column(
                  children: [
                    const Text(
                      "Tags",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Gap(16),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: tags.map((tag) {
                        return GestureDetector(
                          onTap: () {
                            // Tambahkan logika untuk filter berdasarkan tag di sini
                            print("Tag clicked: $tag");
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Text(
                              tag,
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),

                const Gap(20),

                // Footer Widget
                const FooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}