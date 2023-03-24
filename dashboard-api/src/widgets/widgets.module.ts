import { Module } from '@nestjs/common';
import { WidgetsService } from './widgets.service';
import { WidgetsController } from './widgets.controller';
import { PrismaModule } from '@src/prisma/prisma.module';
import { WeatherModule } from './weather/weather.module';
import { WeatherService } from './weather/weather.service';
import { SpotifyModule } from './spotify/spotify.module';
import { SpotifyService } from './spotify/spotify.service';
import { ServicesService } from '@src/services/services.service';

@Module({
  imports: [PrismaModule, WeatherModule, SpotifyModule],
  providers: [WidgetsService, WeatherService, SpotifyService, ServicesService, Map],
  controllers: [WidgetsController],
})
export class WidgetsModule {}
