// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToDoEntryModel _$ToDoEntryModelFromJson(Map<String, dynamic> json) =>
    ToDoEntryModel(
      description: json['description'] as String,
      id: json['id'] as String,
      isDone: json['isDone'] as bool,
    );

Map<String, dynamic> _$ToDoEntryModelToJson(ToDoEntryModel instance) =>
    <String, dynamic>{
      'description': instance.description,
      'isDone': instance.isDone,
      'id': instance.id,
    };
