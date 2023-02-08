import 'package:airpollution/component/category_card.dart';
import 'package:airpollution/component/hourly_card.dart';
import 'package:airpollution/component/main_app_bar.dart';
import 'package:airpollution/component/main_drawer.dart';
import 'package:airpollution/const/colors.dart';
import 'package:airpollution/const/regions.dart';
import 'package:airpollution/repository/stat_repository.dart';
import 'package:airpollution/utils/data_utils.dart';
import 'package:flutter/material.dart';

import '../model/stat_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String region = regions[0];

  Future<Map<ItemCode, List<StatModel>>> fetchData() async {
    Map<ItemCode, List<StatModel>> stats = {};
    List<Future> futures = [];

    for (ItemCode itemCode in ItemCode.values) {
      futures.add(
        StatRepository.fetchData(
          itemCode: itemCode,
        ),
      );
    }

    final results = await Future.wait(futures);

    for(int i = 0; i<results.length; i++) {
      final key = ItemCode.values[i];
      final value = results[i];

      stats.addAll({key:value});
    }

    return stats;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      drawer: MainDrawer(
        selectedRegion: region,
        onRegionTap: (String region) {
          setState(() {
            this.region = region;
            Navigator.of(context).pop();
          });
        },
      ),
      body: FutureBuilder<Map<ItemCode, List<StatModel>>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('에러가 있습니다.'),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          Map<ItemCode, List<StatModel>> stats = snapshot.data!;
          StatModel pm10RecentStat = stats[ItemCode.PM10]![0];

          final status = DataUtils.getStatusFromItemCodeAndValue(
            value: pm10RecentStat.seoul,
            itemCode: ItemCode.PM10,
          );

          return CustomScrollView(
            slivers: [
              MainAppBar(
                stat: pm10RecentStat,
                status: status,
                region: region,
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CategoryCard(),
                    const SizedBox(
                      height: 16.0,
                    ),
                    HourlyCard(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
