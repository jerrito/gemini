import "package:floor/floor.dart";

@entity
class TextEntity {
  @PrimaryKey(autoGenerate:true)
  final int textId;

  final String textTopic, textData;

  const TextEntity({
    required this.textId,
    required this.textTopic,
    required this.textData,
  });
}
