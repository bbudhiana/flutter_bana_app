class HistoryQuery {
  static const String tableName = "histories";
  static const String createTable =
      " CREATE TABLE IF NOT EXISTS $tableName ( id INTEGER PRIMARY KEY AUTOINCREMENT, id_from INTEGER , id_to INTEGER, amount_transfer INTEGER ) ";
  static const String select = "select * from $tableName";
  static const String dropTable = " DROP TABLE $tableName ";
}
