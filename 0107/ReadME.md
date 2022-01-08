ios연동 성공!
<br>
root파일 수정 ->     FirebaseAuth.instance.authStateChanges().listen((event) => updateUserState(event));
<br>
Podfile에 디플로이먼트 타겟 설정 코드 추가(마지막부분)
<br>
