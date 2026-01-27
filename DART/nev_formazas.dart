import 'dart:io';

void main(){
  print("Név:");
  String name = stdin.readLineSync()!;
  String elso = "${name[0].toUpperCase()}${name.substring(1)}";
  List<String> masodik = elso.split(" ");
}