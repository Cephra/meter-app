import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { HealthController } from './health/health.controller';
import { MeterTypesModule } from './meter-types/meter-types.module';
import { MeterStatsModule } from './meter-stats/meter-stats.module';
import { MetersModule } from './meters/meters.module';
import { NotesModule } from './notes/notes.module';
import { PrismaModule } from './prisma/prisma.module';
import { ReportsModule } from './reports/reports.module';
import { UnitsModule } from './units/units.module';
import { ValuesModule } from './values/values.module';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    PrismaModule,
    UnitsModule,
    MeterTypesModule,
    MeterStatsModule,
    MetersModule,
    ValuesModule,
    NotesModule,
    ReportsModule,
  ],
  controllers: [HealthController],
})
export class AppModule {}
