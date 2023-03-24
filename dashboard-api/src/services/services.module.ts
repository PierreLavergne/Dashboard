import { Module } from '@nestjs/common';
import { ServicesService } from './services.service';
import { PrismaModule } from '@src/prisma/prisma.module';

@Module({
  imports: [PrismaModule],
  providers: [ServicesService],
  exports: [ServicesService],
})
export class ServicesModule {}
