import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_git_hub/utilits/funs.dart';

class CardClone extends StatefulWidget {
  CardClone({required this.httpsUrl, required this.sshUrl});
  final String httpsUrl;
  final String sshUrl;

  @override
  State<CardClone> createState() => _CardCloneState();
}

class _CardCloneState extends State<CardClone> {
  TextEditingController controllerHttp = TextEditingController();

  TextEditingController controllerSsh = TextEditingController();

  @override
  void initState() {
    controllerHttp.text = widget.httpsUrl;
    controllerSsh.text = widget.sshUrl;
    super.initState();
  }

  _copyToBuffer(String copyText) {
    Clipboard.setData(ClipboardData(text: copyText));
    showToast('Текст скопирован в буфер обмена');
  }

  _buildTextField({
    TextEditingController? controller,
    Function()? copyFunction,
    String? helperText,
  }) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            helperText: helperText,
            suffixIcon: TextButton(
              child: const Text('Copy'),
              onPressed: copyFunction,
            ),
            border: const OutlineInputBorder()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: const Text(
                  'Clone',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildTextField(
                  controller: controllerHttp,
                  copyFunction: () => _copyToBuffer(controllerHttp.text),
                  helperText: 'HTTPS'),
              _buildTextField(
                  controller: controllerSsh,
                  copyFunction: () => _copyToBuffer(controllerSsh.text),
                  helperText: 'SSH'),
            ],
          ),
        ),
      ),
    );
  }
}
