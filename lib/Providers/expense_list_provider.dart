import 'package:expensetracker/Model/my_expense_model.dart';
import 'package:expensetracker/Providers/state_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class ExpenseListProvider with ChangeNotifier {
    var _expenseList = <MyExpenseModel>[];
  var _searchedExpenseList = <MyExpenseModel>[];
  bool _isSearch = false;


  bool get isSearch => _isSearch;
  List<MyExpenseModel> get expenseList => _expenseList;
  List<MyExpenseModel> get searchedExpenseList => _searchedExpenseList;

  setExpenseList({BuildContext? context}) {
    _expenseList.clear();
    Box<MyExpenseModel>? expenseBox = Hive.box<MyExpenseModel>(expenseBoxKey);
    expenseBox.toMap().forEach((key, value) {
      // _expenseList=<MyExpenseModel>[];
      _expenseList.add(value);
      print(_expenseList.length);
    });
    Provider.of<StateProvider>(context!, listen: false).getState();
    notifyListeners();
  }

  addExpense({MyExpenseModel? expenseValue, BuildContext? context}) {
    Box<MyExpenseModel>? expenseBox = Hive.box<MyExpenseModel>(expenseBoxKey);
    expenseBox.add(expenseValue!);
    setExpenseList(context: context);
    changeSearchState();


  }

  editExpense(
      {MyExpenseModel? expenseValue, int? index, BuildContext? context}) {
    Box<MyExpenseModel>? expenseBox = Hive.box<MyExpenseModel>(expenseBoxKey);
    expenseBox.putAt(index!, expenseValue!);
    setExpenseList(context: context);

    // changeSearchState();

  }

  deleteExpense({required int? index, required BuildContext? context}) {
    Box<MyExpenseModel>? expenseBox = Hive.box<MyExpenseModel>(expenseBoxKey);
    expenseBox.deleteAt(index!);
    setExpenseList(context: context);
  }

  searchExpence({required String searchText}) {
    _searchedExpenseList.clear();
    var list = _expenseList.where((element) =>
        element.title!.toLowerCase().contains(searchText.toLowerCase()));
    _searchedExpenseList.addAll(list);
    notifyListeners();
  }

  resetSearch(){
    _searchedExpenseList.clear();
    notifyListeners();
  }

  changeSearchState(){
    _isSearch =!_isSearch;

  }
}
