class Palabra {
  final String castellano;
  final String guarani;

  const Palabra({required this.guarani, required this.castellano});

  factory Palabra.fromJson(Map<String, dynamic> json) {
    return Palabra(
        castellano: json['castellano'] as String,
        guarani: json['guarani'] !=null ? json['guarani'] : "" as String
        );
  }
  //  : castellano = json['castellano'],
  //  guarani = json['guarani'];

  Map<String, dynamic> toJson() => {
        'castellano': castellano,
        'guarani': guarani,
      };
}
