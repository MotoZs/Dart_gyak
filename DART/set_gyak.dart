void main() {
  uniqueAsc();
  vowelsCount();
  wordCount();
}

void uniqueAsc() {
  List<int> a = [1, 3, 4, 5, 6, 5, 4, 3, 3, 3, 3, 2, 1, 1, 7, 8, 8, 7, 9];
  List<int> egyszer = a.toSet().toList()..sort();
  print(egyszer);
}

// ...existing code...
void vowelsCount() {
  String text = "Ezt a szöveget Akarom tesztelni!";
  Set<String> vowels = {'a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'};
  Map<String, int> count = {};

  for (var char in text.split('')) {
    if (vowels.contains(char)) {
      count[char.toLowerCase()] = (count[char.toLowerCase()] ?? 0) + 1;
    }
  }

  print(count);
}

void wordCount() {
  String text = "Ez egy ujabb teszt szoveg! egy egy ";
  Map<String, int> count = {};

  List<String> words = text
      .toLowerCase()
      .replaceAll(RegExp(r'[^\w\s]'), '')
      .split(RegExp(r'\s+'));

  for (var word in words) {
    if (word.isNotEmpty) {
      count[word] = (count[word] ?? 0) + 1;
    }
  }

  print(count);
}
