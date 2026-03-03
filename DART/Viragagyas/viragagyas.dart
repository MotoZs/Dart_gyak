import 'dart:math';
import 'dart:io';

void main() {
  File file = File('felajanlas.txt');
  List<String> contents = file.readAsLinesSync();
  List<Map<String, dynamic>> viragagyasok = [];
  int viragagyasokSzama = int.parse(contents[0]);
  for (var row in contents) {
    var line = row.split(" ");
    viragagyasok.add({
      "mettol": int.parse(line[0]),
      "meddig": int.parse(line[1]),
      "szin": line[2],
    });
  }
  print("#6");
  List<String> adatok = [];
  for (var i = 0; i < viragagyasok.length; i++) {
    var szin = viragagyasok[i]["szin"] as String;
    var index = i + 1;
    int mettol = viragagyasok[i]["mettol"];
    int meddig = viragagyasok[i]["meddig"];
    if (mettol < meddig) {
      for (var j = mettol; j <= meddig; j++) {
        if (adatok[j].isEmpty) {
          adatok[j] = '${szin} ${index}';
        }
      }
    }
  }
}
