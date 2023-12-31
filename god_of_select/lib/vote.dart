import 'package:flutter/material.dart';

import 'main.dart';

// 투표 페이지
class Vote extends StatefulWidget {
  const Vote({Key? key}) : super(key: key);

  @override
  VoteState createState() => VoteState();

}

class VoteState extends State<Vote>{
  // 변수 선언
  String title = "이 어플은 쓸만한가요?";
  String content1 = "문득 세삼 ...";
  String content2 = "네...?";
  int allVoteCount = 0;

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
                        onPressed: (){
                          // axios 요청으로 데이터 저장 후 다음 질문 데이터 가져와서 셋팅
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
                        onPressed: (){
                          // axios 요청으로 데이터 저장 후 다음 질문 데이터 가져와서 셋팅
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
                  child: Text("${allVoteCount}명 투표함" ,
                      style: TextStyle( color: Colors.grey, fontSize: 14)
                  )
              ), // 하단 정보
            ],
          )
      ),
    );
  }
}