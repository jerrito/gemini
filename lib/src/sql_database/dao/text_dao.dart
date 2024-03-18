import "package:floor/floor.dart";
import "package:gemini/src/sql_database/entities/text.dart";

@dao
abstract class TextDao {
  @Query("SELECT * FROM TextEntity")
  Future<List<TextEntity>> getAllTextData();

  // @Query("SELECT * FROM TextEntity WHERE textId= :textId")
  // Stream<TextEntity?> getTextData();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertData(TextEntity textEntity);
}
