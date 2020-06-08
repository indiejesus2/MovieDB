# MoviesCLI

## Summary

The CLI provides basic interaction with TheMovieDatabase (TMDB) that will allow users to look up plots and cast information for a selected movie. The MoviesDB CLI also offers similar movies and recommendations based on the movie.

## Usage

Type in bin/run and follow the proceeding prompts.

The CLI will first greet the user, and it will ask for a movie title. Specific movie titles will yield better results, keywords are viable alternatives as well.

After the user inputs a movie title or keyword, a list of 20 movie titles will be returned in numbered order followed by the year the film was released. The list is ordered by popularity of film. the user will then be prompted to select a movie by it's index number.

The user will then be given options to apply to their selected movie. The options are "plot", "cast & crew", "similar movies", and "recommendations". The movie the user selected will also be included with the menu options to confirm that the correct title was chosen.

### Plot

If plot is selected, the gem will provide a basic synopsis of the movie provided by TMDB.

### Cast & Crew

If the user would like an abridged version of the movie credits, cast & crew provide credits for the film's Director and Writing department, followed by a list of 20 of the top billed actors and the characters they played.

### Similar Movies & Recommendations

A couple neat features included with TMDB is similar movies and recommendations based on a movie. While they both seem very much alike at first, similar movies are based on a film's multiple genres like romance and comedy or fantasy and sci-fi, and recommendations are more comprised of sequels or similar film types such as animation or .

If similar movies or recommendations are chosen, the program will print five movie titles along with the year it was released. It will also provide a brief plot synopsis.

### Exit

The CLI is built to repeat this process until the user types exit.

## Contributing

Pull requests are encouraged on [GitHub](https://github.com/indiejesus2/MovieDB) as well as any bug reports. This project is intended to be a safe, welcoming space for colloration, and contributors are expected to adhere to the Contributor Covenant Code of Conduct.

## License

This gem is an open source under the terms of the [MIT License](https://github.com/indiejesus2/MovieDB/blob/master/LICENSE).
