import 'package:test/test.dart';
import 'package:notes/model/note.dart';

void main() {
  group('Ellapsed time', () {
    test(
      'should return "0m" when last modification > now',
      () {
        final note = Note(
          id: 1,
          title: 'Note',
          creationDate: DateTime.now(),
          modificationDate: DateTime.now().add(const Duration(hours: 1)),
          pinned: true,
        );
        expect(note.ellapsedTime, '0m');
      },
    );
    test(
      'should return the number of minutes when last modification < 1 hour',
      () {
        final note = Note(
          id: 1,
          title: 'Note',
          creationDate: DateTime.now(),
          modificationDate: DateTime.now().subtract(const Duration(minutes: 30)),
          pinned: true,
        );
        expect(note.ellapsedTime, '30m');
      },
    );
    test(
      'should return the number of hours when last modification < 1 day',
      () {
        final note = Note(
          id: 1,
          title: 'Note',
          creationDate: DateTime.now(),
          modificationDate: DateTime.now().subtract(const Duration(hours: 3)),
          pinned: true,
        );
        expect(note.ellapsedTime, '3h');
      },
    );
    test(
      'should return the number of days when last modification < 1 year',
      () {
        final note = Note(
          id: 1,
          title: 'Note',
          creationDate: DateTime.now(),
          modificationDate: DateTime.now().subtract(const Duration(days: 30)),
          pinned: true,
        );
        expect(note.ellapsedTime, '30d');
      },
    );
    test(
      'should return the number of years when last modification > 1 year',
      () {
        final note = Note(
          id: 1,
          title: 'Note',
          creationDate: DateTime.now(),
          modificationDate: DateTime.now().subtract(const Duration(days: 450)),
          pinned: true,
        );
        expect(note.ellapsedTime, '1y');
      },
    );
  });
}
