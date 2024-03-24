abstract class Model<T> {
    Map<String, Object?> toMap();
    String tableName();
    T id();
}
