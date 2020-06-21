import 'package:flutter/material.dart';

class EditMarks extends StatelessWidget {
  final String subComb;
  EditMarks(this.subComb);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(subComb == 'smcs'
                          ? 'Statistics'
                          : (subComb == 'pmcs'
                              ? 'pmcs'
                              : (subComb == 'pecs'
                                  ? 'pecs'
                                  : (subComb == 'secs'
                                      ? 'secs'
                                      : (subComb == 'pccs'
                                          ? 'pccs'
                                          : (subComb == 'pme'
                                              ? 'pme'
                                              : 'pcm')))))),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
