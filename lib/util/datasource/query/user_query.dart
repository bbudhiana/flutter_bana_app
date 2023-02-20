class UserQuery {
  static const String tableName = "users";
  static const String createTable =
      " CREATE TABLE IF NOT EXISTS $tableName ( id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT , password TEXT, amount INTEGER ) ";
  static const String select = "select * from $tableName";
  static const String dropTable = " DROP TABLE IF EXISTS $tableName ";
}
