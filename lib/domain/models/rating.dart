class Rating{
  final String id;
  final double rating;
  const Rating({required this.id, required this.rating});

  Map<dynamic,dynamic> toJson(){
    return {"id": id, "rating":rating};
  }
}