class Building {
  final String abbr;
  final String name;
  final double lat;
  final double lng;
  final int rating;
  final int ratings;
  // final UUIDString uuid;

  Building(
      {required this.abbr,
      required this.name,
      required this.lat,
      required this.lng,
      required this.rating,
      required this.ratings});

  Building.withUpdatedRatings(
    {required Building building,
    required this.abbr,
    required this.name,
    required this.lat,
    required this.lng,
    required this.rating,
    required this.ratings});
    //: uuid = building.uuid,
}
