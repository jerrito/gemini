import "dart:typed_data";

import "package:floor/floor.dart";

@entity
class TextEntity {
  @PrimaryKey(autoGenerate: true)
  final int textId;

  final String textTopic, textData;

  final int? eventType;

  final String? dateTime;

  final Uint8List? imageData;

  const TextEntity(
      {required this.textId,
      required this.textTopic,
      required this.textData,
      this.imageData,
      this.dateTime,
      this.eventType});
}
