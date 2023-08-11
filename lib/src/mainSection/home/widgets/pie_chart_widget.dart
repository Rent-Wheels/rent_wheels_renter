import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels_renter/core/models/dashboard/dashboard_data_model.dart';

Widget buildPieChart({
  required List data,
  required String title,
  required BuildContext context,
}) {
  return Container(
    width: Sizes().width(context, 0.95),
    margin: EdgeInsets.only(bottom: Sizes().width(context, 0.05)),
    child: SfCircularChart(
      title: ChartTitle(
        text: title,
        textStyle: heading4Information,
      ),
      legend: const Legend(
        isVisible: true,
        isResponsive: true,
        textStyle: body2Neutral900,
        position: LegendPosition.bottom,
        overflowMode: LegendItemOverflowMode.wrap,
      ),
      series: [
        PieSeries<DashboardDataPoints, String>(
          radius: '100%',
          dataSource: data as List<DashboardDataPoints>,
          xValueMapper: (data, _) => data.label,
          yValueMapper: (data, _) => data.value,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            textStyle: body3Neutral0,
          ),
        ),
      ],
    ),
  );
}
