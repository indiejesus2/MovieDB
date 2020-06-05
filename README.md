MovieDB CLI

The CLI provides basic interaction with TheMovieDatabase (TMDB) that will allow users to look up plots and cast information for a selected movie. The MoviesDB CLI also offers similar movies and recommendations based on the movie.

Installation

$ gem install MovieDB

The CLI will first greet the user, and it will ask for a movie title. Specific movie titles will yield better results, keywords are viable alternatives as well.

After the user inputs a movie title or keyword, a list of 20 movie titles will be returned in numbered order followed by the year the film was released. The list is ordered by popularity of film. he user will then be prompted to select a movie by it's index number.

THe user will then be given options to apply to their selected movie. The options are "plot", "cast & crew", "similar movies", and "recommendations". The movie the user selected will also be included with the menu options to confirm that the correct title was chosen.

Plot

If plot is selected, the gem will provide a basic synopsis of the movie provided by TMDB.

Cast & Crew

If the user would like an abridged version of the movie credits, cast & crew provide credits for the film's Director and Writing department, followed by a list of 20 of the top billed actors and the characters they played.

Similar Movies & Recommendations

A couple neat features included with TMDB is similar movies and recommendations based on a movie. While they both seem very much alike at first, similar movies are more comprised of sequals and recommendations are based on a film's multiple genres like romance and comedy or fantasy and sci-fi.

If similar movies or recommendations are chosen, the program will print five movie titles along with the year it was released. It will also provide a brief plot synopsis.

Exit

The CLI is built to repeat this process until the user types exit.

