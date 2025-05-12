class KNavDestination {
  KNavDestination({
    required this.icon,
    this.selectIcon,
    this.isDrawerButton = false,
    this.title = '',
    this.isHighlight,
  });

  final String icon;
  final String? selectIcon;
  final bool isDrawerButton;
  final String title;
  final bool? isHighlight;
}
