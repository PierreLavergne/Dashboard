import { ApiProperty } from '@nestjs/swagger';
import { Prisma, WidgetName } from '@prisma/client';
import { IsNotEmpty, IsString } from 'class-validator';

export class NewWidgetEntity {
  @ApiProperty({ enum: WidgetName })
  @IsNotEmpty()
  description: WidgetName;

  @ApiProperty()
  data: Prisma.JsonValue;
}
