import 'dart:ffi';
import 'dart:io';

void main() {
  //elso();
  //masodik();
  //harmadik();
  //negyes();
  reverseInteger(246);
}

void elso() {
  print("Első szám:");
  int a = int.parse(stdin.readLineSync()!);
  if (a > 99) {
    print("max 99");
    return;
  }

  print("Második szám:");
  int b = int.parse(stdin.readLineSync()!);
  if (b > 99) {
    print("max 99");
    return;
  }

  for (int i = a; i <= b; i++) {
    if (i % 2 == 0) {
      print("${i} - Páros");
    } else {
      print("${i} - Páratlan");
    }
  }
}

void masodik() {
  List<String> uefa2024euro = [
    "Spain",
    "Germany",
    "Portugal",
    "France",
    "Netherlands",
    "Turkey",
    "England",
    "Switzerland",
  ];
  uefa2024euro.asMap().forEach((index, value) => print("${index} ${value}"));
}

void harmadik() {
  List<String> uefa2024euro = [
    "Spain",
    "Germany",
    "Portugal",
    "France",
    "Netherlands",
    "Turkey",
    "England",
    "Switzerland",
  ];
  for (var i = 0; i <= uefa2024euro.length - 1; i++) {
    for (var j = i + 1; j < uefa2024euro.length; j++) {
      print("${uefa2024euro[i]} - ${uefa2024euro[j]}}");
    }
  }
}

void negyes() {
  print("Szám:");
  String a = stdin.readLineSync()!;
  for (int i = 0; i < a.length; i++) {
    a[0];
  }
}

void reverseInteger(a) {
  List<String> b = [];
  String d = a.toString();
  for (int i = 0; i < d.length; i++) {
    b.add(d[i]);
  }
  print(b);

  List<String> c = [];
  for (int i = b.length; i > 0; i--) {
    c.add(b[i]);
  }
  print(c);
}
