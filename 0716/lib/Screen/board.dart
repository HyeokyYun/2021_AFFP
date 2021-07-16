import 'package:des_dev_camp2021/Theme/colors.dart';
import 'package:des_dev_camp2021/Theme/text_styles.dart';
import 'package:des_dev_camp2021/Widget/appBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'qna.dart';


class QuestionBoardPage extends StatefulWidget {

  _QuestionBoardPageState createState() => _QuestionBoardPageState();
}

class _QuestionBoardPageState extends State<QuestionBoardPage> {

  final List<String> title = [
    '교통카드 충전하는 법 좀 알려주세요 ?',
    '지하철 어떻게 타야해요 ?',
    '이게 뭐에요 ?',
    '어른들 제가 궁금한게 있는대요 ..'
  ];

  final List<String> description = [
    '캐시피 교통카드인데 충전이 안돼요 ㅜ',
    '잠실로 가려면 여기서 어떻게 가야해요 ?',
    '이거 사용법을 모르겠어요 ',
    '저는 한동 초등학교 5학년이에요 인생은 어떻게 살아가는 거에요?'
  ];
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffe5ddca),
          elevation: 0.0,
          title: Text(
            '사용자 정보',
            style: TextStyle(color: Colors.black,
                letterSpacing: 2.0
            ),
          ),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
            child: Container(

              child: _buildListView(context),
            )));
  }

  ListView _buildListView(BuildContext context){
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
            child: Column(
              children: [
                SizedBox(height: 8.0,)
                ,
                ListTile(
                  leading: Container(
                    width: MediaQuery.of(context).size.width/4,
                    height: 200,
                    child: Image(image: NetworkImage("https://i.imgur.com/rKFhfY5.jpg"),
                      width: 500,height: 200,
                    ),



                  ),
                  title: Text(title[index],style: body2Style(),),
                  subtitle: Text(description[index],style:body3Style()),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BoardDetailPage(title: title[index],description: description[index]),
                      ),
                    );
                  },
                ),
                Divider(
                  color: thirdColor[100],
                  thickness: 1.0,


                ),
              ],
            )

        );
      },
    );

  }

}