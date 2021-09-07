import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Notice extends StatefulWidget {
  //const Notice({Key key}) : super(key: key);

  @override
  _NoticeState createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _buildListView(context),

      ),
      appBar: AppBar(

        title: Text(
          '알림',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: (){Get.back();},
        ),
        actions: [
          Text('전체 읽음',style: TextStyle( color: Color(0xff7EA68D)),)
        ],

        backgroundColor: Colors.white,
      ),);
  }
}

Widget _buildListView(BuildContext context) {
  return ListView.builder(
    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
    itemCount: 9,
    itemBuilder: (BuildContext context, int index) {
      final List<String> _title = [
        '댓글 알림',
        '공지 사항',
        '댓글 알림',
        '게시글 알림',
        '게시글 알림',
        '게시글 알림',
        '댓글 알림',
        '댓글 알림',
        '댓글 알림'
      ];

      final List<String> _description = [
        '디스이즈러브님이 작성자님의 댓글을 유용해합니다 ',
        '앱 0.5.0 버전이 0.7.1 버전으로 업그레이드 되었습니다 ',
        '우엙님이 작성자님의 댓글을 유용해합니다 ',
        '고마워님이 작성자님의 게시글을 유용해합니다',
        '고마워님이 댓글을 남겼습니다 : 감사해요!!!!!',
        '고마워님이 댓글을 남겼습니다 : 정말요?????',
        '디스이즈러브님이 작성자님의 댓글을 유용해합니다 ',
        '비더러브님이 작성자님의 댓글을 유용해합니다 ',
        '고린도전서님이 작성자님의 댓글을 유용해합니다 '
      ];

      final List<String> _date = [
        '오늘',
        '어제',
        '오늘',
        '오늘',
        '오늘',
        '오늘',
        '08/22 00:00',
        '08/14 00:00',
        '08/15 00:00'
      ];
      return Container(


        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ListTile(

              leading: AnimatedContainer(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(30),
                ),
                duration: Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
                child: Icon((() {
                  if (_title[index] == '댓글 알림') {
                    return Icons.message;
                  }
                  else if (_title[index] == '게시글 알림') {
                    return Icons.assignment;
                  } else {
                    return Icons.add_alert;
                  }
                })()),

              ),

              title: Text(
                _title[index],
                // style: body2Style(),
              ),
              subtitle: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _description[index],
                      ),
                      Text(_date[index], style: TextStyle(fontSize: 12.0),)
                    ],
                  )),
              onTap: () async {
                // await Get.to(() => AskBoardDetail(
                //     title: _title[index],
                //     description: _description[index],
                //     date: _date[index]));
              },
              // trailing: Text(_date[index]),
              //isThreeLine: true,
            ),
            // SizedBox(height: 10.0),
            Divider(
              color: Colors.grey[20],
              // thickness: 1.0,
            ),
          ],
        ),
      );
    },
  );
}