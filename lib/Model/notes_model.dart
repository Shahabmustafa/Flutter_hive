import 'package:hive/hive.dart';
part 'notes_model.g.dart';

@HiveType(typeId: 0)
class NotesModel extends HiveObject{
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? Description;

  NotesModel({required this.title,required this.Description});
}

// @HiveType(typeId: 1)
// class ContactsModel{
//   String? title;
//   String? Description;
//
//   ContactsModel({required this.title,required this.Description});
// }

