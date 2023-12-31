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
List<Map<String, dynamic>> hot_data = [];
List<Map<String, dynamic>> all_data = [];
Map<String, dynamic> choose_data = {}; // 선택시 보여줄 데이터

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    super.initState();
    fetchData(); // 데이터 셋팅
  }

  Future<void> fetchData() async {
    print('uuid $uuid');
    final response = await http.post(
        Uri.parse(BASE_URL + 'issue/search/hot'),
        body: jsonEncode({'user_id': uuid}), // 본문에 user_id를 포함
        headers: {'Content-Type': 'application/json'}, // 컨텐츠 타입을 JSON으로 지정
    );
    print('response $response');

    if (response.statusCode == 200) {
      // 성공적으로 데이터를 받아온 경우
      Map<String, dynamic> result = json.decode(response.body);
      setState(() {
        hot_data = List.from(result['issues']);
        print('response $hot_data');
      });
    } else {
      // 데이터를 받아오지 못한 경우
      throw Exception('Failed to load data');
    }
    final responseAll = await http.post(
        Uri.parse(BASE_URL + 'issue/search/hot'),
        body: jsonEncode({'user_id': uuid}), // 본문에 user_id를 포함
        headers: {'Content-Type': 'application/json'}, // 컨텐츠 타입을 JSON으로 지정
    );
    print('response $response');

    if (response.statusCode == 200) {
      // 성공적으로 데이터를 받아온 경우
      Map<String, dynamic> result = json.decode(response.body);
      setState(() {
        all_data = List.from(result['issues']);
        choose_data = all_data[0];
        print('response :  $choose_data');
      });
    } else {
      // 데이터를 받아오지 못한 경우
      throw Exception('Failed to load data');
    }
  }

  // 컴포넌트를 눌렀을 때 데이터 저장 및 페이지 이동 함수
  void onTapComponent(Map<String, dynamic> issue) {
    setState(() {
      choose_data = issue;
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Vote()),
    );
  }

  // 전체 이슈 컴포넌트
  Widget buildNewIssueComponent(Map<String, dynamic> issue) {
    // 각각의 이슈에 대한 컴포넌트를 생성하는 함수
    return GestureDetector(
      onTap: () => onTapComponent(issue),
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
              child: Text('Q. ${issue['title']}')
          ),
          // 다른 필요한 정보에 대한 Text 위젯을 추가할 수 있음
          // 예를 들면 Content 1, Content 2의 vote_count 등
        ],
      ),
    );
  }

  // 핫 이슈 컴포넌트
  Widget buildHotIssueComponent(Map<String, dynamic> issue) {
    // 각각의 이슈에 대한 컴포넌트를 생성하는 함수
    return
      GestureDetector(
        onTap: () => onTapComponent(issue),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // 질문 컴포넌트
          Container(
            margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Q. ${issue['title']}'), // 질문
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(15, 15, 15, 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blueAccent,
                    ),
                    width: 250,
                    height: 30,
                    child: Text('${issue['content_1']['title']}')
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
                    child: Text('${issue['content_2']['title']}')
                ),
              ],
            ),
          ),
          // 다른 필요한 정보에 대한 Text 위젯을 추가할 수 있음
          // Text('${issue['all_vote_count']}'),
        ],
            ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('$user'),
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
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var issue in hot_data)
                        // 각 이슈에 대한 컴포넌트를 동적으로 생성
                          buildHotIssueComponent(issue),
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
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var issue in all_data)
                        // 각 이슈에 대한 컴포넌트를 동적으로 생성
                          buildNewIssueComponent(issue),
                      ],
                    ),
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




