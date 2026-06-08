class Shop {
  const Shop({
    required this.id,
    required this.name,
    required this.prefecture,
    required this.latitude,
    required this.longitude,
  });

  final String id;
  final String name;
  final String prefecture;
  final double latitude;
  final double longitude;
}
