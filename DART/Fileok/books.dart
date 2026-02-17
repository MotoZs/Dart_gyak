import "dart:io";

class FileMissingException implements Exception {
  @override
  String toString() {
    return 'Nincs ilyen néven fájl.';
  }
}
void main() {
  try {
    File file = File("C:\\Users\\b1papzso\\DART\\Fileok\\books.txt");
    file.writeAsStringSync('\nUj tartalom!!!!!!!', mode: FileMode.append);
    String content = file.readAsStringSync();
    
    print(content);
  }
  catch (e){
    print (e);
  }
}