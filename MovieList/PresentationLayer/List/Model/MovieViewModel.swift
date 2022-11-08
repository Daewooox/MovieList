import Foundation

struct MovieViewModel: Hashable {
    let id: Int
    let title: String
    let genres: String
    let rate: Double
    let overview: String
    let posterImagePath: String?
    var cast: String?
    
    init(id: Int, title: String, genres: String, rate: Double, overview: String, posterImagePath: String?, cast: String?) {
        self.id = id
        self.title = title
        self.genres = genres
        self.rate = rate
        self.overview = overview
        self.posterImagePath = posterImagePath
        self.cast = cast
    }
    
    init(movie: MovieModel, genres: [GenreModel]) {
        id = movie.id
        title = movie.title
        self.genres = genres.filter { movie.genreIds.contains($0.id) }
            .map { $0.name.uppercased() }
            .joined(separator: ", ")
        rate = movie.voteAverage
        overview = movie.overview
        if let posterPath = movie.posterPath {
            posterImagePath = APIUrl.imageUrl.apiUrl.absoluteString + posterPath
        } else {
            posterImagePath = movie.posterPath
        }
    }

}
