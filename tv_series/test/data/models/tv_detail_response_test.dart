import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/data/models/tv_detail_response.dart';

import '../../dummy/dummy_objects.dart';
import '../../json_reader.dart';

void main() {
  final tDetailJson = readJson('dummy/tv_detail_response.json');
  final tDetailModel = dummyTvDetailResponse;
  final tDetail = dummyTvSeriesDetail;
  final tDetailMap = {
    "adult": false,
    "backdrop_path": "/7cqKGQMnNabzOpi7qaIgZvQ7NGV.jpg",
    "created_by": [
      {
        "id": 58321,
        "credit_id": "5f3814c011c066003637f6a8",
        "name": "Eric Kripke",
        "original_name": "Eric Kripke",
        "gender": 2,
        "profile_path": "/dd7EgfOEKPqQxWtBfAvjYZahbSc.jpg"
      }
    ],
    "episode_run_time": [
      60
    ],
    "first_air_date": "2019-07-25",
    "genres": [
      {
        "id": 10765,
        "name": "Sci-Fi & Fantasy"
      }
    ],
    "homepage": "https://www.amazon.com/dp/B0875L45GK",
    "id": 76479,
    "in_production": true,
    "languages": [
      "en"
    ],
    "last_air_date": "2024-06-13",
    "last_episode_to_air": {
      "id": 4781986,
      "overview": "This December at VoughtCoin Arena, experience the story of Christmas the way it was meant to be told... on ice! Vought Presents Vought on Ice! Tickets available now at VoughtOnIce.com!",
      "name": "We'll Keep the Red Flag Flying Here",
      "vote_average": 6.818,
      "vote_count": 11,
      "air_date": "2024-06-13",
      "episode_number": 3,
      "episode_type": "standard",
      "production_code": "THBY 403",
      "runtime": 61,
      "season_number": 4,
      "show_id": 76479,
      "still_path": "/kcHBZHSYyj0eYSDzCUTze11c5RX.jpg"
    },
    "name": "The Boys",
    "next_episode_to_air": {
      "id": 4781987,
      "overview": "",
      "name": "Wisdom of the Ages",
      "vote_average": 10,
      "vote_count": 2,
      "air_date": "2024-06-20",
      "episode_number": 4,
      "episode_type": "standard",
      "production_code": "",
      "runtime": null,
      "season_number": 4,
      "show_id": 76479,
      "still_path": "/sXbp0dNjOrxQOPQG2NLGSJoUuJ9.jpg"
    },
    "networks": [
      {
        "id": 1024,
        "logo_path": "/ifhbNuuVnlwYy5oXA5VIb2YR8AZ.png",
        "name": "Prime Video",
        "origin_country": ""
      }
    ],
    "number_of_episodes": 32,
    "number_of_seasons": 5,
    "origin_country": [
      "US"
    ],
    "original_language": "en",
    "original_name": "The Boys",
    "overview": "A group of vigilantes known informally as \"The Boys\" set out to take down corrupt superheroes with no more than blue-collar grit and a willingness to fight dirty.",
    "popularity": 2783.39,
    "poster_path": "/2zmTngn1tYC1AvfnrFLhxeD82hz.jpg",
    "production_companies": [
      {
        "id": 20580,
        "logo_path": "/oRR9EXVoKP9szDkVKlze5HVJS7g.png",
        "name": "Amazon Studios",
        "origin_country": "US"
      }
    ],
    "production_countries": [
      {
        "iso_3166_1": "US",
        "name": "United States of America"
      }
    ],
    "seasons": [
      {
        "air_date": "2020-09-10",
        "episode_count": 46,
        "id": 163277,
        "name": "Specials",
        "overview": "",
        "poster_path": "/cCXG81dSCPXcqYm6gTHlwtXocti.jpg",
        "season_number": 0,
        "vote_average": 0
      }
    ],
    "spoken_languages": [
      {
        "english_name": "English",
        "iso_639_1": "en",
        "name": "English"
      }
    ],
    "status": "Returning Series",
    "tagline": "Never meet your heroes.",
    "type": "Scripted",
    "vote_average": 8.473,
    "vote_count": 9574
  };

  test('return model from json', () {
    final actual = TvDetailResponse.fromJson(json.decode(tDetailJson));
    expect(actual, tDetailModel);
  });

  test('return json from model', () {
    final actual = tDetailModel.toJson();
    expect(actual, tDetailMap);
  });

  test('return entity from model', () {
    final actual = tDetailModel.toEntity();
    expect(actual, tDetail);
  });
}