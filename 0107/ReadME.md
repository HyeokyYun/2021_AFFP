ios연동 성공!
<br>
root파일 수정 ->     FirebaseAuth.instance.authStateChanges().listen((event) => updateUserState(event));
<br>
Podfile에 디플로이먼트 타겟 설정 코드 추가
<br>
post_install do |installer|<br>
  installer.pods_project.targets.each do |target|<br>
  flutter_additional_ios_build_settings(target)<br>
    target.build_configurations.each do |config|<br>
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'<br>
      config.build_settings['ENABLE_BITCODE'] = 'NO'<br>
    end<br>
  end<br>
end<br>
<br>
위 내용 추가해야 target관련 문제 안생김.
