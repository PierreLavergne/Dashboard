import { Module } from '@nestjs/common';
import { PrismaModule } from '@src/prisma/prisma.module';
import { UsersService } from '@src/users/users.service';
import { AuthentificationController } from './authentification.controller';
import { ServicesService } from '@src/services/services.service';

@Module({
  imports: [PrismaModule],
  providers: [UsersService, ServicesService],
  controllers: [AuthentificationController],
})
export class AuthentificationModule {}
