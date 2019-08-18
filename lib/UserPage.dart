import 'package:smartcycle/UserPage.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("사용자 설정"),
      ),
      body: UserSetting(),
    );
  }
}

class UserSetting extends StatefulWidget {
  @override
  _UserSettingState createState() => _UserSettingState();
}

class _UserSettingState extends State<UserSetting> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("이곳은 사용자 설정 페이지, 사용자 환경 설정 등.."),
    );
  }
}