class ListCandidates {
  ListCandidates({
    required this.candidates,
  });
  late final List<Candidates> candidates;

  ListCandidates.fromJson(Map<String, dynamic> json) {
    candidates = List.from(json['candidates'])
        .map((e) => Candidates.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['candidates'] = candidates.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Candidates {
  Candidates({
    required this.voice,
    required this.name,
  });
  late final int voice;
  late final String name;

  Candidates.fromJson(Map<String, dynamic> json) {
    voice = json['voice'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['voice'] = voice;
    _data['name'] = name;
    return _data;
  }
}
