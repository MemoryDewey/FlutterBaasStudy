import 'package:baas_study/dao/comment_dao.dart';
import 'package:baas_study/model/comment_model.dart';
import 'package:baas_study/widget/custom_app_bar.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CourseCommentPage extends StatefulWidget {
  final int courseID;

  const CourseCommentPage({Key key, @required this.courseID}) : super(key: key);

  @override
  _CourseCommentPageState createState() => _CourseCommentPageState();
}

class _CourseCommentPageState extends State<CourseCommentPage> {
  double _rating = 5.0;
  TextEditingController _controller = TextEditingController();
  bool _textCanSubmit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '提交评论'),
      backgroundColor: Theme.of(context).cardColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20),
          RatingBar(
            initialRating: _rating,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 5),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                _rating = rating;
              });
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              _generateRatingText(),
              style: TextStyle(
                fontSize: 18,
                color: _rating > 3 ? Colors.amber : Colors.red,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _controller,
              maxLines: 8,
              maxLength: 1000,
              maxLengthEnforced: true,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                hintText: '课程怎么样，快来说说学习感受吧',
                helperText: '评论不可少于15字',
                contentPadding: EdgeInsets.all(16),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _textCanSubmit = value.length >= 15 && value.length <= 1000;
                });
              },
            ),
          )
        ],
      ),
      bottomSheet: SizedBox(
        width: double.infinity,
        child: CupertinoButton(
          child: Text('提交'),
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(0),
          onPressed: _textCanSubmit ? _addComment : null,
        ),
      ),
    );
  }

  String _generateRatingText() {
    if (_rating == 1.0) return '非常不满意';
    if (_rating == 2.0) return '不满意';
    if (_rating == 3.0) return '一般';
    if (_rating == 4.0) return '满意';
    if (_rating == 5.0) return '非常满意';
    return '错误';
  }

  Future<Null> _addComment() async {
    try {
      CommentAddModel res = await CommentDao.addComment(
        courseID: widget.courseID,
        star: _rating,
        comment: _controller.text,
      );
      BotToast.showText(text: res.msg);
      Navigator.pop(context, true);
    } catch (e) {
      print(e);
    }
  }
}
