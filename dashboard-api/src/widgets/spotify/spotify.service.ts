import { BadRequestException, Injectable, UnauthorizedException } from '@nestjs/common';
import { ServicesService } from '@src/services/services.service';
import { SpotifyLastSongResponse, SpotifyMostListenArtistResponse } from './response.entity';
import { Service } from '@prisma/client';
import { SpotifyEntity } from '@src/authentification/entities/spotify.entity';
import axios, { AxiosResponse } from 'axios';

@Injectable()
export class SpotifyService {
  constructor(private readonly service: ServicesService) { }

  async getLastPlayedTrack(
    userId: string,
    data: any,
  ): Promise<SpotifyLastSongResponse> {
    return this.service.serviceByUserId(userId).then(async (service: Service) => {
      return axios.get(SpotifyEntity.lastPlayedTrackUrl, {
        headers: {
          Accept: 'application/json',
          'Content-Type': 'application/json',
          Authorization: 'Bearer ' + service.accessToken,
        }
      }).then((value: AxiosResponse) => {
        const lastSong: any = value.data.items[0].track;
        return {
          description: 'SPOTIFY_LAST_PLAYED_TRACK',
          artist: lastSong.artists[0].name,
          single: lastSong.name,
          album: lastSong.album.name,
          icon: lastSong.album.images[1].url,
        };
      }).catch((reason: any) => {
        console.log(reason);
        throw reason;
      })
    }).catch((reason: any) => {
      console.log("You should authenticate with spotify first");
      throw new UnauthorizedException;
    });
  }

  async getMostListenArtist(
    userId: string,
    data: any,
  ): Promise<SpotifyMostListenArtistResponse> {
    if (data.timeRange == undefined) {
      throw new BadRequestException();
    }
    return this.service.serviceByUserId(userId).then(async (service: Service) => {
      return axios.get(SpotifyEntity.mostListenArtistUrl + data.timeRange, {
        headers: {
          Accept: 'application/json',
          'Content-Type': 'application/json',
          Authorization: 'Bearer ' + service.accessToken,
        }
      }).then((value: AxiosResponse) => {
        const lastSong: any = value.data.items[0];
        return {
          description: 'SPOTIFY_MOST_LISTEN_ARTIST_TRACK',
          artist: lastSong.name,
          icon: lastSong.images[1].url,
        };
      }).catch((reason: any) => {
        console.log(reason);
        throw reason;
      })
    }).catch((reason: any) => {
      console.log("You should authenticate with spotify first");
      throw new UnauthorizedException;
    });
  }
}
