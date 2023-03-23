import { ApiProperty } from '@nestjs/swagger';
import { IsEmail, IsString } from 'class-validator';
import { PasswordMatching } from '../decorators/password.decorator';

export class RegisterEntity {
  @ApiProperty()
  @IsEmail()
  email: string;

  @ApiProperty()
  @IsString()
  password: string;

  @ApiProperty()
  @IsString()
  @PasswordMatching('password')
  confirmPassword: string;
}
