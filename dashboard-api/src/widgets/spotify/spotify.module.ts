import { Module } from '@nestjs/common';
import { SpotifyService } from './spotify.service';
import { ServicesService } from '@src/services/services.service';
import { PrismaService } from '@src/prisma/prisma.service';

@Module({
  providers: [SpotifyService, ServicesService, PrismaService],
})
export class SpotifyModule {}

/*
  async getLastPlayedTrack(userId: string, data: any): Promise<void> {
    console.log(`[LOG]  Spotify | Create Spotify widget for ${userId}`);

    try {
      this.service.service
        .findUniqueOrThrow({
          where: { userId: userId },
        })
        .then((service: Service) => {
          console.log(service);
        });
    } catch (e: any) {
      console.log('Error :', e);
    }
  }
}

// const ezdze: Service = await this.servicesService.serviceByUserId(userId);

// .then(async (service: Service) => {
//   console.log('[LOG]  Spotify | Bearer token available');
//   return axios
//     .get(SpotifyEntity.lastPlayedTrackUrl, {
//       headers: {
//         Accept: 'application/json',
//         'Content-Type': 'application/json',
//         Authorization: 'Bearer ' + service.accessToken,
//       },
//     })
//     .then((value: AxiosResponse) => {
//       const lastSong: any = value.data.item[0];
//       const response: SpotifyResponse = {
//         description: 'SPOTIFY_LAST_PLAYED_TRACK',
//         artistName: lastSong.track.artists[0].name,
//         singleName: lastSong.track.name,
//         albumName: lastSong.track.album[0],
//         icon: lastSong.track.name,
//       };
//       console.log(response);
//       return response;
//     });
// }).catch((reason: any) => {
//   console.log("You should authenticate with spotify first");
//   console.log(reason);
//   throw reason;
// });*/
