import 'package:des_dev_camp2021/Theme/text_styles.dart';
import 'package:des_dev_camp2021/Widget/appBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home.dart';
import 'nav.dart';

class ExtraInfoPage extends StatefulWidget {
  @override
  _ExtraInfoPage createState() => _ExtraInfoPage();
}

class _ExtraInfoPage extends State<ExtraInfoPage> {
  List<String> chipList = [
    "0-10세", "11-20세", "21-30세", "31-40세", "41-50세", "51-60세", "61-70세"
  ];
  List<String> langList = [
    "영어", "한국어", "중국어"
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: customAppBar(
          title: '회원정보'
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '사용자 나이',
                style: body2Style(),
              ),
              Wrap(
                //spacing: 5.0,
                //runSpacing: 5.0,
                children: <Widget>[
                  choiceChipWidget(chipList),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Text(
                    '사용 언어',
                    style: body2Style(),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '최대 3개',
                    style: body3Style(),
                  ),
                ],
              ),
              FilterChipDisplay(),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: ElevatedButton(
                    onPressed: (){
                      Get.offAllNamed('/nav');
                    },
                    child: Text("입력완료"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class choiceChipWidget extends StatefulWidget {
  final List<String> reportList;

  choiceChipWidget(this.reportList);

  @override
  _choiceChipWidgetState createState() => new _choiceChipWidgetState();
}

class _choiceChipWidgetState extends State<choiceChipWidget> {
  String selectedChoice = "";


  _buildChoiceList() {

    List<Widget> choices =[];
    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
        child: ChoiceChip(
          label: Text(item),
          labelStyle: TextStyle(
              color: Colors.green, fontSize: 14.0, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          side: BorderSide(
              color: Colors.green
          ),
          backgroundColor: Colors.white,
          selectedColor: Colors.green[100],
          selected: selectedChoice == item,
          onSelected: (selected) {
            setState(() {
              selectedChoice = item;
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}

class FilterChipDisplay extends StatefulWidget {
  @override
  _FilterChipDisplayState createState() => _FilterChipDisplayState();
}

class _FilterChipDisplayState extends State<FilterChipDisplay> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left:8.0),
          child: Align
            (
            alignment: Alignment.centerLeft,
            child: Container(
                child: Wrap(
                  spacing: 5.0,
                  runSpacing: 3.0,
                  children: <Widget>[
                    filterChipWidget(chipName: '한국어'),
                    filterChipWidget(chipName: '영어'),
                    filterChipWidget(chipName: '중국어'),
                    filterChipWidget(chipName: '프랑스어'),
                    filterChipWidget(chipName: '스페인어'),
                    filterChipWidget(chipName: '일본어'),
                  ],
                )
            ),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Text(
          '관심 분야',
          style: body2Style(),
        ),
        Padding(
          padding: const EdgeInsets.only(left:8.0),
          child: Align
            (
            alignment: Alignment.centerLeft,
            child: Container(
              child: Wrap(
                spacing: 5.0,
                runSpacing: 5.0,
                children: <Widget>[
                  filterChipWidget(chipName: '메이크업'),
                  filterChipWidget(chipName: '고등학교'),
                  filterChipWidget(chipName: '커피'),
                  filterChipWidget(chipName: '운동'),
                  filterChipWidget(chipName: '피아노'),
                  filterChipWidget(chipName: '교육'),
                  filterChipWidget(chipName: '컴퓨터'),
                  filterChipWidget(chipName: '동물'),
                  filterChipWidget(chipName: '상담심리'),
                  filterChipWidget(chipName: '디자인'),
                  filterChipWidget(chipName: '자동차'),
                  filterChipWidget(chipName: '의료'),
                  filterChipWidget(chipName: '음악'),
                  filterChipWidget(chipName: '연예인'),
                  filterChipWidget(chipName: '플러터'),
                  filterChipWidget(chipName: '사진'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class filterChipWidget extends StatefulWidget {
  final String chipName;

  filterChipWidget({Key? key, required this.chipName}) : super(key: key);

  @override
  _filterChipWidgetState createState() => _filterChipWidgetState();
}

class _filterChipWidgetState extends State<filterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      labelStyle: TextStyle(color: Colors.green,fontSize: 16.0,fontWeight: FontWeight.bold),
      selected: _isSelected,
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            30.0),),
      backgroundColor: Color(0xffededed),
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
        });
      },
      selectedColor: Colors.green[100],);
  }
}


