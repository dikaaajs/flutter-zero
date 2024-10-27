class Note {
  final String id; // ID unik untuk setiap catatan
  final String title; // Judul catatan
  final String text; // Teks catatan
  final DateTime createdAt; // Waktu dibuat
  final DateTime updatedAt; // Waktu terakhir diperbarui

  Note({
    required this.id,
    required this.title,
    required this.text,
    required this.createdAt,
    required this.updatedAt,
  });
}

List<Note> dummyNotes = [
  Note(
    id: '1',
    title: 'First Note',
    text: 'This is the text of the first note.',
    createdAt: DateTime.now()
        .subtract(const Duration(days: 3)), // Dibuat 3 hari yang lalu
    updatedAt: DateTime.now()
        .subtract(const Duration(days: 1)), // Diperbarui 1 hari yang lalu
  ),
  Note(
    id: '2',
    title: 'Second Note',
    text: 'This is the text of the second note.',
    createdAt: DateTime.now()
        .subtract(const Duration(days: 2)), // Dibuat 2 hari yang lalu
    updatedAt: DateTime.now()
        .subtract(const Duration(hours: 12)), // Diperbarui 12 jam yang lalu
  ),
  Note(
    id: '3',
    title: 'Third Note',
    text: 'This is the text of the third note.',
    createdAt: DateTime.now()
        .subtract(const Duration(days: 1)), // Dibuat 1 hari yang lalu
    updatedAt: DateTime.now(), // Diperbarui sekarang
  ),
];
