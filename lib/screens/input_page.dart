import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_git_hub/bloc/bloc_git_hub.dart';
import 'package:flutter_git_hub/screens/home_page.dart';
import 'package:flutter_git_hub/utilits/funs.dart';
import 'package:github/github.dart';

const hintInputText = 'Введите персональный токен доступа к GitHub';

class InputPageScreen extends StatefulWidget {
  const InputPageScreen({Key? key}) : super(key: key);

  @override
  State<InputPageScreen> createState() => _InputPageScreenState();
}

class _InputPageScreenState extends State<InputPageScreen> {
  TextEditingController controller = TextEditingController();

  _doneWithToken() {
    if (controller.text.isNotEmpty) {
      GitHub gitHub = GitHub(auth: Authentication.withToken(controller.text));
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return BlocProvider(
            create: (context) => BlocGitHub(gitHub), child: HomePage());
      }));
    } else {
      showToast('Введите токен');
    }
  }

  _done() {
    GitHub gitHub = GitHub();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return BlocProvider(
          create: (context) => BlocGitHub(gitHub), child: HomePage());
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(hintInputText),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                  controller: controller,
                ),
              ),
              TextButton(
                  onPressed: _doneWithToken, child: const Text('Продолжить')),
              TextButton(
                  onPressed: _done, child: const Text('Войти без токена')),
            ],
          ),
        ),
      ),
    );
  }
}
