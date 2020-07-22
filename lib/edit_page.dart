import 'package:flutter/material.dart';
import 'package:flutterworkshop/data_provider.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  Map<String, double> dataMap;

  @override
  void initState() {
    super.initState();
    dataMap = Provider.of<DataProvider>(context, listen: false).dataMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit chart'),
        actions: [
          FlatButton(
            child: Text('Save'),
            onPressed: () {
              Provider.of<DataProvider>(context, listen: false).dataMap =
                  dataMap;
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: (dataMap == null)
          ? Center(child: Text('No data to edit'))
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                      Card(child: PieChart(dataMap: dataMap)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                "Name",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: Text(
                                "Value",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ] +
                    buildTextFields(dataMap, context),
              ),
            ),
    );
  }

  List<Widget> buildTextFields(
      Map<String, double> dataMap, BuildContext context) {
    return dataMap
        .map(
          (key, value) => MapEntry(
              key,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        initialValue: key,
                        readOnly: true,
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: TextFormField(
                        initialValue: value.toString(),
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        onChanged: (newString) {
                          double newValue = double.tryParse(newString) ?? 0.0;
                          setState(() {
                            dataMap[key] = newValue;
                          });
                          print(key + ': ' + newValue.toString());
                        },
                      ),
                    ),
                  ],
                ),
              )),
        )
        .values
        .toList();
  }
}
