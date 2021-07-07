import 'package:brandnew_getx_crud_practice/page2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';
import 'model/list.dart';

void main() => runApp(GetMaterialApp(home: Home()));

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Controller c = Get.put(Controller());

    TextEditingController titleEdit = TextEditingController();
    TextEditingController authorEdit = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("together"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: Text("Go to Page2"),
              onPressed: () => Get.to(() => Page2()),
            ),
            Obx(()=>ListView.separated(
              shrinkWrap: true,
                itemBuilder: (context, index) => ListTile(
                  trailing: IconButton(
                    icon: Icon(Icons.edit), onPressed: () {},
                  ),
                    title: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Title: ${c.books[index].title}"),
                            Text("Author: ${c.books[index].author}"),
                          ],
                        ),
                      ],
                    ),
                ),
                separatorBuilder: (_, __) => Divider(
                  thickness: 2.0,
                ),
                itemCount: c.books.length
            )
            )
            // GetBuilder<Controller>( // Get.back()의 경우에만 GetBuilder<> 사용해야함. 나머지는 Obx()
            //   init: Controller(),
            //   builder: (_) => Text('${c.book.value.title} ${c.book.value.author}',
            //     style: TextStyle(color: Colors.lightBlue, fontWeight: FontWeight.bold, fontSize: 20),
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.defaultDialog(
            title: 'data create',
            content: Column(
              children: [
                TextField(
                  controller: titleEdit, // 입력 데이터를 받아오는 역
                  decoration: InputDecoration(
                    hintText: 'Title...',
                  ),
                ),
                TextField(
                  controller: authorEdit, // 입력 데이터를 받아오는 역
                  decoration: InputDecoration(
                    hintText: 'Author...',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  c.books.add(
                      Book(
                        title: titleEdit.text,
                        author: authorEdit.text
                  ));
                  //c.createText();
                  print("${c.books[0].title}");
                  //print("${c.books.value.author}");
                  Get.back();
                },
                child: Text('submit'),
              ),
            ],
          );
        },
      ),
    );
  }
}

//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyTabHomePage(),
//     );
//   }
// }
//
// class FakeDB {
//   List<int> viewedPages = [0];
//
//   void insertViewedPage(int page) {
//     viewedPages.add(page);
//   }
// }
//
// /// BottomNavigationBar page converted to GetX. Original StatefulWidget version:
// /// https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html
// class TabX extends GetxController {
//
//    TabX({required this.db});
//
//   final FakeDB db;
//   int selectedIndex = 0;
//   static const TextStyle optionStyle =
//   TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
//   late List<Widget> tabPages;
//
//   @override
//   void onInit() {
//     super.onInit();
//     tabPages = <Widget>[
//       ListViewTab(db),
//       Text(
//         'Index 1: Business',
//         style: optionStyle,
//       ),
//       Text(
//         'Index 2: School',
//         style: optionStyle,
//       ),
//     ];
//   }
//
//   /// INTERESTING PART HERE ↓ ************************************
//   void onItemTapped(int index) {
//     selectedIndex = index;
//     db.insertViewedPage(index); // simulate database update while tabs change
//     update(); // ← rebuilds any GetBuilder<TabX> widget
//     // ↑ update() is like setState() to anything inside a GetBuilder using *this*
//     // controller, i.e. GetBuilder<TabX>
//     // Other GetX controllers are not affected. e.g. GetBuilder<BlahX>, not affected
//     // by this update()
//   }
// }
//
// /// REBUILT when Tab Page changes, rebuilt by GetBuilder in MyTabHomePage
// class ListViewTab extends StatelessWidget {
//   final FakeDB db;
//
//   ListViewTab(this.db);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: db.viewedPages.length,
//       itemBuilder: (context, index) =>
//           ListTile(
//             title: Text('Page Viewed: ${db.viewedPages[index]}'),
//           ),
//     );
//   }
// }
//
//
// class MyTabHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Get.put(TabX(db: FakeDB()));
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('BottomNavigationBar Sample'),
//       ),
//       body: Center(
//         /// ↓ Tab Page currently visible - rebuilt by GetBuilder when
//         /// ↓ TabX.onItemTapped() called
//         child: GetBuilder<TabX>(
//             builder: (tx) => tx.tabPages.elementAt(tx.selectedIndex)
//         ),
//       ),
//       /// ↓ BottomNavBar's highlighted/active item, rebuilt by GetBuilder when
//       /// ↓ TabX.onItemTapped() called
//       bottomNavigationBar: GetBuilder<TabX>(
//         builder: (tx) => BottomNavigationBar(
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.business),
//               label: 'Business',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.school),
//               label: 'School',
//             ),
//           ],
//           currentIndex: tx.selectedIndex,
//           selectedItemColor: Colors.amber[800],
//           onTap: tx.onItemTapped,
//         ),
//       ),
//     );
//   }
// }
