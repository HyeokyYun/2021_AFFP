사용자가 첫번째 어플 사용자인지 아닌지 파악하는 변수 isFirstTime의 상태 변경 완료.<br>
FutureBuilder로 Firebase에서 데이터를 가져오는 동안 로딩 화면을 보여주고 가져오는 것을 완료하면 알맞는 상황을 반환한다.
```
if(isSign == true && isFirstTime == true){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            else {
              return Navigation();
            }
          }
          else if(isSign == true && isFirstTime == false){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            else {
              return welcomePage();
            }
          }
```
