import {
  BadRequestException,
  Body,
  ConflictException,
  Controller,
  NotFoundException,
  Post,
  UnauthorizedException,
} from '@nestjs/common';
import { ApiBody, ApiOperation, ApiTags } from '@nestjs/swagger';
import { User } from '@prisma/client';
import { UsersService } from '@src/users/users.service';
import { LoginEntity } from './entities/login.entity';
import { RegisterEntity } from './entities/register.entity';

@Controller('auth')
@ApiTags('authentification')
export class AuthentificationController {
  constructor(private readonly usersService: UsersService) {}

  @Post('login')
  @ApiOperation({ summary: 'Login user' })
  @ApiBody({ type: LoginEntity })
  async login(@Body() login: LoginEntity): Promise<User> {
    return this.usersService
      .getUserByEmail({
        email: login.email,
        password: login.password,
      })
      .then((value: User) => {
        if (login.password === value.password) {
          console.log("[LOG]  Login | Successful");
          return value;
        }
        throw new UnauthorizedException('Bad password');
      })
      .catch((reason: any) => {
        console.log("[LOG]  Login | Something Bad");
        if (reason.code === 'P2025') {
          throw new NotFoundException(
            `User with email ${login.email} not found`,
          );
        }
        if (reason.status) {
          throw reason;
        }
        throw new BadRequestException(reason.message);
      });
  }

  @Post('register')
  @ApiOperation({ summary: 'Register user' })
  @ApiBody({ type: RegisterEntity })
  async register(@Body() register: RegisterEntity): Promise<User> {
    return this.usersService
      .create({
        email: register.email,
        password: register.password,
      })
      .then((value: User) => {
        console.log("[LOG]  Register | Successful");
        return value;
      })
      .catch((reason: any) => {
        console.log("[LOG]  Register | Something Bad");
        if (reason.code === 'P2002') {
          throw new ConflictException(
            `User with email ${register.email} already exists`,
          );
        }
        throw new BadRequestException(reason.message);
      });
  }
}
