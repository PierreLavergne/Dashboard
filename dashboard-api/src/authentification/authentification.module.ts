import { Module } from '@nestjs/common';
import { PrismaModule } from '@src/prisma/prisma.module';
import { UsersService } from '@src/users/users.service';
import { AuthentificationController } from './authentification.controller';

@Module({
  imports: [PrismaModule],
  providers: [UsersService],
  controllers: [AuthentificationController],
})
export class AuthentificationModule {}
