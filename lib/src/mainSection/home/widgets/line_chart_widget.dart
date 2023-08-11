import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels_renter/core/models/dashboard/dashboard_data_model.dart';

Widget buildLineChart({
  required List data,
  required BuildContext context,
}) {
  return SizedBox(
    width: Sizes().width(context, 1),
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
          yValueMapper: (data, _) => data.value,
          dataSource: data as List<DashboardDataPoints>,
          xValueMapper: (data, _) => data.label,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            textStyle: body3Neutral,
          ),
        ),
      ],
    ),
  );
}
