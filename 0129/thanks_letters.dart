import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cap_after_ds/theme/colors.dart';

import '../../home/agora/pages/call_helper.dart';
import 'package:cap_after_ds/screens/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class ThankyouLetters extends StatefulWidget {
  const ThankyouLetters({Key? key}) : super(key: key);

  @override
  _ThankyouLettersState createState() => _ThankyouLettersState();
}

class _ThankyouLettersState extends State<ThankyouLetters> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? currentUser;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    List<dynamic>? thankList;
    List<dynamic>? letterFrom;

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser!.uid)
          .collection('thankLetter')
          .doc(firebaseUser!.uid)
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        }

        // if (snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;
        thankList = data['thankLetter'];
        letterFrom = data['letter_from'];

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              "받은 편지함",
              style: TextStyle(color: Colors.black),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Get.back(),
              color: Colors.black,
            ),
            elevation: 0.0,
            backgroundColor: Colors.white,
            centerTitle: true,
          ),
          body: thankList!.length == null
              ? const Text("도움을 주고 감사편지를 받으세요!")
              : ListView.builder(
                  itemCount: thankList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      shape:  RoundedRectangleBorder(
                          borderRadius:  BorderRadius.circular(10.0)),
                      elevation: 5.0,
                      shadowColor: AppColors.grey[50],
                      color: const Color(0xffF1F3F5),
                      child: Container(
                        height: 100.h,
                        padding: EdgeInsets.fromLTRB(10, 15.h, 10, 15.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 50.h,
                              width: 70.w,
                              child: SvgPicture.asset(
                                "assets/liveQ_logo.svg",
                                color: AppColors.primaryColor,
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            SizedBox(
                              height: 70.h,
                              width: 220.w,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      letterFrom![index]
                                    ),
                                    Text(
                                      thankList![index],
                                      style: TextStyle(
                                          color: AppColors.primaryColor[900],
                                          fontSize: 14.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Container(
                            //   width: 100.w,
                            // ),
                          ],
                        ),
                        // child: Padding(
                        //   padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        //   child: Container(
                        //     height: 50.h,
                        //     width: 350.w,
                        //     child: Container(
                        //       // width: 210.w,
                        //       child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.start,
                        //         crossAxisAlignment: CrossAxisAlignment.center,
                        //         children: [
                        //           SvgPicture.asset(
                        //             "assets/liveQ_logo.svg",
                        //             color: AppColors.primaryColor,
                        //           ),
                        //           // SizedBox(
                        //           //   width: 20.w,
                        //           // ),
                        //           Container(
                        //             width: 150.w,
                        //             child:
                        // Text(
                        //               thankList![index],
                        //               style: TextStyle(
                        //                   color: AppColors.primaryColor[900],
                        //                   fontSize: 14.sp),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ),
                    );
                  }),
        );
      },
    );
  }
}
