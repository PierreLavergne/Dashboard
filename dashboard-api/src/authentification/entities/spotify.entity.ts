export class SpotifyEntity {
  static clientId: string = 'bf6c99959ff840c5b91762ed765b056c';
  static secretId: string = '3a3a2c7d82664cef864b1cd07cebc37b';
  static responseType: string = 'code';
  static redirectUri: string = 'http://127.0.0.1:3000/auth/spotify/callback';
  static scopes: string = 'user-read-recently-played user-read-email user-top-read';

  static baseUrl: string = 'https://accounts.spotify.com/';
  static paramsOauth2: string = `authorize?client_id=${this.clientId}&response_type=${this.responseType}&redirect_uri=${this.redirectUri}&scope=${this.scopes}`;
  static paramsToken: string = `api/token`;
  static userInfosUrl: string = 'https://api.spotify.com/v1/me';
  static lastPlayedTrackUrl: string =
    'https://api.spotify.com/v1/me/player/recently-played';
  static mostListenArtistUrl:string = "https://api.spotify.com/v1/me/top/artists?limit=1&time_range=";

  static contentType: string = 'application/x-www-form-urlencoded';

  static urlOauth2(): string {
    return this.baseUrl + this.paramsOauth2;
  }

  static urlToken(): string {
    return this.baseUrl + this.paramsToken;
  }

  static authorizationCode(): string {
    return (
      'Basic ' +
      Buffer.from(this.clientId + ':' + this.secretId).toString('base64')
    );
  }
}

// https://developer.spotify.com/console/get-recently-played/
