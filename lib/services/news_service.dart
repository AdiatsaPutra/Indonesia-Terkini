part of 'services.dart';

class NewsService {
  static Future<List<News>> getNews({http.Client client}) async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=id&apiKey=cb51182a924340979c3ad02a933b35ef";

    var response = await http.get(url);

    if (response.statusCode != 200) {
      return [];
    }

    var data = jsonDecode(response.body);

    List result = data['articles'];

    return result.map((e) => News.fromJson(e)).toList();
  }
}
