class EndPoints {
  static const String url =
      "https://api.thenewsapi.com/v1/news/top?api_token=UI9PcWehAb2IpnmUWXiA3L490lwB3L02LLQI1WJl&locale=us";

  static const String baseUrl = "https://api.thenewsapi.com/v1/";
  static const String headLineEndPoint = "news/top";

  static Map<String, dynamic> query({String? category, int? page}) => {
        'categories': category ?? 'general',
        'apiKey': 'UI9PcWehAb2IpnmUWXiA3L490lwB3L02LLQI1WJl',
        'limit': 3,
        'page': page ?? 1,
        'country': 'us',
      };
}
