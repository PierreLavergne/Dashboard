import { ApiProperty } from '@nestjs/swagger';

export class LoginEntity {
  @ApiProperty()
  email: string;

  @ApiProperty()
  password: string;
}
