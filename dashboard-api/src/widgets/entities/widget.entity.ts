import { ApiProperty } from '@nestjs/swagger';
import { Prisma, Widget, WidgetName } from '@prisma/client';

export class WidgetEntity implements Widget {
  @ApiProperty({ default: 'uuid()' })
  id: string;

  @ApiProperty()
  userId: string;

  @ApiProperty()
  data: Prisma.JsonValue;

  @ApiProperty()
  description: WidgetName;

  @ApiProperty()
  createdAt: Date;

  @ApiProperty()
  updatedAt: Date;
}
