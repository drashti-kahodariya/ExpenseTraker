import 'package:hive/hive.dart';

part 'my_expense_model.g.dart';

@HiveType(typeId: 0)
class MyExpenseModel{
  @HiveField(0)
  final String? title;
  @HiveField(1)
  final String? description;
  @HiveField(2)
  final String? amount;
  @HiveField(3)
  final bool? status;

  MyExpenseModel({this.title, this.description, this.amount,this.status});

}