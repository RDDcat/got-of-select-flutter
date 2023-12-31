import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'main.dart';

// 투표 페이지
class Vote extends StatefulWidget {
  const Vote({Key? key}) : super(key: key);

  @override
  VoteState createState() => VoteState();

}

class VoteState extends State<Vote>{
  // 변수 선언
  String title = choose_data['title'];
  String content1 = choose_data['content_1']['title'];
  String content2 = choose_data['content_2']['title'];
  int allVoteCount = choose_data['all_vote_count'];

  // 함수 추가
  Future<void> sendVote(String contentId) async {
    print('투표함');
    final response = await http.post(
      Uri.parse('${BASE_URL}issue/vote'), // 실제 엔드포인트로 변경
      body: jsonEncode({
        'user_id': uuid,
        'issue_id': choose_data['id'],
        'content_id': contentId,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // 성공적으로 투표가 이루어진 경우
      // 다음 질문 데이터를 가져와서 셋팅하는 등의 로직을 추가할 수 있습니다.
      print('success');
    } else {
      // 투표 요청이 실패한 경우
      print('Failed to send vote');
    }
  }

  @override
  Widget build(BuildContext context) {

    // axios 요청

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
                  margin:  EdgeInsets.fromLTRB(0, 30, 0, 30),
                  child: Text("Q. ${title}  " ,
                      style: TextStyle( color: Colors.white, fontSize: 24)
                  )
              ), // 제목
              Column(
                children: [
                  Container(
                    margin:  EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () async {
                          // axios 요청으로 데이터 저장 후 다음 질문 데이터 가져와서 셋팅
                          await sendVote(choose_data['content_1']['id']); // content_1_uuid 대신 실제 컨텐트 아이디로 변경
                        },
                        child: Text(content1,
                            style: TextStyle( color: Colors.white, fontSize: 20)
                        )
                    ),
                  ), // 첫번째 선택창
                  Container(
                      margin:  EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Text('VS',
                          style: TextStyle( color: Colors.white, fontSize: 18)
                      )
                  ), // vs
                  Container(
                    margin:  EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () async {
                          await sendVote(choose_data['content_2']['id']); // content_2_uuid 대신 실제 컨텐트 아이디로 변경
                        },
                        child: Text(content2,
                            style: TextStyle( color: Colors.white, fontSize: 20)
                        )
                    ),
                  ), // 두번째 선택창
                ],
              ), // vs
              Container(
                  margin:  EdgeInsets.fromLTRB(0, 0, 25, 20),
                  alignment: Alignment.centerRight,
                  child: Text("$allVoteCount명 투표함" ,
                      style: TextStyle( color: Colors.grey, fontSize: 14)
                  )
              ), // 하단 정보
            ],
          )
      ),
    );
  }
}