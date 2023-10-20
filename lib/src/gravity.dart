enum Gravity {
  center('center'),
  topLeft('top-left'),
  top('top'),
  topRight('top-right'),
  left('left'),
  right('right'),
  bottomLeft('bottom-left'),
  bottom('bottom'),
  bottomRight('bottom-right');

  const Gravity(this.raw);

  final String raw;
}
