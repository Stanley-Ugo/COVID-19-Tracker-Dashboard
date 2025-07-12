import 'package:covid_19_tracker_dashboard/app_config/styles/app_styles.dart';
import 'package:covid_19_tracker_dashboard/app_config/styles/styles.dart';
import 'package:covid_19_tracker_dashboard/features/dashboard/bloc/covid_data_bloc.dart';
import 'package:covid_19_tracker_dashboard/helper/custom_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../components/components.dart';

class CovidScreen extends StatefulWidget {
  @override
  State<CovidScreen> createState() => _CovidScreenState();
}

class _CovidScreenState extends State<CovidScreen> {
  final List<Map<String, dynamic>> options = [
    {"label": "Last 7 days", "value": 7},
    {"label": "Last 14 days", "value": 14},
    {"label": "Last 30 days", "value": 30},
    {"label": "Last 60 days", "value": 60},
    {"label": "Last 120 days", "value": 120},
    {"label": "Last 365 days", "value": 365},
  ];
  int selectedDays = 7;
  @override
  void initState() {
    // TODO: implement initState
    context.read<CovidDataBloc>().add(
      FetchCovidDataEvent(noOfDays: selectedDays),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Dashboard',
          style: AppStyles.bold.copyWith(fontSize: 14.0.sp),
        ),
        actions: [
          Icon(
            Theme.of(context).brightness == Brightness.light
                ? Icons.dark_mode
                : Icons.light_mode,
            size: 14.0.sp,
          ),
          SizedBox(width: 4.0.sp),
          Text(
            Theme.of(context).brightness == Brightness.light
                ? "Enable Dark Mode"
                : "Enable Light Mode",
            style: AppStyles.regular.copyWith(
              fontSize: 10.0.sp,
              color: ThemeColors.of(context).primaryText,
            ),
          ),
          Transform.scale(
            scale: 0.7,
            child: Switch(
              value:
                  Theme.of(context).brightness == Brightness.light
                      ? false
                      : true,
              activeColor: ThemeColors.of(context).success,
              onChanged: (bool value) {
                setDarkModeSetting(
                  context,
                  Theme.of(context).brightness == Brightness.light
                      ? ThemeMode.dark
                      : ThemeMode.light,
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Select number days",
                  style: AppStyles.bold.copyWith(
                    fontSize: 12.0.sp,
                    color: ThemeColors.of(context).primaryText,
                  ),
                ),
                PopupMenuButton<int>(
                  initialValue: selectedDays,
                  onSelected: (value) {
                    setState(() {
                      selectedDays = value;
                    });
                    context.read<CovidDataBloc>().add(
                      FetchCovidDataEvent(noOfDays: value),
                    );
                  },
                  itemBuilder: (context) {
                    return options.map((option) {
                      return PopupMenuItem<int>(
                        value: option["value"],
                        child: Text(
                          option["label"],
                          style: AppStyles.regular.copyWith(
                            fontSize: 12.0.sp,
                            color: ThemeColors.of(context).secondaryText,
                          ),
                        ),
                      );
                    }).toList();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.filter_alt_outlined,
                        size: 14.0.sp,
                        color: ThemeColors.of(context).secondaryText,
                      ),
                      SizedBox(width: 4.0.sp),
                      Text(
                        options.firstWhere(
                          (o) => o["value"] == selectedDays,
                        )["label"],
                        style: AppStyles.regular.copyWith(fontSize: 12.0.sp),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: ThemeColors.of(context).secondaryText,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(),
            SizedBox(height: 6.0.sp),
            BlocBuilder<CovidDataBloc, CovidDataState>(
              builder: (context, state) {
                if (state is FetchingCovidDataState) {
                  return DashboardShimmer();
                } else if (state is FetchCovidDataFailedState) {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(height: 200.0.sp),
                        Text(
                          state.errorMessage,
                          textAlign: TextAlign.center,
                          style: AppStyles.regular.copyWith(
                            fontSize: 12.0.sp,
                            color: ThemeColors.of(context).error,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<CovidDataBloc>().add(
                              FetchCovidDataEvent(noOfDays: selectedDays),
                            );
                          },
                          child: Text(
                            "Retry",
                            style: AppStyles.regular.copyWith(
                              fontSize: 12.0.sp,
                              color: ThemeColors.of(context).success,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is FetchedCovidDataState) {
                  final cases = state.covidDataModel.cases;
                  final deaths = state.covidDataModel.deaths;
                  final recovered = state.covidDataModel.recovered;

                  // Sort dates
                  final sortedDates =
                      cases.keys.toList()..sort((a, b) {
                        final ad = DateFormat('M/d/yy').parse(a);
                        final bd = DateFormat('M/d/yy').parse(b);
                        return ad.compareTo(bd);
                      });

                  final rangeDates =
                      sortedDates
                          .skip(sortedDates.length - selectedDays)
                          .toList();

                  final firstDate = rangeDates.first;
                  final lastDate = rangeDates.last;

                  final totalStart = cases[firstDate] ?? 0;
                  final recoveredStart = recovered[firstDate] ?? 0;
                  final deathsStart = deaths[firstDate] ?? 0;

                  final totalEnd = cases[lastDate] ?? 0;
                  final recoveredEnd = recovered[lastDate] ?? 0;
                  final deathsEnd = deaths[lastDate] ?? 0;

                  final newCases = totalEnd - totalStart;
                  final newRecovered = recoveredEnd - recoveredStart;
                  final newDeaths = deathsEnd - deathsStart;
                  final active = (newCases - newRecovered - newDeaths).clamp(
                    0,
                    newCases,
                  );
                  final dailyNewCases = <String, int>{};
                  for (int i = 1; i < rangeDates.length; i++) {
                    final date = rangeDates[i];
                    final prevDate = rangeDates[i - 1];
                    dailyNewCases[date] = cases[date]! - cases[prevDate]!;
                  }

                  final newCasesList = dailyNewCases.entries.toList();

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Daily New Cases (Last $selectedDays Days)',
                          style: AppStyles.semiBold.copyWith(fontSize: 12.0.sp),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15.0.r),
                          ),
                          padding: EdgeInsets.all(16.0.sp),
                          height: 250,
                          child: LineChart(
                            LineChartData(
                              lineBarsData: [
                                LineChartBarData(
                                  spots:
                                      newCasesList.asMap().entries.map((entry) {
                                        return FlSpot(
                                          entry.key.toDouble(),
                                          entry.value.value.toDouble(),
                                        );
                                      }).toList(),
                                  isCurved: true,
                                  color: Colors.red,
                                  barWidth: 2,
                                  dotData: FlDotData(show: true),
                                ),
                              ],
                              titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    interval: 1,
                                    getTitlesWidget: (value, meta) {
                                      int index = value.toInt();
                                      if (index >= 0 &&
                                          index < newCasesList.length) {
                                        return Text(
                                          newCasesList[index].key.substring(
                                            0,
                                            5,
                                          ),
                                          style: AppStyles.regular.copyWith(
                                            fontSize: 9.0.sp,
                                          ),
                                        );
                                      }
                                      return Text('');
                                    },
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                              gridData: FlGridData(show: true),
                              borderData: FlBorderData(show: true),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0.sp),
                        Divider(),
                        SizedBox(height: 4.0.sp),
                        Text(
                          'Case Distribution (Last $selectedDays Days)',
                          style: AppStyles.semiBold.copyWith(fontSize: 12.0.sp),
                        ),
                        SizedBox(
                          height: 200.0.sp,
                          child: Row(
                            children: [
                              Expanded(
                                child: PieChart(
                                  PieChartData(
                                    centerSpaceRadius: 54,

                                    sections: [
                                      PieChartSectionData(
                                        value: active.toDouble(),
                                        color: Colors.orange,
                                        showTitle: false,
                                      ),
                                      PieChartSectionData(
                                        value: newRecovered.toDouble(),
                                        color: Colors.green,
                                        showTitle: false,
                                      ),
                                      PieChartSectionData(
                                        value: newDeaths.toDouble(),
                                        color: Colors.red,
                                        showTitle: false,
                                      ),
                                    ],
                                    sectionsSpace: 2,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 20.0.sp),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    LegendItem(
                                      label:
                                          "Active: ${CustomFunctions.formatNumber(active)}",
                                      color: Colors.orange,
                                    ),
                                    SizedBox(height: 8.0.sp),
                                    LegendItem(
                                      label:
                                          "Recovered: ${CustomFunctions.formatNumber(newRecovered)}",
                                      color: Colors.green,
                                    ),
                                    SizedBox(height: 8.0.sp),
                                    LegendItem(
                                      label:
                                          "Deaths: ${CustomFunctions.formatNumber(newDeaths)}",
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        SizedBox(height: 10.0.sp),
                        Text(
                          "Data Computation (Last $selectedDays Days)",
                          style: AppStyles.semiBold.copyWith(fontSize: 12.0.sp),
                        ),
                        CovidCasesTable(data: state.covidDataModel),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(height: 200.0.sp),
                        Text(
                          "No data found",
                          textAlign: TextAlign.center,
                          style: AppStyles.regular.copyWith(
                            fontSize: 12.0.sp,
                            color: ThemeColors.of(context).error,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<CovidDataBloc>().add(
                              FetchCovidDataEvent(noOfDays: selectedDays),
                            );
                          },
                          child: Text(
                            "Retry",
                            style: AppStyles.regular.copyWith(
                              fontSize: 12.0.sp,
                              color: ThemeColors.of(context).success,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
