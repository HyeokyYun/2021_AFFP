파이어베이스에서 유저 수 카운트 시도... <br>
home.dart 수정 <br>
₩₩₩
List<String> tokens = [];
  Future<int> countUsers() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').get();
    for (var element in querySnapshot.docs) {
      tokens.add((element.data() as dynamic)["uid"]);
    }
    return tokens.length;
  }
  intCount() async {
    int count = await countUsers();
    return count;
  }
₩₩₩
