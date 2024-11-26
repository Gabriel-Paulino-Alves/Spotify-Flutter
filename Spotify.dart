import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Seção 1
                TitleSection(),
                // Seção 2 
                ArtistGrid(),
                // Seção 3
                NewReleaseSection(),
                // Seção 4
                RecommendedPlaylists(),
                // Adicionando o espaçamento para as plalist aparecerem
                SizedBox(height: 32),  
              ],
            ),
          ),
          // Seção 5 
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Miniplayer(),
          ),
        ],
      ),
      bottomNavigationBar: BottomMenu(),
    );
  }
}

// Seção 1: Título e ícones
class TitleSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black.withOpacity(0.8), Colors.white.withOpacity(0.1)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Boa noite', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Row(
            children: [
              Icon(Icons.notifications, color: Colors.white),
              SizedBox(width: 16),
              Icon(Icons.settings, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }
}

// Seção 2: Grid com artistas 
class ArtistGrid extends StatelessWidget {
  final List<Artist> artists = [
    Artist('Linkin Park', 'https://th.bing.com/th/id/R.0ce320254e13d9565b7d228e0ec2b662?rik=mLrhp7RodnaZjA&riu=http%3a%2f%2fimages1.fanpop.com%2fimages%2fimage_uploads%2fLP-linkin-park-883001_1280_1024.jpg&ehk=bQ3qouAJ8TzF%2fr70TgXWdDSnnnmYBGQfHQEbGSfnSA0%3d&risl=&pid=ImgRaw&r=0'),
    Artist('Avenged Sevenfold', 'https://th.bing.com/th/id/OIP.V2c8GRZiVy8SVBkaqGIytAHaE7?rs=1&pid=ImgDetMain'),
    Artist('Daily Mix 4', 'https://dailymix-images.scdn.co/v2/img/ab6761610000e5eb99002a30df0f32212e0c0de0/4/en/default'),
    Artist('Radar de Novidades', 'https://newjams-images.scdn.co/image/ab6764780000c480/dt/v3/release-radar/ab6761610000e5eb549f46b5602ea5ffeeeb17dd/pt'),
    Artist('Pink Floyd', 'https://th.bing.com/th/id/OIP.Kh_Y4wz7-zwUp7uBxnbZMgHaFj?rs=1&pid=ImgDetMain'),
    Artist('System Of A Down', 'https://th.bing.com/th/id/R.e76253a902cefb22684431b4ba0bfcd6?rik=kG7w1t7F5u1dQg&riu=http%3a%2f%2f2.bp.blogspot.com%2f-Jf1VwL1PCH8%2fUKEXslZgF3I%2fAAAAAAAAAh8%2fB0ec8BWF4ns%2fs1600%2fsystem-of-a-down-8740.jpg&ehk=AhNd2cmsFVBZV%2faaUf7cziMQ1%2fsvWHiYh7TLGLL9jCs%3d&risl=&pid=ImgRaw&r=0'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8, 
          mainAxisSpacing: 8, 
          childAspectRatio: 3.0,
        ),
        itemCount: artists.length,
        itemBuilder: (context, index) {
          return ArtistCard(artist: artists[index]);
        },
      ),
    );
  }
}

// Model de artista para representar os dados de cada card
class Artist {
  final String name;
  final String imageUrl;

  Artist(this.name, this.imageUrl);
}

// Card de artista individual
class ArtistCard extends StatelessWidget {
  final Artist artist;

  const ArtistCard({required this.artist});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              artist.imageUrl,
              fit: BoxFit.cover,
              height: 50, // Imagem ajustada
              width: 50,  // Imagem ajustada
            ),
          ),
          SizedBox(width: 12),
          Text(artist.name, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

// Seção 3: Novo lançamento 
class NewReleaseSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://th.bing.com/th/id/OIP.V2c8GRZiVy8SVBkaqGIytAHaE7?rs=1&pid=ImgDetMain',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Avenged Sevenfold', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('Novo Lançamento', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          AlbumCard(),
        ],
      ),
    );
  }
}

// Card do álbum com a imagem, nome da música, artista, e botões
class AlbumCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Image.network(
            'https://images.kerrangcdn.com/images/Avenged-Sevenfold-Life-Is-But-A-Dream-album-cover-header.png?auto=compress&fit=max&w=3840',
            fit: BoxFit.cover,
            height: 180,
            width: double.infinity,
          ),
          Positioned(
            bottom: 10,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Life Is But a Dream', style: TextStyle(fontSize: 16, color: Colors.white)),
                Text('Álbum • Avenged Sevenfold', style: TextStyle(fontSize: 14, color: Colors.white)),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 16,
            child: Row(
              children: [
                Icon(Icons.favorite_border, color: Colors.white),
                SizedBox(width: 16),
                Icon(Icons.play_arrow, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Seção 4: Playlist recomendadas
class RecommendedPlaylists extends StatelessWidget {
  // Lista de playlists com dados personalizáveis
  final List<Playlist> playlists = [
    Playlist('Rock Covers', 'https://i.scdn.co/image/ab67706f0000000236c5adaed4c71c9b3c75b5ce'),
    Playlist('Rock Classics', 'https://i.scdn.co/image/ab67706f00000003519fc8771d90f496501a4da3'),
    Playlist('80s HardRock', 'https://i.scdn.co/image/ab67706f000000039205ddd6990d57d56db91b81'),
    Playlist('90s Rock Anthems', 'https://th.bing.com/th/id/OIP.F6_VYpnijk8csseLmEUh3gHaHa?rs=1&pid=ImgDetMain'),
    Playlist('Best Rock Songs', 'https://i.scdn.co/image/ab67706c0000da84809144371a80762ea2ade176'),
    Playlist('Best of 2000', 'https://lite-images-i.scdn.co/image/ab67706f00000002fcd71af8bfcaa6be838321aa'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
            height: 200, // A altura da área de playlists
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                return PlaylistCard(playlist: playlists[index]);
              },
            ),
          ),
          SizedBox(height: 50), // Espaço extra abaixo das playlists
        ],
      ),
    );
  }
}

// seção 4 Model de Playlist para representar os dados de cada card
class Playlist {
  final String name;
  final String imageUrl;

  Playlist(this.name, this.imageUrl);
}

// Card de playlist individual
class PlaylistCard extends StatelessWidget {
  final Playlist playlist;

  const PlaylistCard({required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Image.network(
              playlist.imageUrl,
              width: 160,
              height: 120,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 10,
              left: 16,
              child: Text(
                playlist.name,
                style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Seção 5: Miniplayer
class Miniplayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              'https://th.bing.com/th/id/OIP.NBUR13MkYwG07YdHcEMvRAHaHa?rs=1&pid=ImgDetMain',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Papercut', style: TextStyle(fontSize: 14)),
              Text('Linkin Park', style: TextStyle(fontSize: 12)),
            ],
          ),
          Spacer(),
          Icon(Icons.computer, color: Colors.white),
          SizedBox(width: 12),
          Icon(Icons.favorite_border, color: Colors.white),
          SizedBox(width: 12),
          Icon(Icons.play_arrow, color: Colors.white),
        ],
      ),
    );
  }
}

// Menu inferior
class BottomMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.transparent,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
        BottomNavigationBarItem(icon: Icon(Icons.library_music), label: 'Playlists'),
      ],
    );
  }
}
