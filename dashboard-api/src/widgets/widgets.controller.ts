import {
  BadRequestException,
  Body,
  ConflictException,
  Controller,
  Get,
  Headers,
  Post,
} from '@nestjs/common';
import { WidgetsService } from './widgets.service';
import { ApiBody, ApiOperation } from '@nestjs/swagger';
import { NewWidgetEntity } from './entities/newWidget.entity';
import { Widget, WidgetName } from '@prisma/client';
import { WeatherService } from './weather/weather.service';
import { SpotifyService } from './spotify/spotify.service';

@Controller('widgets')
export class WidgetsController {
  constructor(
    private readonly widgetsService: WidgetsService,
    private readonly weather: WeatherService,
    private readonly spotify: SpotifyService,
    private readonly widgets: Map<string, Function>
  ) {
  }

  @Get('')
  @ApiOperation({ summary: 'Get all widgets' })
  getAll(): void { }

  @Get(':serviceId')
  @ApiOperation({ summary: 'Get widgets by serviceId' })
  getByService(): void { }

  @Post('')
  @ApiBody({ type: NewWidgetEntity })
  @ApiOperation({ summary: 'Create a new widget' })
  async newWidget(
    @Body() newWidget: NewWidgetEntity,
    @Headers('User') userId: string,
  ): Promise<any> {
    return this.widgetsService
      .create({
        userId: userId,
        description: newWidget.description,
        data: newWidget.data,
      })
      .then(async (value: Widget) => {
        if (value.description === WidgetName.WEATHER_TEMP)
          return this.weather.getWeatherInfos(userId, value.data);
        else if (value.description === WidgetName.SPOTIFY_LAST_PLAYED_TRACK)
          return this.spotify.getLastPlayedTrack(userId, value.data);
        else
          throw new BadRequestException;
      })
      .catch((reason: any) => {
        if (reason.code === 'P2003')
          throw new ConflictException(userId + " don't exist !");
        throw new BadRequestException();
      });
  }
}
