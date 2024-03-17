import "package:floor/floor.dart";
import "package:gemini/src/sql_database/entities/text.dart";

abstract class TextDao {
  @Query("SELECT * FROM Text")
  Future<List<TextEntity>> getAllTextData();

  @Query("SELECT * FROM Text WHERE id= :id")
  Stream<TextEntity?> getTextData();

  @insert
  Future<void> insertData(TextEntity textEntity);
}
