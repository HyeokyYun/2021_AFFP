import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:cap_after_ds/screens/home/buttons/animated_radial_menu.dart';
import 'package:cap_after_ds/screens/navigation_bar.dart';
import 'package:cap_after_ds/theme/colors.dart';
import 'package:cap_after_ds/theme/text_style.dart';

class ThankYouPage extends StatefulWidget {
  const ThankYouPage({Key? key}) : super(key: key);

  @override
  _ThankYouPageState createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ThankYouPage> {
  bool ifthanksLetter = false;
  bool ifGoBack = false;
  final TextEditingController _thankController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  User? get userProfile => auth.currentUser;
  User? currentUser;

  var firebaseUser = FirebaseAuth.instance.currentUser;

  Widget ifGetHelp(BuildContext context) {
    return Center(
      child: Container(
        width: 341.w,
        height: 250.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(33),
          color: AppColors.grey[50],
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "답변자와의 통화가 ",
                  style: AppTextStyle.koBody2.copyWith(
                    color: AppColors.grey[900],
                  ),
                ),
                Text(
                  "종료",
                  style: AppTextStyle.koBody2.copyWith(
                    color: Color(0xffFF1E1E),
                  ),
                ),
                Text(
                  "되었습니다",
                  style: AppTextStyle.koBody2.copyWith(
                    color: AppColors.grey[900],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 13.h,
            ),
            Text(
              "도움이 되셨나요?",
              style: AppTextStyle.koHeadline5,
            ),
            SizedBox(
              height: 22.h,
            ),
            SizedBox(
              width: 287.w,
              height: 43.h,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    ifthanksLetter = true;
                  });
                },
                child: Text(
                  "네! 궁금증이 완전히 해결되었어요",
                  style: AppTextStyle.koBody2.copyWith(color: AppColors.grey),
                ),
                style: ElevatedButton.styleFrom(
                  // padding: padding,
                  primary: AppColors.primaryColor[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            SizedBox(
              width: 287.w,
              height: 43.h,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    ifGoBack = true;
                  });
                },
                child: Text(
                  "아직 도움이 필요해요",
                  style: AppTextStyle.koBody2.copyWith(color: AppColors.grey),
                ),
                style: ElevatedButton.styleFrom(
                  // padding: padding,
                  primary: AppColors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: 20.h,
            // )
          ],
        ),
      ),
    );
  }

  Widget thanksLetter(BuildContext context) {
    return Center(
      child: Container(
        width: 341.w,
        height: 337.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(33),
          color: AppColors.grey[50],
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.outbox_sharp),
                Text(
                  " 답변자분께 ",
                  style: AppTextStyle.koBody1.copyWith(
                    color: AppColors.grey[900],
                  ),
                ),
                Text(
                  "감사",
                  style: AppTextStyle.koBody1.copyWith(
                    color: AppColors.primaryColor[900],
                  ),
                ),
                Text(
                  "의 마음을 전해보세요",
                  style: AppTextStyle.koBody1.copyWith(
                    color: AppColors.grey[900],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 21.h,
            ),
            Container(
              height: 150.h,
              width: 290.w,
              padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 10.h),
              decoration: BoxDecoration(
                color: AppColors.primaryColor[50],
                borderRadius: BorderRadius.circular(22),
              ),
              child: TextFormField(
                controller: _thankController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                // obscureText: obsecureText!,
                decoration: InputDecoration(
                  hintText: "시간내서 답변해주셔서 너무 감사드립니다!",
                  hintStyle: AppTextStyle.koBody2,
                  fillColor: AppColors.primaryColor[50],
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
                // validator: validator,
              ),
            ),
            SizedBox(
              height: 21.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 133.w,
                  height: 59.h,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        FirebaseFirestore.instance
                            .collection('videoCall')
                            .doc(firebaseUser!.uid)
                            .delete();
                        Get.offAll(Navigation());
                      });
                      //그냥 메인 페이지로 넘어갈 수 있게 하기
                    },
                    child: Text(
                      "넘어가기",
                      style:
                          AppTextStyle.koBody2.copyWith(color: AppColors.grey),
                    ),
                    style: ElevatedButton.styleFrom(
                      // padding: padding,
                      primary: AppColors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(33),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 22.h,
                ),
                SizedBox(
                  width: 133.w,
                  height: 59.h,
                  child: ElevatedButton(
                    onPressed: () {
                      String? helperUid;
                      FirebaseFirestore.instance
                          .collection('videoCall')
                          .doc(firebaseUser!.uid)
                          .get()
                          .then((DocumentSnapshot documentSnapshot) {
                        helperUid = documentSnapshot.get('helper');
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(firebaseUser!.uid)
                            .update({'ask': FieldValue.increment(1)});
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(helperUid)
                            .collection('thankLetter')
                            .doc(helperUid)
                            .update({
                          'letter_from':
                            FieldValue.arrayUnion([userProfile!.displayName]),
                          'thankLetter':
                              FieldValue.arrayUnion([_thankController.text])
                        }).then((value) {
                          FirebaseFirestore.instance
                              .collection('videoCall')
                              .doc(firebaseUser!.uid)
                              .delete();
                          Get.find<ButtonController>().changetrue();
                          Get.offAll(Navigation());
                        });
                      });
                      setState(() {
                        ifGoBack = true;
                      });
                    },
                    child: Text(
                      "감사카드 보내기",
                      style:
                          AppTextStyle.koBody2.copyWith(color: AppColors.grey),
                    ),
                    style: ElevatedButton.styleFrom(
                      // padding: padding,
                      primary: AppColors.primaryColor[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(33),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget lastDialog(BuildContext context) {
    return Center(
      child: Container(
        width: 341.w,
        height: 226.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(33),
          color: AppColors.grey[50],
        ),
        child: Column(
          children: [
            SizedBox(
              height: 40.h,
            ),
            SvgPicture.asset(
              "assets/thank_check.svg",
              color: AppColors.primaryColor,
              height: 29.h,
            ),
            SizedBox(
              height: 28.h,
            ),
            Text(
              ifthanksLetter ? "성공적으로 메세지를 보냈습니다." : "다른 사람에게 도움을 요청하세요!",
              style: AppTextStyle.koBody1.copyWith(
                color: AppColors.grey[900],
              ),
            ),
            SizedBox(
              height: 43.h,
            ),
            ElevatedButton(
              onPressed: () {
                Get.find<ButtonController>().changetrue();
                FirebaseFirestore.instance
                    .collection('videoCall')
                    .doc(firebaseUser!.uid)
                    .delete();
                Get.offAll(Navigation());
              },
              child: Text(
                "확인",
                style: AppTextStyle.koBody1.copyWith(
                  color: AppColors.grey[50],
                ),
              ),
              style: ElevatedButton.styleFrom(
                // padding: padding,
                primary: AppColors.primaryColor[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(33),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget underToolBar(BuildContext context) {
    return Container(
      color: AppColors.grey,
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: () {},
            child: Icon(
              Icons.videocam_off,
              color: Colors.white,
              size: 35.0,
            ),
            shape: const CircleBorder(),
            elevation: 4.0,
            fillColor: Colors.blueAccent,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () {},
            child: const Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: const CircleBorder(),
            elevation: 4.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: () {},
            child: Icon(
              Icons.mic_off,
              color: Colors.white,
              size: 35.0,
            ),
            shape: const CircleBorder(),
            elevation: 4.0,
            fillColor: Colors.blueAccent,
            padding: const EdgeInsets.all(12.0),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: MaterialButton(
              minWidth: 0,
              onPressed: () async {},
              child: const Icon(
                Icons.favorite,
                color: Color(0xffe82b50),
                size: 35.0,
              ),
              padding: const EdgeInsets.all(12.0),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          underToolBar(context),
          Container(
            color: Colors.black.withOpacity(0.55),
          ),
          ifthanksLetter
              ? ifGoBack
                  ? lastDialog(context)
                  : thanksLetter(context)
              : ifGoBack
                  ? lastDialog(context)
                  : ifGetHelp(context),
          // Image.asset("assets/LiveQ_logo.gif")
        ],
      ),
    );
  }
}
