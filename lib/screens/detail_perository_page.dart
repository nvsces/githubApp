import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_git_hub/bloc/bloc_event.dart';
import 'package:flutter_git_hub/bloc/bloc_git_hub.dart';
import 'package:flutter_git_hub/utilits/funs.dart';
import 'package:flutter_git_hub/widget/card_access.dart';
import 'package:flutter_git_hub/widget/card_clone.dart';
import 'package:flutter_git_hub/widget/card_description.dart';
import 'package:flutter_git_hub/widget/card_edit_name.dart';
import 'package:flutter_git_hub/widget/card_language.dart';
import 'package:flutter_git_hub/widget/card_readmy.dart';
import 'package:github/github.dart';
import 'package:random_color/random_color.dart';

class DetailReposytoryPage extends StatefulWidget {
  DetailReposytoryPage({
    required this.gitHub,
    required this.repository,
  });
  Repository repository;
  GitHub gitHub;

  @override
  _DetailReposytoryPageState createState() => _DetailReposytoryPageState();
}

class _DetailReposytoryPageState extends State<DetailReposytoryPage> {
  String name = '';
  String description = '';
  String textReadmy = '';
  LanguageBreakdown? listLanguage;
  GitHubFile? readmy;
  bool isAdmin = false;
  bool isEdit = false;
  TextEditingController controllerEditDescription = TextEditingController();
  TextEditingController controllerEditName = TextEditingController();

  void initPermission() {
    if (widget.repository.permissions != null) {
      setState(() {
        isAdmin = widget.repository.permissions!.admin;
      });
    }
  }

  initLanguage() async {
    listLanguage = await widget.gitHub.repositories
        .listLanguages(widget.repository.slug());
    try {
      readmy =
          await widget.gitHub.repositories.getReadme(widget.repository.slug());
      textReadmy = readmy!.text;
    } catch (_) {}

    setState(() {});
  }

  initFields() {
    name = widget.repository.name;
    description = widget.repository.description;
    initLanguage();
    initPermission();
    controllerEditDescription.text = widget.repository.description;
    controllerEditName.text = widget.repository.name;
  }

  @override
  void initState() {
    initFields();
    super.initState();
  }

  void _deleteRepository() {
    widget.gitHub.repositories.deleteRepository(widget.repository.slug());
    showToast('Репозиторий удален');
    Navigator.pop(context);
  }

  void _startEdit() {
    setState(() {
      isEdit = true;
    });
  }

  void _finishEdit() {
    if (controllerEditName.text.isNotEmpty) {
      name = controllerEditName.text;
      description = controllerEditDescription.text;
      widget.gitHub.repositories.editRepository(
        widget.repository.slug(),
        name: name,
        description: description,
        private: widget.repository.isPrivate,
        homepage: widget.repository.homepage,
        hasDownloads: widget.repository.hasDownloads,
        hasIssues: widget.repository.hasIssues,
        hasWiki: widget.repository.hasWiki,
      );
      setState(() {
        isEdit = false;
      });
    } else {
      showToast('Имя не может быть пустым');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (isAdmin && !isEdit)
            IconButton(onPressed: _startEdit, icon: const Icon(Icons.edit))
          else if (isAdmin && isEdit)
            IconButton(onPressed: _finishEdit, icon: const Icon(Icons.done)),
        ],
        title: Text(widget.repository.fullName),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  widget.repository.fullName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              isEdit
                  ? CardEditName(controllerEditName)
                  : Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Name:${name}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
              isEdit
                  ? CardDescriptionEdit(controllerEditDescription)
                  : CardDescription(description: description),
              CardClone(
                  httpsUrl: widget.repository.cloneUrl,
                  sshUrl: widget.repository.sshUrl),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                    child: CardLanguage(
                  listLanguage: listLanguage,
                  language: widget.repository.language,
                )),
                Expanded(
                    child: CardAccess(
                  repository: widget.repository,
                  gitHub: widget.gitHub,
                ))
              ]),
              CardReadmy(textReadmy),
              if (isAdmin)
                Padding(
                  padding: EdgeInsets.all(20),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red)),
                      onPressed: _deleteRepository,
                      child: Text('Delete repository')),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
