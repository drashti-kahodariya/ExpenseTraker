// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_expense_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyExpenseModelAdapter extends TypeAdapter<MyExpenseModel> {
  @override
  final int typeId = 0;

  @override
  MyExpenseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyExpenseModel(
      title: fields[0] as String?,
      description: fields[1] as String?,
      amount: fields[2] as String?,
      status: fields[3] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, MyExpenseModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyExpenseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
