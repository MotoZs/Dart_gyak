import 'dart:io';

void main() {
  File file = new File(
    'C:\\Users\\b1papzso\\Dart_gyak\\DART\\taborok\\taborok.txt',
  );
  List<String> content = file.readAsLinesSync();
  List<Map<String, dynamic>> taborok = [];

  for (var row in content) {
    var line = row.split("\t");
    taborok.add({
      "kezdho": int.parse(line[0]),
      "kezdnap": int.parse(line[1]),
      "vegho": int.parse(line[2]),
      "vegnap": int.parse(line[3]),
      "diak": line[4],
      "szak": line[5],
    });
  }
  stdout.write("Adja meg egy tanuló betűnevét: ");
  var betu = stdin.readLineSync()!;
  List<int> ido = [];
  List<String> keresett = [];
  for (var tabor in taborok) {
    if (tabor["diak"].toString().contains(betu)) {
      keresett.add(
        '${tabor["kezdho"]}.${tabor["kezdnap"]}-${tabor["vegho"]}.${tabor["vegnap"]}. ${tabor["szak"]}',
      );
    }
  }
  keresett.sort();
  File egytanulo = new File("egyatanulo.txt");
  egytanulo.writeAsStringSync(keresett.join("\n"));
}
