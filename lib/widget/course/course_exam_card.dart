import 'package:baas_study/model/exam_model.dart';
import 'package:flutter/material.dart';

class CourseExamCard extends StatelessWidget {
  final ExamModel exam;
  final String answer;
  final bool finished;
  final void Function(String value) onChanged;

  const CourseExamCard({
    Key key,
    this.exam,
    this.answer,
    this.finished = false,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text('${exam.number}. ${exam.title}(${exam.score}分)'),
        ),
        Column(
          children: exam.section
              .map(
                (item) => Material(
                  color: Theme.of(context).cardColor,
                  child: RadioListTile<String>(
                    value: item.choose,
                    title: Text(item.content),
                    groupValue: answer,
                    onChanged: finished ? null : onChanged,
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
