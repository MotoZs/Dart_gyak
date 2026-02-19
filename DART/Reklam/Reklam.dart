import 'dart:io';

void main() {
  elso();
}

void elso() {
  print("\n#1 Feladat");
  File file = File("C:\\Users\\b1papzso\\Dart_gyak\\DART\\Reklam\\rendel.txt");
  List<String> contents = file.readAsLinesSync();

  List<Map<String, dynamic>> rendelesek = [];
  for (var row in contents) {
    var line = row.split(" ");
    rendelesek.add({
      "nap: ": int.parse(line[0]),
      "tipus: ": line[1],
      "mennyiseg: ": int.parse(line[2]),
    });
  }
  //print(rendelesek);

  print("\n#2 Feladat\nRendelések száma: ${rendelesek.length}");

  print("\n#3 Feladat\nKérem adjon meg egy napot: ");
  int day = int.parse(stdin.readLineSync()!);
  var keresett = rendelesek.where((x) => x["nap"] == day).toList();
  print("A rendelések száma az adott napon: ${keresett.length}");

  print("\n#4 Feladat");
  var NR = rendelesek.where((x) => x["tipus"] == "NR");
  print(NR.length);
  Set<int> napok = {};
  for (var rendeles in NR) {
    napok.add(rendeles["nap"]);
  }
  print("Keresett nap: ${30 - napok.length}");
}
