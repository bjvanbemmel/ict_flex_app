import 'package:ict_flex_app/types/model.dart';

class Read extends Model<String> {
    Read({
        required this.articleId,
    });

    final String articleId;

    static const String table = 'reads';

    @override
    String tableName() => table;

    @override
    String id() => articleId;

    @override
    Map<String, Object?> toMap() => {
        'id': articleId,
    };

    static Read fromMap(Map<String, Object?> map) => Read(
        articleId: map['id'] as String,
    );

    static List<Read> fromMapList(List<Map<String, Object?>> list) => list
        .map((x) => Read.fromMap(x))
        .toList();
}
