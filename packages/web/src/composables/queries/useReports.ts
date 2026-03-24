import { useQuery } from '@tanstack/vue-query';
import type { Ref } from 'vue';
import { listReportRows } from '@/api/reports';

export function useReportRowsQuery(meterTypeId: Ref<number | null>) {
  return useQuery({
    queryKey: computed(() => ['reports', meterTypeId.value]),
    queryFn: () => listReportRows(meterTypeId.value as number),
    enabled: computed(() => Boolean(meterTypeId.value)),
  });
}
