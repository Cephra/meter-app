import { deleteUnit, listUnits, updateUnit, createUnit, type Unit } from '@/api/units';
import type { MeterType } from '@/api/meter-types';
import type { MeterStat } from '@/api/meters';

export const useUnitStore = defineStore("units", {
  state: (): { units: Unit[] } => ({
    units: [],
  }),
  getters: {
    getMeterById() {
      return (id: number): MeterStat | undefined => useMeterStore().getMeterById(id);
    },
    getMetersByMeterTypeId() {
      return (meterTypeId: number): MeterStat[] =>
        useMeterStore().getMetersByMeterTypeId(meterTypeId);
    },
    getUnitById(state) {
      return (id: number) => {
        return state.units.find((u) => u.id === id);
      };
    },
    getUnitByMeterTypeId() {
      return (meterTypeId: number): Unit | undefined => {
        const unitId = useMeterTypeStore().getMeterTypeById(meterTypeId)?.unitId;
        if (unitId == null) {
          return undefined;
        }

        return this.getUnitById(unitId);
      };
    },
    getUnitByMeterId() {
      return (meterId: number): Unit | undefined => {
        const meter = useMeterStore().getMeterById(meterId);
        const meterType: MeterType | undefined = meter?.meterTypeId == null
          ? undefined
          : useMeterTypeStore().getMeterTypeById(meter.meterTypeId);
        if (meterType?.id == null) {
          return undefined;
        }

        return this.getUnitByMeterTypeId(meterType.id);
      };
    },
  },
  actions: {
    async fetch() {
      this.units = await listUnits();
    },
    async store(model: Partial<Unit> & { name: string; suffix: string }) {
      if (model.id) {
        await updateUnit(model.id, {
          name: model.name,
          suffix: model.suffix,
        });
      } else {
        await createUnit({
          name: model.name,
          suffix: model.suffix,
        });
      }
      await this.fetch();
    },
    async delete(model: Partial<Unit>) {
      if (!model.id) return;
      await deleteUnit(model.id);
      await this.fetch();
    },
  },
});
