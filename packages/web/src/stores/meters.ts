import {
  createMeter,
  deleteMeter,
  listMeterStats,
  updateMeter,
  type MeterStat,
} from '@/api/meters';

export const useMeterStore = defineStore("meters", {
  state: (): { meters: MeterStat[] } => ({
    meters: [],
  }),
  getters: {
    getMeterById(state) {
      return (id: number): MeterStat | undefined => state.meters.find((m) => m.id === id);
    },
    getMetersByMeterTypeId(state) {
      return (meterTypeId: number): MeterStat[] => {
        return state.meters.filter((m) => m.meterTypeId === meterTypeId);
      };
    },
  },
  actions: {
    async fetch() {
      this.meters = await listMeterStats();
    },
    async store(model: Partial<MeterStat> & { name: string; meterTypeId: number }) {
      let res = null;
      if (model.id) {
        res = await updateMeter(model.id, {
          name: model.name,
          meterTypeId: model.meterTypeId,
        });
      } else {
        res = await createMeter({
          name: model.name,
          meterTypeId: model.meterTypeId,
        });
      }
      await this.fetch();
      return res;
    },
    async delete(model: Partial<MeterStat>) {
      if (!model.id) return;
      await deleteMeter(model.id);
      await this.fetch();
    },
  },
});
