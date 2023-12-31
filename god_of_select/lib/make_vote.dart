// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'main.dart';
import 'object.dart';


// 투표 작성 페이지
class MakeVote extends StatefulWidget {
  const MakeVote({Key? key}) : super(key: key);

  @override
  MakeVoteState createState() => MakeVoteState();
}

class MakeVoteState extends State<MakeVote>{

  String body = """{
      'userID': user,
      'title': 'text',
      'content1': content,
      'content2': content,
    }""";

  // 변수 선언
  TextEditingController titleController = TextEditingController();
  TextEditingController content1Controller = TextEditingController();
  TextEditingController content2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 42.0),
                child: TextField(
                  controller: titleController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: '제목 입력',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ), // 제목
            Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 42.0),
                    child: TextField(
                      controller: content1Controller,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: '대답1 입력',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),// 첫번째 선택창
                Container(
                  margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Text(
                    'VS',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ), // vs
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 42.0),
                    child: TextField(
                      controller: content2Controller,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: '대답2 입력',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ), // 두번째 선택창
                ElevatedButton(
                  onPressed: () async {
                    // 텍스트 입력 상자에서 입력한 텍스트 가져오기
                    String title = titleController.text;
                    String content1 = content1Controller.text;
                    String content2 = content2Controller.text;

                    // 예외처리
                    if (RegExp(r'^\s*$').hasMatch(title)) {
                      // 문자열이 모두 공백일 때의 처리
                      print("title 공백입니다.");
                      return;
                    } else if (RegExp(r'^\s*$').hasMatch(content1)) {
                      // 문자열이 모두 공백일 때의 처리
                      print("content1 공백입니다.");
                      return;
                    } else if (RegExp(r'^\s*$').hasMatch(content2)) {
                      // 문자열이 모두 공백일 때의 처리
                      print("content2 공백입니다.");
                      return;
                    }

                    print('데이터 입력 : $title $content1 $content2');

                    // http post 요청 투표 등록하기
                    final Map<String, dynamic> data = {
                      'user_id': uuid,
                      'title': title,
                      'content_1': content1,
                      'content_2': content2
                    };

                    final response = await http.post(
                      Uri.parse('http://127.0.0.1:8080/issue/create'),
                      headers: <String, String>{
                        'Content-Type': 'application/json',
                      },
                      body: json.encode(data),
                    );

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
        ),
      ),
    );
  }
}