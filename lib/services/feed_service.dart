import 'package:http/http.dart' as http;
import 'package:ict_flex_app/types/article.dart';
import 'package:xml/xml.dart';

class FeedService {
    Future<List<Article>> articles() async {
        var url = Uri.https('rss.bjvanbemmel.nl', 'ict-flex');
        var response = await http.read(url);

        final document = XmlDocument.parse(response);
        final items = document.findAllElements('item');

        List<Article> articles = [];
        for (var item in items) {
            final String? hash = _hashFromItem(item);
            if (hash == null) continue;

            final String? title = _titleFromItem(item);
            if (title == null) continue;

            final Uri? uri = _uriFromItem(item);
            if (uri == null) continue;

            final DateTime? createdAt = _createdFromItem(item);
            if (createdAt == null) continue;

            final String? content = _contentFromItem(item);
            if (content == null) continue;

            Article article = Article(
                hash: hash,
                title: title,
                uri: uri,
                createdAt: createdAt,
                content: content,
            );

            articles.add(article);
        }

        return articles;
    }

    String? _hashFromItem(XmlElement item) =>
        item.findAllElements('guid')
            .firstOrNull
            ?.innerText;

    String? _titleFromItem(XmlElement item) =>
        item.findAllElements('title')
            .firstOrNull
            ?.innerText;

    Uri? _uriFromItem(XmlElement item) {
        final String? link = item.findAllElements('link')
            .firstOrNull
            ?.innerText;

        if (link == null) return null;

        return Uri.parse(link);
    }

    DateTime? _createdFromItem(XmlElement item) {
        final String? formatted = item.findAllElements('pubDate')
            .firstOrNull
            ?.innerText;

        if (formatted == null) return null;

        return DateTime.tryParse(formatted);
    }

    String? _contentFromItem(XmlElement item) =>
        item.findAllElements('description')
            .firstOrNull
            ?.innerText;
}
