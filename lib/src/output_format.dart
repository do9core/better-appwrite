enum OutputFormat {
  jpeg('jpeg'),
  jpg('jpg'),
  png('png'),
  gif('gif'),
  webp('webp');

  const OutputFormat(this.raw);

  final String raw;
}
