import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pocket_github/models/git_hub_repository_issues.dart';
import 'package:pocket_github/models/git_hub_repository_item.dart';
import 'package:pocket_github/providers/git_hub_provider.dart';
import 'package:pocket_github/repositories/git_hub_repository.dart';

class MockGitHubProvider extends Mock implements GitHubProvider {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  late GitHubProvider gitHubProvider;
  late GitHubRepository repository;

  setUp(() {
    gitHubProvider = MockGitHubProvider();
    repository = GitHubRepository(
      provider: gitHubProvider,
    );
  });

  group('git hub operations', () {
    test('should get items', () async {
      // arrange
      final List<Map<String, Object>> items = <Map<String, Object>>[
        <String, Object>{
          'url': 'test',
          'full_name': 'repository name',
          'description': 'example description',
          'language': 'dart',
          'stargazers_count': 5,
          'updated_at': '2023-07-25T10:00:00Z',
        },
        <String, Object>{
          'url': 'test2',
          'full_name': 'repository name 2',
          'description': 'example description 2',
          'language': 'java',
          'stargazers_count': 1555,
          'updated_at': '2022-02-25T10:00:00Z',
        },
      ];
      const GitHubRepositoryItem gitHubRepositoryItem = GitHubRepositoryItem(
        url: 'test',
        fullName: 'repository name',
        description: 'example description',
        language: 'dart',
        starGazers: 5,
        lastUpdated: '25/07/2023',
      );
      const GitHubRepositoryItem gitHubRepositorySecondItem = GitHubRepositoryItem(
        url: 'test2',
        fullName: 'repository name 2',
        description: 'example description 2',
        language: 'java',
        starGazers: 1555,
        lastUpdated: '25/02/2022',
      );
      when(() => gitHubProvider.searchForGitHubRepositories(any())).thenAnswer((_) async => items);

      // act
      final List<GitHubRepositoryItem> gitHubRepositoryItems = await repository.searchForGitHubRepositories('test');

      // assert
      expect(gitHubRepositoryItems, <GitHubRepositoryItem>[
        gitHubRepositoryItem,
        gitHubRepositorySecondItem,
      ]);
    });

    test('should get issues', () async {
      // arrange
      final List<Map<String, Object>> issues = <Map<String, Object>>[
        <String, Object>{
          'title': 'title',
          'body': 'body',
          'state': 'open',
        },
        <String, Object>{
          'title': 'title2',
          'body': 'body2',
          'state': 'closed',
        },
      ];
      const GitHubRepositoryIssue gitHubRepositoryIssue = GitHubRepositoryIssue(
        title: 'title',
        body: 'body',
        state: 'open',
      );
      const GitHubRepositoryIssue gitHubRepositorySecondIssue = GitHubRepositoryIssue(
        title: 'title2',
        body: 'body2',
        state: 'closed',
      );
      when(() => gitHubProvider.getIssuesOfRepository(any())).thenAnswer((_) async => issues);

      // act
      final List<GitHubRepositoryIssue> gitHubRepositoryIssues = await repository.getIssuesOfRepository('test');

      // assert
      expect(gitHubRepositoryIssues, <GitHubRepositoryIssue>[
        gitHubRepositoryIssue,
        gitHubRepositorySecondIssue,
      ]);
    });
  });
}
