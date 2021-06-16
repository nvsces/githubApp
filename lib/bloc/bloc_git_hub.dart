import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_git_hub/bloc/bloc_event.dart';
import 'package:flutter_git_hub/bloc/bloc_state.dart';
import 'package:github/github.dart';

class BlocGitHub extends Bloc<BlocEvent, BlocState> {
  BlocGitHub(this.gitHub) : super(BlocEmptyState());
  final GitHub gitHub;

  bool get isAdmin {
    if (gitHub.auth != null) {
      if (gitHub.auth!.token != null && gitHub.auth!.token!.isNotEmpty) {
        return true;
      } else
        return false;
    } else
      return false;
  }

  List<Repository> repos = [];

  void editVisibylityRepository(Repository repository, bool private) {
    gitHub.repositories.editRepository(
      repository.slug(),
      private: private,
      name: repository.name,
      description: repository.description,
      homepage: repository.homepage,
      hasDownloads: repository.hasDownloads,
      hasIssues: repository.hasIssues,
      hasWiki: repository.hasWiki,
    );
  }

  void editNameRepository(Repository repository, String name) {
    gitHub.repositories.editRepository(
      repository.slug(),
      private: repository.isPrivate,
      name: name,
      description: repository.description,
      homepage: repository.homepage,
      hasDownloads: repository.hasDownloads,
      hasIssues: repository.hasIssues,
      hasWiki: repository.hasWiki,
    );
  }

  void editDescriptionRepository(Repository repository, String description) {
    gitHub.repositories.editRepository(
      repository.slug(),
      private: repository.isPrivate,
      name: repository.name,
      description: description,
      homepage: repository.homepage,
      hasDownloads: repository.hasDownloads,
      hasIssues: repository.hasIssues,
      hasWiki: repository.hasWiki,
    );
  }

  // void createRepository(CreateRepository createRepository) {
  //   // gitHub.repositories.createRepository(CreateRepository(name));
  // }

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    if (event is EventEditVisibylity) {
      editVisibylityRepository(event.repository, event.private);
    } else if (event is EventEditName) {
      editNameRepository(event.repository, event.name);
    } else if (event is EventEditDescription) {
      editDescriptionRepository(event.repository, event.description);
    }
    if (event is EventUpdate) {
      yield RepositoryLoadedState(repos);
    } else if (event is EventSearchRepository) {
      repos.clear();
      yield RepositoryLoadingState();
      gitHub.search.repositories(event.query).listen((event) {
        repos.add(event);
        add(EventUpdate());
      });
    } else {
      yield BlocEmptyState();
    }
  }
}
