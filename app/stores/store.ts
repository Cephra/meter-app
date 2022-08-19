// Pinia Store
import { defineStore } from "pinia";

function createMeterQuery(meterId: number) {
  return meterId
    ? {
        where: {
          meterId: meterId,
        },
      }
    : {};
}

async function getSingleValueByMeterId(
  meterId: number,
  sortOrder: string = "asc"
) {
  const value: Array<any> = await $fetch("http://localhost:3000/values", {
    params: {
      filter: {
        offset: 0,
        limit: 1,
        order: `timestamp ${sortOrder}`,
        where: {
          meterId: meterId,
        },
        fields: {
          timestamp: true,
          value: true,
        },
      },
    },
  });

  return value[0];
}

export const useStore = defineStore("store", {
  state: (): any => ({
    meters: [],
    meterStats: {},
    meterTypes: [],
    units: [],
    values: [],
  }),
  getters: {
    getMeterById(state): any {
      return (id: number) => state.meters.find((m: any) => m.id === id);
    },
    getMetersByMeterTypeId(state) {
      return (meterTypeId: number) =>
        state.meters.filter((m: any) => m.meterTypeId === meterTypeId);
    },
    getMeterTypesByUnitId(state) {
      return (unitId: number) =>
        state.meterTypes.filter((mt: any) => mt.unitId === unitId);
    },
    getUnitById(state): any {
      return (id: number) => {
        return state.units.find((u: any) => u.id === id);
      };
    },
    getMeterTypeById(): any {
      return (id: number) => {
        return this.meterTypes.find((mt: any) => mt.id === id);
      };
    },
    getUnitByMeterTypeId(): any {
      return (meterTypeId: number) => {
        return this.getUnitById(this.getMeterTypeById(meterTypeId)?.unitId);
      };
    },
    getUnitByMeterId(): any {
      return (meterId: number) => {
        const meter = this.getMeterById(meterId);
        const meterType = this.getMeterTypeById(meter?.meterTypeId);
        return this.getUnitByMeterTypeId(meterType?.id);
      };
    },
  },
  actions: {
    async fetchMeters() {
      this.meters = await $fetch("http://localhost:3000/meters");
    },
    async fetchMeterTypes() {
      this.meterTypes = await $fetch("http://localhost:3000/meter-types");
    },
    async fetchUnits() {
      this.units = await $fetch("http://localhost:3000/units");
    },
    async countValuesByMeterId(meterId: number) {
      const res: any = await $fetch("http://localhost:3000/values/count", {
        params: createMeterQuery(meterId),
      });
      return res.count;
    },
    async getFirstValueByMeterId(meterId: number) {
      return await getSingleValueByMeterId(meterId, "asc");
    },
    async getLastValueByMeterId(meterId: number) {
      return await getSingleValueByMeterId(meterId, "desc");
    },
    async getMeterStatsByMeterId(meterId: number) {
      return {
        valueCount: await this.countValuesByMeterId(meterId),
        firstValue: await this.getFirstValueByMeterId(meterId),
        lastValue: await this.getLastValueByMeterId(meterId),
      };
    },
    async fetchValues(meterId: number) {
      this.values = await $fetch("http://localhost:3000/values", {
        params: {
          filter: {
            ...createMeterQuery(meterId),
            order: `timestamp asc`,
          },
        },
      });
    },
  },
});
