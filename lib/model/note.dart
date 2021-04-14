class Note {
  final int id;
  final String title;
  String body;
  final DateTime creationDate;
  DateTime modificationDate;
  bool pinned;

  static final int defaultId = -1;

  Note({
    required this.id,
    required this.title,
    this.body = '',
    DateTime? creationDate,
    DateTime? modificationDate,
    this.pinned = false,
  })  : this.creationDate = creationDate ?? DateTime.now(),
        this.modificationDate = modificationDate ?? DateTime.now();

  Note.empty({
    this.title = '',
    this.body = '',
    this.pinned = false,
  })  : this.id = defaultId,
        this.creationDate = DateTime.now(),
        this.modificationDate = DateTime.now();

  String get ellapsedTime {
    final difference = DateTime.now().difference(modificationDate);
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

  int get words => RegExp(r"(\w+)").allMatches(body).length;

  int get characters => body.length;
}
