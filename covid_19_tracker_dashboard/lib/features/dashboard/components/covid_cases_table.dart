import 'package:covid_19_tracker_dashboard/app_config/styles/app_styles.dart';
import 'package:covid_19_tracker_dashboard/app_config/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/models/models.dart';

class CovidCasesTable extends StatelessWidget {
  final CovidDataModel data;

  const CovidCasesTable({super.key, required this.data});

  String formatNumber(int? number) {
    if (number == null) return "—";
    return NumberFormat("#,###").format(number);
  }

  @override
  Widget build(BuildContext context) {
    final cases = data.cases;
    final sortedDates = cases.keys.toList()..sort();

    // Build table rows dynamically
    final List<Map<String, dynamic>> rows = [];

    for (int i = 0; i < sortedDates.length; i++) {
      final date = sortedDates[i];
      final cumulative = cases[date];
      final previous = i > 0 ? cases[sortedDates[i - 1]] : null;
      final daily =
          (previous != null && cumulative != null)
              ? cumulative - previous
              : null;

      rows.add({
        "date": date,
        "cumulative": cumulative,
        // "previous": previous,
        "daily": daily,
      });
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: MaterialStateColor.resolveWith(
          (states) => Colors.green,
        ),
        columns: [
          DataColumn(
            label: Text(
              "S/N",
              style: AppStyles.semiBold.copyWith(fontSize: 10.0.sp, color: Colors.white),
            ),
            numeric: true,
          ),
          DataColumn(
            label: Text(
              "Date",
              style: AppStyles.semiBold.copyWith(fontSize: 10.0.sp, color: Colors.white),
            ),
          ),

          // DataColumn(
          //   label: Text(
          //     "Previous",
          //     style: TextStyle(fontWeight: FontWeight.bold),
          //   ),
          //   numeric: true,
          // ),
          DataColumn(
            label: Text(
              "Daily New Cases",
              style: AppStyles.semiBold.copyWith(fontSize: 10.0.sp, color: Colors.white),
            ),
            numeric: true,
          ),
          DataColumn(
            label: Text(
              "Cumulative",
              style: AppStyles.semiBold.copyWith(fontSize: 10.0.sp, color: Colors.white),
            ),
            numeric: true,
          ),
        ],
        rows:
            rows.asMap().entries.map((entry) {
              final index = entry.key; // This is 0-based
              final row = entry.value;

              return DataRow(
                cells: [
                  DataCell(
                    Text(
                      '${index + 1}',
                      style: AppStyles.regular.copyWith(fontSize: 10.0.sp),
                    ),
                  ), // Serial Number column
                  DataCell(
                    Text(
                      row["date"],
                      style: AppStyles.regular.copyWith(fontSize: 10.0.sp),
                    ),
                  ),
                  DataCell(
                    row["daily"] != null
                        ? Text(
                          formatNumber(row["daily"]),
                          style: AppStyles.regular.copyWith(fontSize: 10.0.sp),
                        )
                        : Text("—"),
                  ),
                  DataCell(
                    Text(
                      formatNumber(row["cumulative"]),
                      style: AppStyles.regular.copyWith(fontSize: 10.0.sp),
                    ),
                  ),
                ],
              );
            }).toList(),
      ),
    );
  }
}
