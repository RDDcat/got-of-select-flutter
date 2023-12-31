import 'package:flutter/material.dart';
import 'package:god_of_select/vote.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'login.dart';
import 'make_vote.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
    );
  }
}

// 전역 변수 선언
String user = "";
String uuid = "";
String BASE_URL= "http://3.143.68.242:8080/";

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  // http get 요청 투표 데이터 받아오기
  String data = '';

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));

    if (response.statusCode == 200) {
      // 성공적으로 데이터를 받아온 경우
      Map<String, dynamic> result = json.decode(response.body);
      setState(() {
        data = result.toString();
      });
    } else {
      // 데이터를 받아오지 못한 경우
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('$user $uuid'),
          ),
          body: Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // 상단
                  Container(
                      alignment: Alignment.centerLeft,
                      width: 300,
                      height: 30,
                      child:
                      Row(
                        children: [
                          Icon(
                              Icons.local_fire_department,
                              color: Colors.black26
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Text('HOT', style: TextStyle(

                            ),),
                          )
                        ],
                      )
                  ),
                  // 질문 컴포넌트
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Q. 이 어플은 쓸만한가요?'), // 질문
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.fromLTRB(15, 15, 15, 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blueAccent,
                            ),
                            width: 250,
                            height: 30,
                            child: Text('네 아마도요..?')
                        ),
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.fromLTRB(15, 5, 15, 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.pinkAccent,
                            ),
                            width: 250,
                            height: 30,
                            child: Text('네..? 누구세요')
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Q. 이 어플은 쓸만한가요?'), // 질문
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.fromLTRB(15, 15, 15, 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blueAccent,
                            ),
                            width: 250,
                            height: 30,
                            child: Text('네 아마도요..?')
                        ),
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.fromLTRB(15, 5, 15, 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.pinkAccent,
                            ),
                            width: 250,
                            height: 30,
                            child: Text('네..? 누구세요')
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Q. 이 어플은 쓸만한가요?'), // 질문
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.fromLTRB(15, 15, 15, 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blueAccent,
                            ),
                            width: 250,
                            height: 30,
                            child: Text('네 아마도요..?')
                        ),
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.fromLTRB(15, 5, 15, 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.pinkAccent,
                            ),
                            width: 250,
                            height: 30,
                            child: Text('네..? 누구세요')
                        ),
                      ],
                    ),
                  ),

                  // new 상단
                  Container(
                      alignment: Alignment.centerLeft,
                      width: 300,
                      height: 30,
                      child:
                      Row(
                        children: [
                          Icon(
                              Icons.history,
                              color: Colors.black26

                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Text('NEW', style: TextStyle(

                            ),),
                          )
                        ],
                      )
                  ),
                  // new 컴포넌트
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // new 컴포넌트 단위
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey,
                            ),
                            width: 250,
                            height: 40,
                            child: Text('Q. 팀플이 필요하다 vs 사회악이다')
                        ),
                        // new 컴포넌트 단위
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey,
                            ),
                            width: 250,
                            height: 40,
                            child: Text('Q. 팀플이 필요하다 vs 사회악이다')
                        ),
                        // new 컴포넌트 단위
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey,
                            ),
                            width: 250,
                            height: 40,
                            child: Text('Q. 팀플이 필요하다 vs 사회악이다')
                        ),
                        // new 컴포넌트 단위
                        Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey,
                            ),
                            margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                            width: 250,
                            height: 40,
                            child: Text('Q. 팀플이 필요하다 vs 사회악이다')
                        ),
                        // new 컴포넌트 단위
                        Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey,
                            ),
                            margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                            width: 250,
                            height: 40,
                            child: Text('Q. 팀플이 필요하다 vs 사회악이다')
                        ),

                        // 질문하러가기 버튼
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blueAccent,
                            ),
                            width: 250,
                            height: 50,
                            child: Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: (){},
                                    child: const Text("질문하러 가기                     >", style: TextStyle( color: Colors.white, fontSize: 18))
                                )
                            )
                        ),


                      ],
                    ),
                  )
                ],
              ),
            ),
          ),



          bottomNavigationBar: BottomAppBar(
              child: SizedBox(
                height: 70,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.home),
                        onPressed: () {
                          // Home 아이콘을 눌렀을 때의 동작 추가
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MakeVote()),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.radio_button_checked),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Vote()),
                          );
                        },
                      ),
                    ]
                ),
              )

          ),
        )
    );
  }
}




