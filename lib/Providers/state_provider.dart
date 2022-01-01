import 'package:expensetracker/Model/my_expense_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../main.dart';

class StateProvider with ChangeNotifier {
  double _incomeAmount = 0.0;
  double _outcomeAmount = 0.0;

  double get incomeAmount => _incomeAmount;
  double get outcomeAmount => _outcomeAmount;

  getState() {
    _incomeAmount = 0.0;
    _outcomeAmount = 0.0;
    Box<MyExpenseModel>? expenseBox = Hive.box<MyExpenseModel>(expenseBoxKey);
    expenseBox.toMap().forEach((key, value) {
      if (!value.status!) {
        _incomeAmount += double.parse(value.amount!);
      } else {
        _outcomeAmount += double.parse(value.amount!);
      }
    });
    notifyListeners();
  }


}

