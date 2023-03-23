import { Injectable } from '@nestjs/common';
import { Widget } from '@prisma/client';
import { PrismaService } from '@src/prisma/prisma.service';

@Injectable()
export class WidgetsService {
  constructor(private prisma: PrismaService) {}

  async create(
    data: Omit<Widget, 'id' | 'createdAt' | 'updatedAt'>,
  ): Promise<Widget> {
    return this.prisma.widget.create({
      data: {
        description: data.description,
        userId: data.userId,
        data: data.data ? data.data : undefined,
      },
    });
  }
}
