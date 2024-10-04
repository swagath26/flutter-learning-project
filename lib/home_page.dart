import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_page.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieCard extends StatelessWidget {
  final String movieName;
  final String genre;
  final String director;
  final String actors;
  final String releaseDate;
  final String language;
  final String runTime;
  final int views;
  final int votes;
  final String posterUrl;

  MovieCard({
    required this.movieName,
    required this.genre,
    required this.director,
    required this.actors,
    required this.releaseDate,
    required this.language,
    required this.runTime,
    required this.views,
    required this.votes,
    required this.posterUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_drop_up, size: 50),
                          // const SizedBox(height: 10),
                          Text(
                            votes.toString(),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          // const SizedBox(height: 10),
                          Icon(Icons.arrow_drop_down, size: 50),
                          // const SizedBox(height: 10),
                          Text(
                            'Votes',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xFF4A4A4A),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 70,
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: Offset(3, 3),
                            blurRadius: 3,
                            spreadRadius: 1,
                          ),
                        ],
                        color: Colors.grey,
                        image: posterUrl.isNotEmpty
                            ? DecorationImage(
                                image: NetworkImage(posterUrl),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            movieName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.playfairDisplay(
                              color: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 3),
                          
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Genre: ',
                                  style: TextStyle(
                                    color: Color(0xFF4A4A4A),
                                    fontSize: 12,
                                  ),
                                ),
                                TextSpan(
                                  text: genre,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 3),

                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Director: ',
                                  style: TextStyle(
                                    color: Color(0xFF4A4A4A),
                                    fontSize: 12,
                                  ),
                                ),
                                TextSpan(
                                  text: director,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 3),

                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Starring: ',
                                  style: TextStyle(
                                    color: Color(0xFF4A4A4A),
                                    fontSize: 12,
                                  ),
                                ),
                                TextSpan(
                                  text: actors,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 3),

                          Text(
                            '$runTime Mins | $language | $releaseDate',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 3),

                          Text(
                            '$views views | Voted by $votes people',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Color(0xFF20A6B5),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color.fromARGB(255, 56, 140, 230)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Watch Trailer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _movies = [];
  bool _isLoading = false;

  Future<void> _fetchMovies() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.parse('https://hoblist.com/api/movieList'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'category': 'movies',
        'language': 'kannada',
        'genre': 'all',
        'sort': 'voting',
      }),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        _movies = data['result'];
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies List'),
        actions: [
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'company_info') {
              _showCompanyInfo(context);
            } else if (value == 'logout') {
              _logout(context);
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                value: 'company_info',
                child: Text('Company Info'),
              ),
              PopupMenuItem(
                value: 'logout',
                child: Text('Logout'),
              ),
            ];
          },
        ),
      ],
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : _movies.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: Text(
                        'Click to display Kannada movies in all genres!',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _fetchMovies,
                        child: Text('Load Movies'),
                      ),
                      const SizedBox(height: 40),
                    ],
                  )
                : ListView.builder(
                itemCount: _movies.length,
                itemBuilder: (context, index) {
                  var movie = _movies[index];

                  String movieName = movie['title'] ?? 'No title';
                  String genre = movie['genre'] ?? 'Unknown';
                  String director = movie['director'] != null && movie['director'].isNotEmpty
                      ? movie['director'][0]
                      : 'Unknown';
                  String actors = movie['stars'] != null && movie['stars'].isNotEmpty
                      ? movie['stars'].join(', ')
                      : 'Unknown';
                  String releaseDate = movie['releasedDate'] != null
                      ? DateTime.fromMillisecondsSinceEpoch(movie['releasedDate'] * 1000)
                          .toLocal()
                          .toString()
                          .split(' ')[0]
                      : 'Unknown';
                  String language = movie['language'] ?? 'Unknown';
                  String runTime = (movie['runTime'] ?? '').toString();
                  int views = movie['pageViews'] ?? 0;
                  int votes = movie['voting'] ?? 0;
                  String posterUrl = movie['poster'] ?? '';

                  return MovieCard(
                    movieName: movieName,
                    genre: genre,
                    director: director,
                    actors: actors,
                    releaseDate: releaseDate,
                    language: language,
                    views: views,
                    votes: votes,
                    posterUrl: posterUrl,
                    runTime: runTime,
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchMovies,
        child: Icon(Icons.refresh),
      ),
    );
  }

  void _logout(BuildContext context) {
  // Clear stored login info here if necessary (like using shared_preferences)

  // Navigate back to the login screen
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()), // Replace with your login screen
    (Route<dynamic> route) => false, // Removes all previous routes
  );
  }

  void _showCompanyInfo(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Company Info'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Company: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: 'Geeksynergy Technologies Pvt Ltd',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Address: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: 'Sanjayanagar, Bengaluru-56',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Phone: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: 'XXXXXXXXX09',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Email: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: 'XXXXXX@gmail.com',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
}