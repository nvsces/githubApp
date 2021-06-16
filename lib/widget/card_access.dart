import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_git_hub/bloc/bloc_event.dart';
import 'package:flutter_git_hub/bloc/bloc_git_hub.dart';
import 'package:github/github.dart';
import 'package:github/src/common/model/repos.dart';

class CardAccess extends StatefulWidget {
  CardAccess({required this.repository, required this.gitHub});
  Repository repository;
  GitHub gitHub;
  @override
  State<CardAccess> createState() => _CardAccessState();
}

class _CardAccessState extends State<CardAccess> {
  bool isPrivate = false;
  bool isAdmin = false;

  void init() {
    if (widget.repository.permissions != null) {
      isAdmin = widget.repository.permissions!.admin;
    }
    isPrivate = widget.repository.isPrivate;
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  void changeVisibylityRepository(bool value) {
    widget.gitHub.repositories.editRepository(
      widget.repository.slug(),
      private: value,
      name: widget.repository.name,
      description: widget.repository.description,
      homepage: widget.repository.homepage,
      hasDownloads: widget.repository.hasDownloads,
      hasIssues: widget.repository.hasIssues,
      hasWiki: widget.repository.hasWiki,
    );
    // context.read<BlocGitHub>().add(
    //     EventEditVisibylity(repository: widget.repository, private: value));
    setState(() {
      isPrivate = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Repository Visibility',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              isPrivate
                  ? Text('This repository is currently private')
                  : Text('This repository is currently public'),
              if (isAdmin)
                CupertinoSwitch(
                    value: isPrivate,
                    onChanged: (value) => changeVisibylityRepository(value)),
            ],
          ),
        ),
      ),
    );
  }
}
