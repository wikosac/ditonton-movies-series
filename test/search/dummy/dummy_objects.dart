import 'package:ditonton/search/data/models/search_response.dart';
import 'package:ditonton/search/domain/entities/search.dart';

final testSearchModel = SearchResponse(
  page: 1,
  results: [
    Result(
      backdropPath: "/yF1eOkaYvwiORauRCPWznV9xVvi.jpg",
      id: 298618,
      originalTitle: "The Flash",
      overview:
          "When his attempt to save his family inadvertently alters the future, Barry Allen becomes trapped in a reality in which General Zod has returned and there are no Super Heroes to turn to. In order to save the world that he is in and return to the future that he knows, Barry's only hope is to race for his life. But will making the ultimate sacrifice be enough to reset the universe?",
      posterPath: "/rktDFPbfHfUbArZ6OOOKsXcv0Bm.jpg",
      mediaType: MediaType.MOVIE,
      adult: false,
      title: "The Flash",
      originalLanguage: "en",
      genreIds: [28, 12, 878],
      popularity: 263.463,
      releaseDate: "2023-06-13",
      video: false,
      voteAverage: 6.73,
      voteCount: 3956,
    ),
  ],
  totalPages: 11,
  totalResults: 207,
);

final testSearchEntity = Search(id: 298618);
