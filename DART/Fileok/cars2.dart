import "dart:io";

class FileMissingException implements Exception {
  @override
  String toString() {
    return 'Nincs ilyen néven fájl.';
  }
}
void main() {
  try {
    File file = File("C:\\Users\\b1papzso\\Dart_gyak\\DART\\Fileok\\cars2.txt");
    file.writeAsStringSync('\nMeg ujabb auto!!!!!!!', mode: FileMode.append);
    String content = file.readAsStringSync();
    
    print(content);
  }
  catch (e){
    print (e);
  }
}

