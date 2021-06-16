import 'package:flutter/material.dart';

const hitntReadmy = 'This repository does not have Readmy.md';

class CardReadmy extends StatelessWidget {
  const CardReadmy(this.readmyText);
  final String readmyText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Readmy.md:',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                readmyText.isNotEmpty
                    ? Text(readmyText)
                    : const Text(hitntReadmy),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
