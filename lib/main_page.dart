import 'package:flutter/material.dart';
import 'package:flutterworkshop/data_provider.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = Provider.of<DataProvider>(context).dataMap;

    return Scaffold(
      appBar: AppBar(
        title: Text('View chart'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.of(context).pushNamed('/edit'),
          )
        ],
      ),
      body: PieChart(
        dataMap: dataMap,
        legendPosition: LegendPosition.top,
      ),
    );
  }
}
