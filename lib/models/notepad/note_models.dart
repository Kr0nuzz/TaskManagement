import 'package:hive_flutter/hive_flutter.dart';

part 'note_models.g.dart';

@HiveType(typeId: 0)
class NoteModels {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String body;

  NoteModels({required this.title, required this.body});
}