import 'dart:io';
import 'dart:math';

void main() {
  File file = File("C:\\Users\\b1papzso\\Dart_gyak\\DART\\Reklam\\rendel.txt");
  List<String> contents = file.readAsLinesSync();
  List<Map<String, dynamic>> rendelesek = [];
  for(var row in contents){
    var line = row.split(" ");
    rendelesek.add({
      "nap": int.parse(line[0]),
      "tipus": line[1],
      "mennyiseg": int.parse(line[2])
    });
  }

  print("2. feladat: ");
  print("A rendelesek szama: ${rendelesek.length}");
 
  print("3. feladat: ");
  print("Kérem adjon meg egy napot: ");
  int day = int.parse(stdin.readLineSync()!);
  var result = rendelesek.where((x) => x["nap"] == day);
  print("A rendelesek szama az adott napon: ${result.length}");

  print("4. feladat: ");
  var NR = rendelesek.where((x) => x["tipus"] == "NR");
  Set<int> napok = {};
  for(var rendeles in NR){
    napok.add(rendeles["nap"]);
  }
  var calc = 30 - napok.length;
  if (calc == 0) {
    print("minden nap volt");
  }
  print("${calc} nap nem volt rendeles a reklamban nem erintett varosbol");
  print("5.feladat");
  var maxDarab = rendelesek[0];
  rendelesek.forEach((rendeles) {
    if(rendeles["mennyiseg"] > maxDarab["mennyiseg"]){
      maxDarab = rendeles;
    }
  });
  print("A legnagyobb darabszám: ${maxDarab["mennyiseg"]}, a rendelés napja: ${maxDarab["nap"]}");
  print("6.feladat");
  print("Adj meg egy várost:");
  var varos = stdin.readLineSync()!;
  print("Adj meg egy napot!");
  var nap = int.parse(stdin.readLineSync()!);
  var eredmeny = osszes(varos, nap, rendelesek);  
  print("7.feldat");
  var elso = osszes("PL", 21, rendelesek);
  var masodik = osszes("TV", 21, rendelesek);
  var harmadik = osszes("NR", 21, rendelesek);
  print("A rendelt termékek darabszáma a 21. napon PL: ${elso} TV: ${masodik} NR: ${harmadik} ");
  print("8.feladat");
  String kimenet = "Napok 1..10 11..20 21..30\n";
  List<int> PLszamok = [0,0,0];
  List<int> TVszamok = [0,0,0];
  List<int> NRszamok = [0,0,0];
  for(var i = 0; i < 31; i++ ){
    PLszamok[i ~/ 10] += osszes("PL", i, rendelesek);
    TVszamok[i ~/ 10] += osszes("TV", i, rendelesek);
    NRszamok[i ~/ 10] += osszes("NR", i, rendelesek);
  }
}


int osszes(String varos, int nap, List<Map<String, dynamic>> rendelsek){
  int eredmeny = 0;
  rendelsek.forEach((rendeles) {
    if(rendeles["tipus"] == varos && rendeles["nap"] == nap){
      eredmeny += rendeles["mennyiseg"]as int;
    }
  });
  return eredmeny;
}