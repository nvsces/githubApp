import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_git_hub/bloc/bloc_event.dart';
import 'package:flutter_git_hub/bloc/bloc_git_hub.dart';
import 'package:flutter_git_hub/bloc/bloc_state.dart';
import 'package:flutter_git_hub/screens/detail_perository_page.dart';
import 'package:github/github.dart';

import 'package:random_color/random_color.dart';

import 'create_repository_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RandomColor _randomColor = RandomColor();

  TextEditingController controller = TextEditingController();
  List<Repository> repos = [];
  String text = '';

  @override
  void initState() {
    super.initState();
  }

  _serchRepository() {
    context.read<BlocGitHub>().add(EventSearchRepository(controller.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (context.read<BlocGitHub>().isAdmin)
            TextButton(
                onPressed: () {
                  var github = context.read<BlocGitHub>().gitHub;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateRepositoryPage(github)));
                },
                child: Text(
                  'FAB',
                  style: TextStyle(color: Colors.white),
                )),
        ],
      ),
      body: Container(
        child: Center(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: _serchRepository,
                    ),
                    border: OutlineInputBorder()),
                controller: controller,
              ),
            ),
            BlocBuilder<BlocGitHub, BlocState>(builder: (context, state) {
              if (state is RepositoryLoadingState) {
                return const CircularProgressIndicator();
              }
              if (state is RepositoryLoadedState) {
                var gitHub = context.read<BlocGitHub>().gitHub;
                return Expanded(
                  child: ListView.builder(
                      itemCount: state.repos.length,
                      itemBuilder: (context, i) {
                        return Card(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: ListTile(
                                onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailReposytoryPage(
                                                  repository: state.repos[i],
                                                  gitHub: gitHub)),
                                    ),
                                leading: Icon(
                                  Icons.circle,
                                  color: _randomColor.randomColor(),
                                ),
                                subtitle: Text(state.repos[i].description),
                                title: Text(state.repos[i].fullName),
                                trailing: Text(state.repos[i].language)),
                          ),
                        );
                      }),
                );
              } else {
                return Center(
                  child: Text('Empty'),
                );
              }
            }),
          ],
        )),
      ),
    );
  }
}
