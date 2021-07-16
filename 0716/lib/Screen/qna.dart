import 'package:des_dev_camp2021/Theme/colors.dart';
import 'package:des_dev_camp2021/Theme/text_styles.dart';
import 'package:des_dev_camp2021/Widget/appBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'board.dart';

class BoardDetailPage extends StatelessWidget {
  late final String title;
  late final String description;

  BoardDetailPage({Key? key, required this.title,required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: customAppBar(
          title: '게시글',
        ),
        body: Container(
          color: thirdColor,
          child: Column(children: [
            Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              decoration: BoxDecoration(
                color: onSurface[50],
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    offset: Offset(-1.0, 4.0),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                //    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 40.0,
                          width: 10,
                        ),
                        Icon(Icons.account_circle,size: 30.0),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(title, style: body2Style(color: onSurface[900])),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    new Container(
                      width: 900,
                      height: 240,
                      child: Image(image: NetworkImage("https://i.imgur.com/rKFhfY5.jpg"),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(description, style: body3Style(color: onSurface[900]),
                      textAlign: TextAlign.left,),
                    ),
                    SizedBox(height: 20.0,),

//사진 넣기
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Text(
                                ' 답변 ',
                                style: body3Style(color: primary[900],),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(width: 235.0,),
                              Icon(Icons.message),
                              SizedBox(width: 12.0,),
                              Icon(Icons.add_ic_call_outlined),

                            ],

                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Divider(
                          color: thirdColor[100],
                          thickness: 1.0,
                          indent: 15,
                          endIndent: 15,

                        ),
                        //여기서 부터 반복



                        Row(
                          //  mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width:10.0 ,),
                            Text(
                              ' 저기 1회용 카드라서 환급대에 가서 500원을 \n 받으세요',
                              style: body3Style(color: onSurface[900]),
                            ),

                            // Icon(Icons.thumb_up_sharp,color: secondary[500],
                            // size: 18,),
                            // SizedBox(width: 10.0,),
                            // Icon(Icons.thumb_down_sharp,color: secondary[500],
                            // size: 18,),

                          ],

                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Divider(
                          color: thirdColor[100],
                          thickness: 1.0,
                          indent: 15,
                          endIndent: 15,

                        ),

                        // 복붇




                        Row(
                          //  mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width:15.0 ,),
                            Icon(Icons.subdirectory_arrow_right,color: onSurface[300]),
                            SizedBox(width:5.0 ,),
                            Text(
                              ' 엥 저게 1회용 카드에요 ?',
                              style: body3Style(color: onSurface[900]),
                            ),



                          ],

                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Divider(
                          color: thirdColor[100],
                          thickness: 1.0,
                          indent: 15,
                          endIndent: 15,

                        ),
                      ],
                    ),

                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
// ListTile(
//   leading: Text("front!"),
//   trailing: Text("back!"),
// ),

                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                  ]),
            ),
          ]),
        ));
  }
}