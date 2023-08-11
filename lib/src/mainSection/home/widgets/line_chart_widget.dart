import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels_renter/core/models/dashboard/dashboard_data_model.dart';

Widget buildLineChart({
  required List data,
  required BuildContext context,
}) {
  return Container(
    width: Sizes().width(context, 1),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        Sizes().height(context, 0.015),
      ),
    ),
    child: SfCartesianChart(
      primaryXAxis: CategoryAxis(
        arrangeByIndex: true,
        labelStyle: body3Neutral,
      ),
      primaryYAxis: NumericAxis(
        labelStyle: body3Neutral,
      ),
      series: [
        LineSeries<DashboardDataPoints, String>(
          yValueMapper: (data, _) => data.points,
          dataSource: data as List<DashboardDataPoints>,
          xValueMapper: (data, _) => DateFormat.E().format(data.days),
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            textStyle: body3Neutral,
          ),
        ),
      ],
    ),
  );
}
