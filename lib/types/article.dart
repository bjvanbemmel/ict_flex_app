class Article {
    const Article({
        required this.title,
        required this.author,
        required this.createdAt,
    });

    final String title;
    final String author;
    final DateTime createdAt;
}
