import 'dart:async';
import 'dart:convert';

import 'package:pocket_github/providers/http_provider.dart';

class GitHubProvider extends HttpProvider {
  static const String URL_GIT_HUB_SEARCH = 'https://api.github.com/search/repositories';
  static const String PAGE_ITEMS_LIMIT = '?per_page=10';

  Future<List<Map<String, Object?>>> searchForGitHubRepositories(String search) async {
    final String parsedSearch = _parseSearch(search);
    final String url = '$URL_GIT_HUB_SEARCH$PAGE_ITEMS_LIMIT&q=$parsedSearch';
    final String response = await get(url: url);
    final Map<String, Object?> decodedResponse = json.decode(response) as Map<String, Object?>;
    final List<Object?>? items = decodedResponse['items'] as List<Object?>?;
    if (items != null) {
      return List<Map<String, Object?>>.from(items);
    }

    return <Map<String, Object?>>[];
  }

  Future<List<Map<String, Object?>>> getIssuesOfRepository(String repositoryUrl) async {
    final String url = '$repositoryUrl/issues$PAGE_ITEMS_LIMIT';
    final String response = await get(url: url);
    final List<Object?> decodedResponse = json.decode(response) as List<Object?>;

    return List<Map<String, Object?>>.from(decodedResponse);
  }

  String _parseSearch(String search) {
    return search.replaceAll(' ', '+');
  }
}
