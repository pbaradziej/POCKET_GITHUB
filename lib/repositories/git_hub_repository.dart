import 'package:pocket_github/models/git_hub_repository_issues.dart';
import 'package:pocket_github/models/git_hub_repository_item.dart';
import 'package:pocket_github/providers/git_hub_provider.dart';

class GitHubRepository {
  final GitHubProvider provider;

  GitHubRepository({GitHubProvider? provider}) : provider = provider ?? GitHubProvider();

  Future<List<GitHubRepositoryItem>> searchForGitHubRepositories(String search) async {
    final List<Map<String, Object?>> body = await provider.searchForGitHubRepositories(search);
    return body.map(GitHubRepositoryItem.fromJson).toList();
  }

  Future<List<GitHubRepositoryIssue>> getIssuesOfRepository(String url) async {
    final List<Map<String, Object?>> body = await provider.getIssuesOfRepository(url);
    return body.map(GitHubRepositoryIssue.fromJson).toList();
  }
}
