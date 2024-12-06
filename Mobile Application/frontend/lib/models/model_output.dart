class ModelOutput {
  final double doublePlanter;
  final double weedCluster;
  final double standingWater;

  ModelOutput({
    required this.doublePlanter,
    required this.weedCluster,
    required this.standingWater,
  });

  factory ModelOutput.fromJson(Map<String, dynamic> json) {
    return ModelOutput(
      doublePlanter: json['double_planter'],
      weedCluster: json['weed_cluster'],
      standingWater: json['standing_water'],
    );
  }
}
