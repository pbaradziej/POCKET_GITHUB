import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pocket_github/cubits/git_hub_issues/git_hub_issues_cubit.dart';
import 'package:pocket_github/models/git_hub_repository_issues.dart';
import 'package:pocket_github/repositories/git_hub_repository.dart';

class MockGitHubRepository extends Mock implements GitHubRepository {}

void main() {
  late GitHubIssuesCubit cubit;
  late GitHubRepository gitHubRepository;
  late List<GitHubRepositoryIssue> issues;
  const GitHubRepositoryIssue issue = GitHubRepositoryIssue(
    title: 'title',
    body: 'body',
    state: 'open',
  );

  setUp(TestWidgetsFlutterBinding.ensureInitialized);

  setUp(() {
    gitHubRepository = MockGitHubRepository();
    cubit = GitHubIssuesCubit(
      repository: gitHubRepository,
    );
    issues = <GitHubRepositoryIssue>[issue];
  });

  test('should have initial state', () {
    // assert
    const GitHubIssuesState gitHubIssuesState = GitHubIssuesState(status: GitHubIssuesStatus.loading);
    expect(cubit.state, gitHubIssuesState);
  });

  blocTest<GitHubIssuesCubit, GitHubIssuesState>(
    'emits loaded state for getIssuesOfRepository',
    build: () => cubit,
    setUp: () => when(() => gitHubRepository.getIssuesOfRepository(any())).thenAnswer(
      (_) async => issues,
    ),
    act: (GitHubIssuesCubit cubit) => cubit.initializeIssuesOfRepository('test'),
    expect: () => <TypeMatcher<GitHubIssuesState>>[
      isA<GitHubIssuesState>()
          .having(
            (GitHubIssuesState state) => state.status,
            'state.loaded',
            GitHubIssuesStatus.loaded,
          )
          .having(
            (GitHubIssuesState state) => state.issues,
            'state.issues',
            issues,
          ),
    ],
  );
}
