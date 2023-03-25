import { Injectable } from '@nestjs/common';
import { Service, ServiceName } from '@prisma/client';
import { PrismaService } from '@src/prisma/prisma.service';

@Injectable()
export class ServicesService {
  constructor(private prisma: PrismaService) {}

  async create(
    data: Omit<Service, 'id' | 'createdAt' | 'updatedAt'>,
  ): Promise<Service> {
    return this.prisma.service.create({
      data: {
        userId: data.userId,
        name: data.name,
        accessToken: data.accessToken,
        refreshToken: data.refreshToken,
      },
    });
  }

  hello(): string {
    return 'Alex la suceuse';
  }

  async serviceByUserId(userId: string): Promise<Service> {
    console.log(userId);
    return this.prisma.service.findUniqueOrThrow({
      where: { userId: userId },
    });
  }
}
