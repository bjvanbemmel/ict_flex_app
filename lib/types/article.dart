class Article {
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
}
