
class Movie  extends Object with _$MovieSerializerMixin{
  String url;
  String name;
  String episode;
  String picture;
  String intro;
  Movie({this.url,this.name,this.episode,this.picture,this.intro});
  get cartoonUrl=>url;
  get cartoonName=>name;
  get cartoonEpisode=>episode;
  get cartoonPicture=>picture;
  get cartoonIntro=>intro;

  factory Movie.fromJson(Map<String, dynamic> json) {
    Movie cartoon = _$MovieFromJson(json);
    return cartoon;
  }
}
Movie _$MovieFromJson(Map<String, dynamic> json) => new Movie(
    url: json['url'] as String,
    name: json['name'] as String,
    episode: json['episode'] as String,
    picture: json['picture'] as String,
    intro: json['intro'] as String);

abstract class _$MovieSerializerMixin {
  String get url;
  String get name;
  String get episode;
  String get picture;
  String get intro;
  Map<String, dynamic> toJson() => <String, dynamic>{
    'url': url,
    'name': name,
    'episode': episode,
    'picture': picture,
    'intro': intro
  };
}
