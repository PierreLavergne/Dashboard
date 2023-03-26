import { Module } from '@nestjs/common';
import { FootballService } from './football.service';

@Module({
  providers: [FootballService]
})
export class FootballModule {}
