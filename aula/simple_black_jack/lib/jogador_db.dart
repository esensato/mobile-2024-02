class JogadorDB {

  var username;

  JogadorDB({this.username = ''});

  // {username: 'teste123'} -> INSERT INTO TAB_JOGADOR (username) VALUES ('teste123')
  Map<String, dynamic> toMap() {

    return {'username': username};

  }

}