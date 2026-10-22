import 'assets_manager.dart';

abstract final class AppConstants {
  static const String emailRegex = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static const List<String> types = [
    'Sport',
    'Birthday',
    "Book",
    "Meeting",
    'Exhibition'
  ];

  static const Map<String,String> lightEventTypeBackground = {
    "Sport":AssetsManager.sport_light,
    "Birthday":AssetsManager.birthday_light,
    "Book":AssetsManager.book_light,
    "Meeting":AssetsManager.meeting_light,
    "Exhibition":AssetsManager.exhibition_light,
  };
  static const Map<String,String> darkEventTypeBackground = {
    "Sport":AssetsManager.sport_dark,
    "Birthday":AssetsManager.birthday_dark,
    "Book":AssetsManager.book_dark,
    "Meeting":AssetsManager.meeting_dark,
    "Exhibition":AssetsManager.exhibition_dark,
  };
}