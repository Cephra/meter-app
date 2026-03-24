import {
  createMeterType,
  deleteMeterType,
  listMeterTypes,
  updateMeterType,
  type MeterType,
} from '@/api/meter-types';

export const useMeterTypeStore = defineStore("meter-types", {
  state: (): { meterTypes: MeterType[] } => ({
    meterTypes: [],
  }),
  getters: {
    getMeterTypesByUnitId(state) {
      return (unitId: number): MeterType[] =>
        state.meterTypes.filter((mt) => mt.unitId === unitId);
    },
    getMeterTypeById(state) {
      return (id: number): MeterType | undefined => {
        return state.meterTypes.find((mt) => mt.id === id);
      };
    },
  },
  actions: {
    async fetch() {
      return (this.meterTypes = await listMeterTypes());
    },
    async store(model: Partial<MeterType> & { name: string; unitId: number }) {
      if (model.id) {
        await updateMeterType(model.id, {
          name: model.name,
          unitId: model.unitId,
        });
      } else {
        await createMeterType({
          name: model.name,
          unitId: model.unitId,
        });
      }
      await this.fetch();
    },
    async delete(model: Partial<MeterType>) {
      if (!model.id) return;
      await deleteMeterType(model.id);
      await this.fetch();
    },
  },
});
