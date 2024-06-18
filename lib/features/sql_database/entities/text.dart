import "dart:typed_data";

import "package:floor/floor.dart";

@entity
class TextEntity {
  @PrimaryKey(autoGenerate: true)
  final int textId;

  final String textTopic, textData;

  final int? eventType;

  final String? dateTime;
   
   
   final bool? hasImage;
   

  final Uint8List? imageData;

  const TextEntity({
      required this.hasImage, 
      required this.textId,
      required this.textTopic,
      required this.textData,
      required this.imageData,
      required this.dateTime,
      required this.eventType});
}
