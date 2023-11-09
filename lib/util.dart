// Prints the keys and contents of a map
void mapExtractor(Map d) {
  print('===============================');
  print('BEGIN EXTRACTION');
  print('===============================');
  for (var e in d.keys) {
    print(e + ': ' + d[e].toString());
  }
  print('EXTRACTION COMPLETE');
  print('===============================');
}

// Prints the keys of a map
void mapIterator(Map d) {
  print('===============================');
  print('BEGIN EXTRACTION');
  print('===============================');
  for (var e in d.keys) {
    print(e);
  }
  print('EXTRACTION COMPLETE');
  print('===============================');
}

void listIterator(List d) {
  print('===============================');
  print('BEGIN EXTRACTION');
  print('===============================');
  for (var e in d) {
    print(e.toString());
  }
  print('EXTRACTION COMPLETE');
  print('===============================');
}
