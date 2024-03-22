import 'package:http/http.dart' as http;
import 'package:ict_flex_app/state/feed_state.dart';
import 'package:ict_flex_app/types/article.dart';
import 'package:intl/intl.dart';
import 'package:xml/xml.dart';

class FeedService {
    final FeedState _feedState = FeedState();
    static DateTime? lastUpdated;

    Future<List<Article>> articles() async {
        var url = Uri.https('ict-flex.nl', 'feed');
        var response = await http.read(url);

        final document = XmlDocument.parse(response);
        final items = document.findAllElements('item');

        List<Article> articles = [];
        for (var item in items) {
            final String? title = titleFromItem(item);
            if (title == null) continue;

            final String? author = authorFromItem(item);
            if (author == null) continue;

            final DateTime? createdAt = createdFromItem(item);
            if (createdAt == null) continue;

            Article article = Article(
                title: title,
                author: author,
                createdAt: createdAt,
            );

            articles.add(article);
        }

        lastUpdated = DateTime.now();
        _feedState.articles = articles;

        return articles;
    }

    String? titleFromItem(XmlElement item) {
        return item.findAllElements('title')
            .firstOrNull
            ?.innerText;
    }

    String? authorFromItem(XmlElement item) {
        return item.findAllElements('dc:creator')
            .firstOrNull
            ?.innerText;
    }

    DateTime? createdFromItem(XmlElement item) {
            String? formatted = item.findAllElements('pubDate')
            .firstOrNull
            ?.innerText;

            if (formatted == null) return null;

            return DateFormat('EEE, dd MMM yyyy hh:mm:ss Z').tryParse(formatted);
    }
}
