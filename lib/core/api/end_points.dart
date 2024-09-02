class EndPoints {
  static const String url =
      "https://api.thenewsapi.com/v1/news/top?api_token=1SjeknetnACfilXUPohP9HdWZZvISu2zmSCOCcRK&locale=us";

  static const String baseUrl = "https://api.thenewsapi.com/v1/";
  static const String headLineEndPoint = "news/top";

  static Map<String, dynamic> query({String? category, int? page}) => {
        'categories': category ?? 'general',
        'apiKey': '1SjeknetnACfilXUPohP9HdWZZvISu2zmSCOCcRK',
        'limit': 3,
        'page': page ?? 1,
        'country': 'us',
      };
}
