import 'package:flutter/material.dart';

class CardEditName extends StatelessWidget {
  CardEditName(this.controller);

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
                  'Name:',
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
