import 'package:ict_flex_app/types/model.dart';

class Article implements Model {
    const Article({
        required this.hash,
        required this.title,
        required this.uri,
        required this.createdAt,
        required this.content,
    });

    final String hash;
    final String title;
    final Uri uri;
    final DateTime createdAt;
    final String content;

    static const String table = 'articles';

    @override
    String tableName() => table;

    @override
    Map<String, Object?> toMap() => {
        'hash': hash,
        'title': title,
        'uri': uri.toString(),
        'created_at': createdAt.millisecondsSinceEpoch,
        'content': content,
    };

    static Article fromMap(Map<String, Object?> map) => Article(
        hash: map['hash'] as String,
        title: map['title'] as String,
        uri: Uri.parse(map['uri'] as String),
        createdAt: DateTime.fromMillisecondsSinceEpoch(
            map['created_at'] as int
        ),
        content: map['content'] as String,
    );

    @override
    String toString() => 'Article(hash: $hash, title: $title, uri: $uri, created_at: $createdAt, content: $content)';
}
