import { Module } from '@nestjs/common';
import { WidgetsService } from './widgets.service';
import { WidgetsController } from './widgets.controller';
import { PrismaModule } from '@src/prisma/prisma.module';
import { WeatherModule } from './weather/weather.module';
import { WeatherService } from './weather/weather.service';
import { SpotifyModule } from './spotify/spotify.module';
import { SpotifyService } from './spotify/spotify.service';
import { ServicesService } from '@src/services/services.service';
import { FootballModule } from './football/football.module';
import { FootballService } from './football/football.service';

@Module({
  imports: [PrismaModule, WeatherModule, SpotifyModule, FootballModule],
  providers: [
    WidgetsService,
    WeatherService,
    SpotifyService,
    ServicesService,
    FootballService
  ],
  controllers: [WidgetsController],
})
export class WidgetsModule {}
