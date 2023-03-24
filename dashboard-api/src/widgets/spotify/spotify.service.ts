import { Injectable } from '@nestjs/common';
import { PrismaService } from '@src/prisma/prisma.service';
import { ServicesService } from '@src/services/services.service';
import { SpotifyResponse } from './response.entity';

@Injectable()
export class SpotifyService {
  constructor(private readonly service: ServicesService) {}

  async getLastPlayedTrack(userId: string, data: any): Promise<SpotifyResponse> {
    console.log('Hello');
    try {
      console.log('Mid ', this.service.hello());
    } catch (e: any) {
      console.log(e);
    }
    console.log('Bye');
    return new SpotifyResponse;
  }
}
