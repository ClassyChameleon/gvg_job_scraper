// Go over your database. Keywords and search presets might use redundant table.
List<String> createTables = [
  'CREATE TABLE search_presets(preset_name VARCHAR PRIMARY KEY)',
  'CREATE TABLE keywords(keyword VARCHAR PRIMARY KEY)',
  'CREATE TABLE search_presets_and_keywords',
];
