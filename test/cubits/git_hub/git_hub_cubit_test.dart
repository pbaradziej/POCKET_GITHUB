import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pocket_github/cubits/git_hub/git_hub_cubit.dart';
import 'package:pocket_github/models/git_hub_repository_item.dart';
import 'package:pocket_github/repositories/git_hub_repository.dart';

class MockGitHubRepository extends Mock implements GitHubRepository {}

void main() {
  late GitHubCubit cubit;
  late GitHubRepository gitHubRepository;
  late List<GitHubRepositoryItem> items;
  const GitHubRepositoryItem item = GitHubRepositoryItem(
    url: 'test2',
    fullName: 'repository name 2',
    description: 'example description 2',
    language: 'java',
    starGazers: 1555,
    lastUpdated: '25/02/2022',
  );

  setUp(TestWidgetsFlutterBinding.ensureInitialized);

  setUp(() {
    gitHubRepository = MockGitHubRepository();
    cubit = GitHubCubit(
      repository: gitHubRepository,
    );
    items = <GitHubRepositoryItem>[item];
  });

  test('should have initial state', () {
    // assert
    const GitHubState gitHubState = GitHubState(status: GitHubStatus.initial);
    expect(cubit.state, gitHubState);
  });

  blocTest<GitHubCubit, GitHubState>(
    'emits loaded state for searchForGitHubRepositories',
    build: () => cubit,
    setUp: () => when(() => gitHubRepository.searchForGitHubRepositories(any())).thenAnswer(
      (_) async => items,
    ),
    act: (GitHubCubit cubit) => cubit.searchForGitHubRepositories('test'),
    expect: () => <TypeMatcher<GitHubState>>[
      isA<GitHubState>()
          .having(
        (GitHubState state) => state.status,
        'state.loading',
        GitHubStatus.loading,
      )
          .having(
        (GitHubState state) => state.items,
        'state.items',
        <GitHubRepositoryItem>[],
      ),
      isA<GitHubState>()
          .having(
            (GitHubState state) => state.status,
            'state.loaded',
            GitHubStatus.loaded,
          )
          .having(
            (GitHubState state) => state.items,
            'state.items',
            items,
          ),
    ],
  );
}
