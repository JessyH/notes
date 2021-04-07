class Note {
  final int id;
  final String title;
  final DateTime creationDate;
  DateTime modificationDate;
  int words = 0;
  int characters = 0;
  bool pinned = false;

  String get ellapsedTime {
    final difference = DateTime.now().difference(this.modificationDate);
    if (difference.isNegative) {
      return "0m";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h";
    } else if (difference.inDays < 365) {
      return "${difference.inDays}d";
    } else {
      return "${difference.inDays ~/ 365}y";
    }
  }

  Note({
    required this.id,
    required this.title,
    required this.creationDate,
    required this.modificationDate,
    required this.pinned,
  });
}
