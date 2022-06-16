import 'package:we_chat_app/dummy/dummy_data_for_contact_page.dart';

void main() {
  List<String> beginLettersList = dummyContactList.map((e) => e[0]).toSet().toList();
  print(beginLettersList);
  List<String> nameByFilter = dummyContactList.where((element) => element[0] == beginLettersList[2]).toList();
  print(nameByFilter);

  List<String> list = ["B", "C", "D"];
  print(list[0]);
  list.insert(0, "A");
  print("${list[0]} ${list[1]}");

}