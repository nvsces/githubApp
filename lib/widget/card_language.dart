import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:random_color/random_color.dart';

class CardLanguage extends StatelessWidget {
  CardLanguage({this.listLanguage, required this.language});
  final LanguageBreakdown? listLanguage;
  final String language;

  RandomColor _randomColor = RandomColor();

  Widget _infoLanguage(String name, double value, Color color) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          color: color,
        ),
        Text('$name ' + value.toString().substring(0, 4) + '%'),
      ],
    );
  }

  Widget _buildLanguage(LanguageBreakdown params) {
    List<int> valueLanguage = [];
    List<String> nameLanguage = [];
    int summaryValue = 0;
    params.info.forEach((key, value) {
      nameLanguage.add(key);
      valueLanguage.add(value);
      summaryValue = summaryValue + value;
    });

    List<Widget> colorList = List.generate(
      nameLanguage.length,
      (i) => _infoLanguage(
        nameLanguage[i],
        valueLanguage[i] / summaryValue,
        _randomColor.randomColor(),
      ),
    );

    return Wrap(
      textDirection: TextDirection.ltr,
      //alignment: WrapAlignment.end,
      direction: Axis.horizontal,
      //direction: Axis.horizontal,
      children: colorList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  'Languages',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              if (listLanguage == null)
                Text('$language 100%')
              else
                _buildLanguage(listLanguage!)
            ],
          ),
        ),
      ),
    );
  }
}
