import { Body, ConflictException, Controller, InternalServerErrorException, Post } from '@nestjs/common';
import { ApiBody, ApiOperation, ApiTags } from '@nestjs/swagger';
import { User } from '@prisma/client';
import { UsersService } from '@src/users/users.service';
import { LoginEntity } from './entities/login.entity';
import { RegisterEntity } from './entities/register.entity';

@Controller('auth')
@ApiTags('authentification')
export class AuthentificationController {
  constructor(private readonly usersService: UsersService) { }

  @Post('login')
  @ApiOperation({ summary: 'Login user' })
  login(@Body() login: LoginEntity): void {
    console.log(login);
  }

  @Post('register')
  @ApiOperation({ summary: 'Register user' })
  @ApiBody({ type: RegisterEntity })
  register(@Body() register: RegisterEntity): Promise<User> {
    return this.usersService
      .create({
        email: register.email,
        password: register.password,
      })
      .then((value: User) => {
        return value;
      })
      .catch((reason: any) => {
        if (reason.code === 'P2002') {
          throw new ConflictException(`User with email ${register.email} already exists`);
        }
        throw new InternalServerErrorException(reason.message);
      });
  }
}
