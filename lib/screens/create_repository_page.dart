import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_git_hub/bloc/bloc_event.dart';
import 'package:flutter_git_hub/bloc/bloc_git_hub.dart';
import 'package:flutter_git_hub/utilits/funs.dart';
import 'package:github/github.dart';

class CreateRepositoryPage extends StatefulWidget {
  CreateRepositoryPage(this.gitHub);
  final GitHub gitHub;
  // Function(Repository) onCallback;

  @override
  State<CreateRepositoryPage> createState() => _CreateRepositoryPageState();
}

class _CreateRepositoryPageState extends State<CreateRepositoryPage> {
  TextEditingController controllerName = TextEditingController();

  TextEditingController controllerDescription = TextEditingController();

  bool isPrivate = false;

  void _createRepository() async {
    if (controllerName.text.isNotEmpty) {
      String name = controllerName.text;
      CreateRepository createRepository = CreateRepository(
        name,
        description: controllerDescription.text,
        private: isPrivate,
      );
      // Repository repo =
      widget.gitHub.repositories.createRepository(createRepository);
      //widget.onCallback.call(repo);
      Navigator.pop(context);
    } else {
      showToast('Enter the Repository Name');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Repository'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Repository name'),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  controller: controllerName,
                ),
              ),
              Text('Description (optional)'),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  controller: controllerDescription,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Public'),
                  CupertinoSwitch(
                      value: isPrivate,
                      onChanged: (value) {
                        setState(() {
                          isPrivate = value;
                        });
                      }),
                  const Text('Private'),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green)),
                    onPressed: _createRepository,
                    child: Text('Create repository')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
