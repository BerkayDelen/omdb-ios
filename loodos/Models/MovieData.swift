
import Foundation
struct MovieData : Codable {
	var title : String?
	var year : String?
	var rated : String?
	var released : String?
	var runtime : String?
	var genre : String?
	var director : String?
	var writer : String?
	var actors : String?
	var plot : String?
	var language : String?
	var country : String?
	var awards : String?
	var poster : String?
	var ratings : [Ratings]?
	var metascore : String?
	var imdbRating : String?
	var imdbVotes : String?
	var imdbID : String?
	var type : String?
	var dVD : String?
	var boxOffice : String?
	var production : String?
	var website : String?
	var response : String?

	enum CodingKeys: String, CodingKey {

		case title = "Title"
		case year = "Year"
		case rated = "Rated"
		case released = "Released"
		case runtime = "Runtime"
		case genre = "Genre"
		case director = "Director"
		case writer = "Writer"
		case actors = "Actors"
		case plot = "Plot"
		case language = "Language"
		case country = "Country"
		case awards = "Awards"
		case poster = "Poster"
		case ratings = "Ratings"
		case metascore = "Metascore"
		case imdbRating = "imdbRating"
		case imdbVotes = "imdbVotes"
		case imdbID = "imdbID"
		case type = "Type"
		case dVD = "DVD"
		case boxOffice = "BoxOffice"
		case production = "Production"
		case website = "Website"
		case response = "Response"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		year = try values.decodeIfPresent(String.self, forKey: .year)
		rated = try values.decodeIfPresent(String.self, forKey: .rated)
		released = try values.decodeIfPresent(String.self, forKey: .released)
		runtime = try values.decodeIfPresent(String.self, forKey: .runtime)
		genre = try values.decodeIfPresent(String.self, forKey: .genre)
		director = try values.decodeIfPresent(String.self, forKey: .director)
		writer = try values.decodeIfPresent(String.self, forKey: .writer)
		actors = try values.decodeIfPresent(String.self, forKey: .actors)
		plot = try values.decodeIfPresent(String.self, forKey: .plot)
		language = try values.decodeIfPresent(String.self, forKey: .language)
		country = try values.decodeIfPresent(String.self, forKey: .country)
		awards = try values.decodeIfPresent(String.self, forKey: .awards)
		poster = try values.decodeIfPresent(String.self, forKey: .poster)
		ratings = try values.decodeIfPresent([Ratings].self, forKey: .ratings)
		metascore = try values.decodeIfPresent(String.self, forKey: .metascore)
		imdbRating = try values.decodeIfPresent(String.self, forKey: .imdbRating)
		imdbVotes = try values.decodeIfPresent(String.self, forKey: .imdbVotes)
		imdbID = try values.decodeIfPresent(String.self, forKey: .imdbID)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		dVD = try values.decodeIfPresent(String.self, forKey: .dVD)
		boxOffice = try values.decodeIfPresent(String.self, forKey: .boxOffice)
		production = try values.decodeIfPresent(String.self, forKey: .production)
		website = try values.decodeIfPresent(String.self, forKey: .website)
		response = try values.decodeIfPresent(String.self, forKey: .response)
	}
    internal init() {
       
    }

    internal init(title: String?, year: String?, rated: String?, released: String?, runtime: String?, genre: String?, director: String?, writer: String?, actors: String?, plot: String?, language: String?, country: String?, awards: String?, poster: String?, ratings: [Ratings]?, metascore: String?, imdbRating: String?, imdbVotes: String?, imdbID: String?, type: String?, dVD: String?, boxOffice: String?, production: String?, website: String?, response: String?) {
        self.title = title
        self.year = year
        self.rated = rated
        self.released = released
        self.runtime = runtime
        self.genre = genre
        self.director = director
        self.writer = writer
        self.actors = actors
        self.plot = plot
        self.language = language
        self.country = country
        self.awards = awards
        self.poster = poster
        self.ratings = ratings
        self.metascore = metascore
        self.imdbRating = imdbRating
        self.imdbVotes = imdbVotes
        self.imdbID = imdbID
        self.type = type
        self.dVD = dVD
        self.boxOffice = boxOffice
        self.production = production
        self.website = website
        self.response = response
    }

}
