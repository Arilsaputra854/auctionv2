class Article {
  final String title;
  final String imageAsset;
  final String category;
  final String date;

  Article({
    required this.title,
    required this.imageAsset,
    required this.category,
    required this.date,
  });
}

final List<Article> articles = [
  Article(
    title: 'Penghargaan Anugerah Reksa Bandha 2024',
    imageAsset: 'assets/image/djkn.png',
    category: 'Achievement',
    date: '21 Jan 2025',
  ),
  Article(
    title: 'Live Auction sambil Vacation?',
    imageAsset: 'assets/image/vacation.png',
    category: 'vacation',
    date: '20 Jan 2025',
  ),
  Article(
    title: 'Balai Lelang dengan capaian pokok lelang tertinggi pertama tahun 2024',
    imageAsset: 'assets/image/djkn2.png',
    category: 'Lelang',
    date: '19 Jan 2025',
  ),
  Article(
    title: 'Downstream Business Achievement & Growth dalam acara Tunas Convention 2025',
    imageAsset: 'assets/image/growth.png',
    category: 'Tunas Auction',
    date: '19 Jan 2025',
  ),
  // ... tambahkan artikel lainnya di sini
];