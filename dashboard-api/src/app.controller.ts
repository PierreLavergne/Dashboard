import { Controller, Get, Req } from '@nestjs/common';
import { AppService } from './app.service';
import { Request } from 'express';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get('health')
  health(@Req() request: Request): string {
    console.log(request.cookies);
    return this.appService.health();
  }
}
