class Report {
  const Report({
    required this.id,
    required this.catName,
    required this.summary,
    required this.description,
    required this.place,
    required this.reportedAt,
    required this.photo,
  });

  final String id;
  final String? catName;
  final String summary;
  final String description;
  final String place;
  final DateTime reportedAt;
  final String photo;
}
