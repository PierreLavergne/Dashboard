import { Module } from '@nestjs/common';
import { WidgetsService } from './widgets.service';
import { WidgetsController } from './widgets.controller';
import { PrismaModule } from '@src/prisma/prisma.module';
import { WeatherModule } from './weather/weather.module';

@Module({
  imports: [PrismaModule, WeatherModule],
  providers: [WidgetsService],
  controllers: [WidgetsController],
})
export class WidgetsModule {}
