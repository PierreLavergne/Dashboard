import { BadRequestException, Injectable } from '@nestjs/common';
import { WeatherResponse } from './response.entity';
import axios, { AxiosResponse } from 'axios';

@Injectable()
export class WeatherService {
  async getWeatherInfos(userId: string, data: any): Promise<WeatherResponse> {
    if (data.location == undefined) {
      throw new BadRequestException();
    }
    const url: string = process.env.WEATHER_API_URL + data.location;
    return axios
      .get(url)
      .then((value: AxiosResponse) => {
        const response: WeatherResponse = {
          description: 'WEATHER_TEMP',
          location: value.data.location.name,
          icon: value.data.current.condition.icon,
          temperature: value.data.current.temp_c,
        };
        return response;
      })
      .catch((reason: any) => {
        throw new BadRequestException(reason);
      });
  }
}
