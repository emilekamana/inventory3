import 'package:flutter/material.dart';

class MyData {
  int id;
  String name;

  MyData({required this.id, required this.name});
}

class MyDataModel {
  final List<MyData> _dataList = [];
  final ValueNotifier<List<MyData>> _dataNotifier = ValueNotifier([]);

  List<MyData> get dataList => _dataList;

  ValueNotifier<List<MyData>> get dataNotifier => _dataNotifier;

  void addData(MyData newData) {
    _dataList.add(newData);
    _dataNotifier.value = _dataList; // Notify listeners that the data has changed
  }
}

void main() {
  final myDataModel = MyDataModel();

  // Register a listener function that will be called whenever the data changes
  myDataModel.dataNotifier.addListener(() {
    final updatedDataList = myDataModel.dataList;
    // Do something with the updated data list, such as assigning it to a variable
    print(updatedDataList);
  });

  // Add some data to the model
  myDataModel.addData(MyData(id: 1, name: 'Data 1'));
  myDataModel.addData(MyData(id: 2, name: 'Data 2'));

  // Update some data in the model
  myDataModel.dataList[1].name = 'New Data 2';
  myDataModel.dataNotifier.value = myDataModel.dataList; // Notify listeners that the data has changed
}
