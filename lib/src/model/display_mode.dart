class DisplayMode {
  const DisplayMode({
    this.id,
    this.width,
    this.height,
    this.refreshRate,
    this.selected,
  });

  factory DisplayMode.fromJson(Map<String, dynamic> json) {
    return DisplayMode(
      id: json['id'] as int,
      width: json['width'] as int,
      height: json['height'] as int,
      refreshRate: json['refreshRate'] as double,
      selected: json['selected'] as bool,
    );
  }

  final int id;
  final int width;
  final int height;
  final double refreshRate;
  final bool selected;

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
          refreshRate == other.refreshRate &&
          selected == other.selected;

  @override
  int get hashCode =>
      width.hashCode ^
      height.hashCode ^
      refreshRate.hashCode ^
      selected.hashCode;
}
