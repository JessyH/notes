class Note {
  final int id;
  final String title;
  final DateTime creationDate;
  DateTime modificationDate;
  int words = 0;
  int characters = 0;
  bool pinned = false;

  Note({
    required this.id,
    required this.title,
    required this.creationDate,
    required this.modificationDate,
    required this.pinned,
  });
}
