import {
  isAfter,
  isBefore,
  isSameDay,
  format,
  startOfToday,
  endOfDay,
} from "date-fns";
import type { MeterType } from '@/api/meter-types';
import { listReportRows, type ReportRow } from '@/api/reports';
import { createValue, deleteValue, updateValue, type ValueRecord } from '@/api/values';

export type ValueFormState = {
  meterTypeId: number;
  originalValue?: ReportRow;
  originalNewMeterValue?: ReportRow;
  value?: number | null;
  newMeterValue?: number | null;
  newMeter: boolean;
};

type ValueStoreState = {
  selectedDate: Date;
  loading: boolean;
  inputValues: Record<number, ValueFormState>;
  reportDataByMeterType: Record<number, ReportRow[]>;
};

function createValueFormState(
  meterTypeId: number,
  existing?: Partial<ValueFormState>,
): ValueFormState {
  return {
    meterTypeId,
    originalValue: existing?.originalValue,
    originalNewMeterValue: existing?.originalNewMeterValue,
    value: existing?.value,
    newMeterValue: existing?.newMeterValue,
    newMeter: existing?.newMeter ?? false,
  };
}

export const useValueStore = defineStore("value", {
  state: (): ValueStoreState => ({
    selectedDate: startOfToday(),
    loading: false,
    inputValues: {},
    reportDataByMeterType: {},
  }),
  getters: {
    allReportData(state): ReportRow[] {
      return Object.values(state.reportDataByMeterType).flatMap((rows) => rows);
    },
    getSelectedForMeterType: (state) => {
      return (meterTypeId: number): ReportRow[] => {
        return (state.reportDataByMeterType[meterTypeId] ?? []).filter((reportRow) => {
          return isSameDay(reportRow.timestamp, state.selectedDate);
        });
      };
    },
    historyForMeterType: (state) => {
      return (meterTypeId: number): ReportRow[] => {
        return (state.reportDataByMeterType[meterTypeId] ?? [])
          .filter((reportRow) => {
            return isBefore(reportRow.timestamp, state.selectedDate);
          })
          .slice(-3);
      };
    },
    latestReportForMeterType: (state) => {
      const meterStore = useMeterStore();
      return (meterTypeId: number): Partial<ReportRow> => {
        const reportRows = state.reportDataByMeterType[meterTypeId] ?? [];
        const latestMeter = reportRows[reportRows.length - 1];
        const matchingMeters = meterStore.getMetersByMeterTypeId(meterTypeId);
        const fallbackMeter = matchingMeters[0];
        return latestMeter ?? { meterId: fallbackMeter?.id };
      };
    },
    meterChangePossible() {
      return (meterTypeId: number) => {
        const endOfSelectedDate = endOfDay(this.selectedDate);
        const latestReport = this.latestReportForMeterType(meterTypeId);
        const latestTimestamp = latestReport?.timestamp;

        if (!latestTimestamp) {
          return true;
        }

        const endOfLatestReport = endOfDay(latestTimestamp);

        return (
          isAfter(endOfSelectedDate, endOfLatestReport) ||
          isSameDay(endOfSelectedDate, endOfLatestReport)
        );
      };
    },
  },
  actions: {
    async fetchReportForMeterType(meterTypeId: number, clearArray: boolean = false) {
      if (clearArray) {
        this.reportDataByMeterType[meterTypeId] = [];
      }

      const reportRows = await listReportRows(meterTypeId);
      this.reportDataByMeterType[meterTypeId] = reportRows;
      return reportRows;
    },
    async fetch(meterTypes?: MeterType[]) {
      const resolvedMeterTypes = meterTypes ?? await useMeterTypeStore().fetch();
      await Promise.all(
        resolvedMeterTypes.map(async (meterType) => {
          const meterTypeId = meterType.id;
          this.inputValues[meterTypeId] = createValueFormState(
            meterTypeId,
            this.inputValues[meterTypeId],
          );
          return this.fetchReportForMeterType(meterTypeId);
        })
      );
    },
    async store() {
      const store = useStore();
      this.loading = true;
      try {
        await Promise.all(
          Object.entries(this.inputValues).map(async ([meterTypeIdKey, inputValue]) => {
            if (inputValue.originalValue) {
              await updateValue(inputValue.originalValue.id, {
                value: inputValue.value ?? undefined,
              });
            } else if (inputValue.value) {
              await createValue({
                meterId: this.latestReportForMeterType(Number(meterTypeIdKey)).meterId as number,
                timestamp: format(this.selectedDate, store.dateApiSendFormat),
                value: inputValue.value,
              });
            }

            if (inputValue.newMeter) {
              if (!inputValue.originalNewMeterValue) {
                // new meter was requested and no originalNewMeterValue is present
                // we have to create a new one
                throw new Error("Der Zählerwechsel ist noch nicht vollständig implementiert.");
              } else {
                // implement the update of a stored new meter value
                throw new Error("Das Aktualisieren eines Zählerwechsels ist noch nicht implementiert.");
              }
            }
          })
        );
        await this.fetch();
      } finally {
        this.loading = false;
      }
    },
    async delete(model: Pick<ValueRecord, 'id'>) {
      if (!model.id) return;
      await deleteValue(model.id);
      await this.fetch();
    },
  },
});
