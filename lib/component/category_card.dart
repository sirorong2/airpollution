import 'package:airpollution/component/card_title.dart';
import 'package:airpollution/const/colors.dart';
import 'package:airpollution/model/stat_and_status_model.dart';
import 'package:airpollution/utils/data_utils.dart';
import 'package:flutter/material.dart';

import 'main_card.dart';
import 'main_stat.dart';

class CategoryCard extends StatelessWidget {
  final String region;
  final List<StatAndStatusModel> models;
  final Color darkColor;
  final Color lightColor;

  const CategoryCard({
    Key? key,
    required this.region,
    required this.models,
    required this.darkColor,
    required this.lightColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: MainCard(
        backgroundColor:lightColor,
        child: LayoutBuilder(builder: (context, constraint) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CardTitle(
                backgroundColor: darkColor,
                title: '종류별 통계',
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: PageScrollPhysics(),
                  children: models
                      .map(
                        (model) =>
                        MainStat(
                          width: constraint.maxWidth / 3,
                          category: DataUtils.getItemCodeKrString(
                              itemCode: model.itemCode),
                          imgPath: model.status.imagePath,
                          level: model.status.label,
                          stat:
                          '${model.stat.getLevelFromRegion(region)}${DataUtils
                              .getUnitFromItemCode(itemCode: model.itemCode)}',
                        ),
                  )
                      .toList(),
                  // children: List.generate(
                  //   20,
                  //   (index) => MainStat(
                  //     category: '미세먼지$index',
                  //     imgPath: 'asset/img/best.png',
                  //     level: '최고',
                  //     stat: '0㎍/㎥',
                  //     width: constraint.maxWidth / 3,
                  //   ),
                  // ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
