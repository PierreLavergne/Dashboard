import {
  BadRequestException,
  Body,
  ConflictException,
  Controller,
  Get,
  NotFoundException,
  Post,
  Query,
  Redirect,
  Res,
  UnauthorizedException,
} from '@nestjs/common';
import { ApiBody, ApiOperation, ApiTags } from '@nestjs/swagger';
import { Service, User } from '@prisma/client';
import { UsersService } from '@src/users/users.service';
import { LoginEntity } from './entities/login.entity';
import { RegisterEntity } from './entities/register.entity';
import { SpotifyEntity } from './entities/spotify.entity';
import axios, { AxiosError, AxiosResponse } from 'axios';
import { ServicesService } from '@src/services/services.service';
import { Response } from 'express';

@Controller('auth')
@ApiTags('authentification')
export class AuthentificationController {
  constructor(
    private readonly usersService: UsersService,
    private readonly servicesService: ServicesService,
  ) { }

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
          console.log('[LOG]  Login | Successful');
          return value;
        }
        throw new UnauthorizedException('Bad password');
      })
      .catch((reason: any) => {
        console.log('[LOG]  Login | Something Bad');
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
        console.log('[LOG]  Register | Successful');
        return value;
      })
      .catch((reason: any) => {
        console.log('[LOG]  Register | Something Bad');
        if (reason.code === 'P2002') {
          throw new ConflictException(
            `User with email ${register.email} already exists`,
          );
        }
        throw new BadRequestException(reason.message);
      });
  }

  @Get('spotify')
  @ApiOperation({ summary: 'Register user using Spotify' })
  @Redirect(SpotifyEntity.urlOauth2(), 301)
  spotify(): void {
    return;
  }

  @Get('spotify/callback')
  async spotifyCallback(@Query('code') code: string, @Res({ passthrough: true }) response: Response): Promise<void> {
    const body: URLSearchParams = new URLSearchParams([
      ['grant_type', 'authorization_code'],
      ['code', code],
      ['redirect_uri', SpotifyEntity.redirectUri],
    ]);
    console.log('[LOG]  Spotify | Getting access_token');
    return axios
      .post(SpotifyEntity.urlToken(), body, {
        headers: {
          Authorization: SpotifyEntity.authorizationCode(),
          'Content-Type': SpotifyEntity.contentType,
        },
      })
      .then(async (tokens: AxiosResponse) => {
        console.log('[LOG]  Spotify | Getting Spotify user infos');
        return axios
          .get(SpotifyEntity.userInfosUrl, {
            headers: {
              Accept: 'application/json',
              'Content-Type': 'application/json',
              Authorization: 'Bearer ' + tokens.data.access_token,
            },
          })
          .then(async (infos: AxiosResponse) => {
            console.log(
              `[LOG]  Spotify | Try to find existing ${infos.data.email}`,
            );
            return this.usersService
              .getUserByEmail({ email: infos.data.email, password: '' })
              .then(async (user: User) => {
                console.log('[LOG]  Spotify | Create Spotify service in DB');
                return this.servicesService
                  .create({
                    userId: user.id,
                    name: 'SPOTIFY',
                    accessToken: tokens.data.access_token,
                    refreshToken: tokens.data.refresh_token,
                  })
                  .then(async (service: Service) => {
                    console.log('[LOG]  Spotify | Finish !');
                    console.log(service);
                  })
                  .catch((reason: any) => {
                    if (reason.code !== 'P2002') {
                      console.log(reason);
                      throw reason;
                    }
                    console.log('[LOG]  Spotify | Finish !');
                    return response.redirect(302, `http://localhost:8000/#/root?user-id=${user.id}`);

                  });
              })
              .catch(async (reason: any) => {
                if (reason.code !== 'P2025') {
                  console.log(reason);
                  throw reason;
                }
                console.log('[LOG]  Spotify | Create user');
                return this.usersService
                  .create({
                    email: infos.data.email,
                    password: '',
                  })
                  .then(async (user: User) => {
                    console.log(
                      '[LOG]  Spotify | Create Spotify service in DB',
                    );
                    return this.servicesService
                      .create({
                        userId: user.id,
                        name: 'SPOTIFY',
                        accessToken: tokens.data.access_token,
                        refreshToken: tokens.data.refresh_token,
                      })
                      .then(async (service: Service) => {
                        console.log('[LOG]  Spotify | Finish !');
                        return response.redirect(302, `http://localhost:8000/#/root?user-id=${service.userId}`);
                      })
                      .catch((reason: any) => {
                        console.log(reason);
                        throw reason;
                      });
                  })
                  .catch((reason: any) => {
                    console.log(reason);
                    // throw reason;
                  });
              });
          });
      })
      .catch((reason: AxiosError) => {
        throw new BadRequestException(reason.response?.data);
      });
  }
}
