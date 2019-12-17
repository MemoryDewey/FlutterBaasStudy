import 'package:baas_study/dao/feedback_dao.dart';
import 'package:baas_study/model/feedback_mode;.dart';
import 'package:baas_study/model/reponse_normal_model.dart';
import 'package:baas_study/widget/custom_app_bar.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  List<FeedbackTypeModel> _feedbackType = [];
  TextEditingController _controller = TextEditingController();
  int _feedbackTypeId;

  @override
  void initState() {
    super.initState();
    _getFeedbackType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '用户反馈'),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: _title('选择反馈类型'),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => Container(
                      color: Theme.of(context).cardColor,
                      child: RadioListTile<int>(
                          title: Text(_feedbackType[index].name),
                          value: _feedbackType[index].id,
                          groupValue: _feedbackTypeId,
                          onChanged: (value) {
                            setState(() {
                              _feedbackTypeId = value;
                            });
                          }),
                    ),
                childCount: _feedbackType.length),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(bottom: 20),
              margin: EdgeInsets.symmetric(vertical: 20),
              color: Theme.of(context).cardColor,
              child: Column(
                children: <Widget>[
                  _title('补充详情'),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: TextField(
                      controller: _controller,
                      maxLines: 4,
                      maxLength: 150,
                      maxLengthEnforced: true,
                      textInputAction: TextInputAction.done,
                      onEditingComplete: _sendFeedback,
                      decoration: InputDecoration(
                        hintText: '请写下您的意见或建议（15字 ~ 150字）',
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              width: double.infinity,
              child: FlatButton(
                onPressed: _sendFeedback,
                child: Text('提交'),
                splashColor: Colors.lightBlue,
                color: Colors.lightBlue,
                textColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _title(String title) => Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
        width: double.infinity,
        color: Theme.of(context).cardColor,
        child: RichText(
          text: TextSpan(
            text: title,
            style: TextStyle(
              color: IconTheme.of(context).color,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(text: '  *', style: TextStyle(color: Colors.red))
            ],
          ),
        ),
      );

  String _validateFeedback() {
    if (_feedbackTypeId == null) return '请选择反馈类型';
    if (_controller.text.length < 15 || _controller.text.length > 150)
      return '补充详情字数在15字到150字之间';
    return null;
  }

  Future<Null> _getFeedbackType() async {
    try {
      List<FeedbackTypeModel> type = await FeedbackDao.getFeedbackType();
      setState(() {
        _feedbackType = type;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<Null> _sendFeedback() async {
    try {
      String validateStr = _validateFeedback();
      if (validateStr == null) {
        ResponseNormalModel res = await FeedbackDao.sendFeedback(
          content: _controller.text,
          type: _feedbackTypeId,
        );
        BotToast.showText(text: res.msg);
        FocusScope.of(context).requestFocus(FocusNode());
        Navigator.pop(context);
      } else
        BotToast.showText(text: validateStr);
    } catch (e) {
      print(e);
      BotToast.showText(text: '提交错误！');
    }
  }
}
