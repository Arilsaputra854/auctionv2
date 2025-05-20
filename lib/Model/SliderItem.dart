class SliderItem {
  final String title;
  final String subtitle;
  final String link;
  final String image;
  final String? imageApps;

  SliderItem({
    required this.title,
    required this.subtitle,
    required this.link,
    required this.image,
    this.imageApps,
  });

  factory SliderItem.fromJson(Map<String, dynamic> json) {
    return SliderItem(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      link: json['link'] ?? '',
      image: json['image'] ?? '',
      imageApps: json['image_apps'],
    );
  }
}