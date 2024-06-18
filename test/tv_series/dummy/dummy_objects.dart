import 'package:ditonton/tv_series/data/models/tv_detail_response.dart';
import 'package:ditonton/tv_series/data/models/tv_response.dart';
import 'package:ditonton/tv_series/data/models/tv_season_response.dart';
import 'package:ditonton/tv_series/domain/entities/episode.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series_detail.dart';

final dummyTvResponse = TvResponse(
  page: 1,
  results: [
    Result(
      adult: false,
      backdropPath: "/7cqKGQMnNabzOpi7qaIgZvQ7NGV.jpg",
      genreIds: [10765, 10759],
      id: 76479,
      originCountry: ["US"],
      originalLanguage: "en",
      originalName: "The Boys",
      overview:
          "A group of vigilantes known informally as \"The Boys\" set out to take down corrupt superheroes with no more than blue-collar grit and a willingness to fight dirty.",
      popularity: 2783.39,
      posterPath: "/2zmTngn1tYC1AvfnrFLhxeD82hz.jpg",
      firstAirDate: "2019-07-25",
      name: "The Boys",
      voteAverage: 8.473,
      voteCount: 9575,
    ),
  ],
  totalPages: 45,
  totalResults: 893,
);

final dummyTvDetailResponse = TvDetailResponse(
  adult: false,
  backdropPath: "/7cqKGQMnNabzOpi7qaIgZvQ7NGV.jpg",
  createdBy: [
    CreatedBy(
      id: 58321,
      creditId: "5f3814c011c066003637f6a8",
      name: "Eric Kripke",
      originalName: "Eric Kripke",
      gender: 2,
      profilePath: "/dd7EgfOEKPqQxWtBfAvjYZahbSc.jpg",
    ),
  ],
  episodeRunTime: [60],
  firstAirDate: "2019-07-25",
  genres: [
    Genre(id: 10765, name: "Sci-Fi & Fantasy"),
  ],
  homepage: "https://www.amazon.com/dp/B0875L45GK",
  id: 76479,
  inProduction: true,
  languages: ["en"],
  lastAirDate: "2024-06-13",
  lastEpisodeToAir: LastEpisodeToAir(
    id: 4781986,
    overview:
        "This December at VoughtCoin Arena, experience the story of Christmas the way it was meant to be told... on ice! Vought Presents Vought on Ice! Tickets available now at VoughtOnIce.com!",
    name: "We'll Keep the Red Flag Flying Here",
    voteAverage: 6.818,
    voteCount: 11,
    airDate: "2024-06-13",
    episodeNumber: 3,
    episodeType: "standard",
    productionCode: "THBY 403",
    runtime: 61,
    seasonNumber: 4,
    showId: 76479,
    stillPath: "/kcHBZHSYyj0eYSDzCUTze11c5RX.jpg",
  ),
  name: "The Boys",
  nextEpisodeToAir: LastEpisodeToAir(
    id: 4781987,
    overview: "",
    name: "Wisdom of the Ages",
    voteAverage: 10,
    voteCount: 2,
    airDate: "2024-06-20",
    episodeNumber: 4,
    episodeType: "standard",
    productionCode: "",
    runtime: null,
    seasonNumber: 4,
    showId: 76479,
    stillPath: "/sXbp0dNjOrxQOPQG2NLGSJoUuJ9.jpg",
  ),
  networks: [
    Network(
      id: 1024,
      logoPath: "/ifhbNuuVnlwYy5oXA5VIb2YR8AZ.png",
      name: "Prime Video",
      originCountry: "",
    ),
  ],
  numberOfEpisodes: 32,
  numberOfSeasons: 5,
  originCountry: ["US"],
  originalLanguage: "en",
  originalName: "The Boys",
  overview:
      "A group of vigilantes known informally as \"The Boys\" set out to take down corrupt superheroes with no more than blue-collar grit and a willingness to fight dirty.",
  popularity: 2783.39,
  posterPath: "/2zmTngn1tYC1AvfnrFLhxeD82hz.jpg",
  productionCompanies: [
    Network(
      id: 20580,
      logoPath: "/oRR9EXVoKP9szDkVKlze5HVJS7g.png",
      name: "Amazon Studios",
      originCountry: "US",
    ),
  ],
  productionCountries: [
    ProductionCountry(iso31661: "US", name: "United States of America"),
  ],
  seasons: [
    Season(
      airDate: "2020-09-10",
      episodeCount: 46,
      id: 163277,
      name: "Specials",
      overview: "",
      posterPath: "/cCXG81dSCPXcqYm6gTHlwtXocti.jpg",
      seasonNumber: 0,
      voteAverage: 0,
    ),
  ],
  spokenLanguages: [
    SpokenLanguage(englishName: "English", iso6391: "en", name: "English"),
  ],
  status: "Returning Series",
  tagline: "Never meet your heroes.",
  type: "Scripted",
  voteAverage: 8.473,
  voteCount: 9574,
);

final dummySeasonResponse = SeasonResponse(
  id: "5f647491dbcade003718225d",
  airDate: "2020-09-10",
  episodes: [
    EpisodeModel(
      airDate: "2020-09-10",
      episodeNumber: 1,
      episodeType: "standard",
      id: 2431460,
      name: "Butcher: A Short Film",
      overview:
          "Butcher relives the past, recalling violence and betrayal on the rough road towards finding his wife Becca.",
      productionCode: "",
      runtime: 5,
      seasonNumber: 0,
      showId: 76479,
      stillPath: "/rWlnk1kYlHtjg75diQLrnY7P9t1.jpg",
      voteAverage: 6.8,
      voteCount: 4,
      crew: [],
      guestStars: [],
    ),
  ],
  name: "Specials",
  overview: "",
  seasonResponseId: 163277,
  posterPath: "/cCXG81dSCPXcqYm6gTHlwtXocti.jpg",
  seasonNumber: 0,
  voteAverage: 0,
);

final dummyTvSeries = TvSeries(
  id: 76479,
  posterPath: '/2zmTngn1tYC1AvfnrFLhxeD82hz.jpg',
);

final dummyTvSeriesDetail = TvSeriesDetail(
  id: 76479,
  title: "The Boys",
  year: "2019-07-25",
  seasonCount: 1,
  lang: ["en"],
  posterPath: "/2zmTngn1tYC1AvfnrFLhxeD82hz.jpg",
  genres: ["Sci-Fi & Fantasy"],
  overview:
      "A group of vigilantes known informally as \"The Boys\" set out to take down corrupt superheroes with no more than blue-collar grit and a willingness to fight dirty.",
  seasons: [SeasonEntity(id: 163277, name: "Specials", seasonNumber: 0)],
  rating: 8.473,
);

final dummyEpisode = Episode(
  id: 2431460,
  stillPath: "/cCXG81dSCPXcqYm6gTHlwtXocti.jpg",
  title: "Butcher: A Short Film",
  airDate: "2020-09-10",
  seasonNumber: 0,
  episodeNumber: 1,
  runtime: 5,
);
