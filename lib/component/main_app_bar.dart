import 'package:airpollution/const/colors.dart';
import 'package:flutter/material.dart';


class MainAppBar extends StatelessWidget {
  const MainAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ts = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
    );
    return SliverAppBar(
      expandedHeight: 500.0,
      backgroundColor: primaryColor,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Container(
            //margin - 컨테이너 외부 공간 설정
            //kToolbarHeight - 시스템에 설정된 앱바의 높이를 알수 있는 변수
            margin: EdgeInsets.only(top: kToolbarHeight),
            child: Column(
              children: [
                Text(
                  '서울',
                  style: ts.copyWith(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                Text(
                  DateTime.now().toString(),
                  style: ts.copyWith(
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 20.0,),
                Image.asset(
                  'asset/img/mediocre.png',
                  //크기를 폰 사이즈의 절반만큼 설정
                  width: MediaQuery.of(context).size.width / 2,

                ),
                SizedBox(height: 20.0,),
                Text(
                  '보통',
                  style: ts.copyWith(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.0,),
                Text(
                  '나쁘지 않네요!',
                  style: ts.copyWith(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
