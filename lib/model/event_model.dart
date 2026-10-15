class EventModel {
  String id;
  String title;
  String description;
  String category;
  DateTime date;
  String time;
  bool isFavorite;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    this.category = 'General',
    required this.date,
    this.time = '12:00 PM',
    this.isFavorite = false,
  });
}