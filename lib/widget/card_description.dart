import 'package:flutter/material.dart';

const hintDescription = 'No description, website, or topics provided.';

class CardDescription extends StatelessWidget {
  CardDescription({required this.description});
  final String description;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                description.isNotEmpty
                    ? Text(description)
                    : Text(hintDescription),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardDescriptionEdit extends StatelessWidget {
  CardDescriptionEdit(this.controller);
  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: controller,
                  decoration:
                      InputDecoration(border: const OutlineInputBorder()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
