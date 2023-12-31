import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'main.dart';


// 로그인 페이지
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();

}

class LoginState extends State<Login>{
  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    // axios 요청

    return Scaffold(
      body: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin:  EdgeInsets.fromLTRB(0, 30, 0, 30),
                  child: Text("이름을 입력해주세요." ,
                      style: TextStyle( color: Colors.white, fontSize: 24)
                  )
              ), // 제목
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 42.0), // 좌우 여백 조절
                    child: TextField(
                      controller: _textController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Enter Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      // 텍스트 입력 상자에서 입력한 텍스트 가져오기
                      user = _textController.text;
                      user = user.trim();
                      if (RegExp(r'^\s*$').hasMatch(user)) {
                        // 문자열이 모두 공백일 때의 처리
                        print("문자열이 모두 공백입니다.");
                        return;
                      }
                      // 여기서 할 작업 수행
                      print(BASE_URL + 'user/create/$user');
                      // http로 uuid 받아오기
                      final response = await http.get(Uri.parse(BASE_URL + 'user/create/$user'));
                      print(response);
                      if (response.statusCode == 200) {
                        // 성공적으로 데이터를 받아온 경우
                        Map<String, dynamic> result = json.decode(response.body);
                        setState(() {
                          uuid = result.toString();
                        });
                      } else {
                        // 데이터를 받아오지 못한 경우
                        throw Exception('Failed to load data');
                      }
                      
                      print(uuid);

                      // Navigator를 이용하여 FirstPage로 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FirstPage()),
                      );

                    },
                    child: Text('등록'),
                  ),
                ],
              ),
            ],
          )
      ),
    );
  }
  @override
  void dispose() {
    // Dispose the controller when the widget is disposed
    _textController.dispose();
    super.dispose();
  }

}