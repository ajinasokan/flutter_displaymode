class DisplayMode {
  const DisplayMode({
    required this.id,
    required this.width,
    required this.height,
    required this.refreshRate,
  });

  factory DisplayMode.fromJson(Map<String, dynamic> json) {
    return DisplayMode(
      id: json['id'] as int,
      width: json['width'] as int,
      height: json['height'] as int,
      refreshRate: json['refreshRate'] as double,
    );
  }

  final int id;
  final int width;
  final int height;
  final double refreshRate;

  static const DisplayMode auto = DisplayMode(
    id: 0,
    width: 0,
    height: 0,
    refreshRate: 0,
  );

  @override
  String toString() {
    return '#$id ${width}x$height @ ${refreshRate.toInt()}Hz';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DisplayMode &&
          runtimeType == other.runtimeType &&
          width == other.width &&
          height == other.height &&
          refreshRate == other.refreshRate;

  @override
  int get hashCode => width.hashCode ^ height.hashCode ^ refreshRate.hashCode;
}
