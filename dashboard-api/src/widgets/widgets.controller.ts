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
import { ApiBearerAuth, ApiBody, ApiOperation } from '@nestjs/swagger';
import { NewWidgetEntity } from './entities/newWidget.entity';
import { Widget } from '@prisma/client';
import { WeatherService } from './weather/weather.service';

@Controller('widgets')
export class WidgetsController {
  constructor(
    private readonly widgetsService: WidgetsService,
    private readonly weatherService: WeatherService,
  ) {}

  widgets: Map<string, Function> = new Map<string, Function>([
    ['WEATHER_TEMP', this.weatherService.getWeatherInfos],
  ]);

  @Get('')
  @ApiOperation({ summary: 'Get all widgets' })
  getAll(): void {}

  @Get(':serviceId')
  @ApiOperation({ summary: 'Get widgets by serviceId' })
  getByService(): void {}

  @Post('')
  @ApiBody({ type: NewWidgetEntity })
  @ApiOperation({ summary: 'Create a new widget' })
  async newWidget(
    @Body() newWidget: NewWidgetEntity,
    @Headers('User') userId: string,
  ): Promise<Widget> {
    return this.widgetsService
      .create({
        userId: userId,
        description: newWidget.description,
        data: newWidget.data,
      })
      .then(async (value: Widget) => {
        const widgetFunction: Function | undefined = this.widgets.get(
          value.description,
        );
        if (widgetFunction == undefined) {
          throw new BadRequestException();
        }
        return widgetFunction(value.data);
      })
      .catch((reason: any) => {
        if (reason.code === 'P2003')
          throw new ConflictException(userId + " don't exist !");
        throw new BadRequestException();
      });
  }
}
