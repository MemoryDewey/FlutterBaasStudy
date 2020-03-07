import 'package:baas_study/dao/exam_dao.dart';
import 'package:baas_study/model/exam_model.dart';
import 'package:baas_study/model/reponse_normal_model.dart';
import 'package:baas_study/widget/confirm_dialog.dart';
import 'package:baas_study/widget/course/course_exam_card.dart';
import 'package:baas_study/widget/custom_app_bar.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class ExamInfoPage extends StatefulWidget {
  final int courseId;

  const ExamInfoPage({Key key, @required this.courseId}) : super(key: key);

  @override
  _ExamInfoPageState createState() => _ExamInfoPageState();
}

class _ExamInfoPageState extends State<ExamInfoPage> {
  ExamInfoModel _examInfo;
  List<String> _answer = [];

  @override
  void initState() {
    super.initState();
    _getExamInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '课程考试',
        tailTitle: _examInfo?.finished?.state ?? false ? null : '提交',
        tailOnTap: _submitAnswer,
      ),
      body: ListView.builder(
        itemCount: _examInfo?.exam?.length ?? 0,
        itemBuilder: (context, index) => CourseExamCard(
          exam: _examInfo.exam[index],
          answer: _examInfo.finished.state
              ? _examInfo.finished.result[index].choose
              : _answer[index],
          finished: _examInfo.finished.state,
          onChanged: (value) {
            setState(() {
              _answer[index] = value;
            });
          },
        ),
      ),
    );
  }

  Future<Null> _getExamInfo() async {
    try {
      ExamInfoModel model = await ExamDao.getExamResult(widget.courseId);
      setState(() {
        _examInfo = model;
        if (!model.finished.state)
          _answer = List<String>.generate(model.exam.length, (index) => '');
      });
    } catch (e) {
      print(e);
    }
  }

  Future<Null> _submitAnswer() async{
    try {
      showDialog<void>(
        context: context,
        builder: (dialogContext) => ConfirmDialog(
          title: '提交试卷',
          content: Text('试卷提交后不可更改，确认提交吗？'),
          confirmPress: () async {
            ResponseNormalModel model =
                await ExamDao.submitAnswer(SubmitExamModel(
              answer: _answer,
              id: widget.courseId,
              exam: SubmitExamInfoModel(type: 'exam', id: widget.courseId),
            ));
            if (model != null) {
              BotToast.showText(text: model.msg);
              Navigator.pop(context, true);
            }
          },
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}
