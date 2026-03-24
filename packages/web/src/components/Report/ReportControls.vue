<template>
  <v-responsive max-width="300" class="mr-6">
    <v-date-input
v-model="reportStore.selectedFromDate" :min="earliestReportDate" :max="reportStore.selectedToDate" :clearable="true" density="compact" variant="solo-filled" flat
      hide-details single-line rounded="lg" />
  </v-responsive>
  <v-responsive max-width="300" class="mr-6">
    <v-date-input
v-model="reportStore.selectedToDate" :min="reportStore.selectedFromDate" :max="latestReportDate" :clearable="true" density="compact" variant="solo-filled" flat
      hide-details single-line rounded="lg" />
  </v-responsive>
  <v-responsive max-width="300" class="mr-4">
    <MeterTypeSelect
v-model="reportStore.selectedMeterTypeId" density="compact" variant="solo-filled" flat hide-details
      single-line rounded="lg" />
  </v-responsive>
</template>
<script setup lang="ts">
import { useReportRowsQuery } from '@/composables/queries/useReports';

const reportStore = useReportStore()
const selectedMeterTypeId = computed(() => reportStore.selectedMeterTypeId);
const reportRowsQuery = useReportRowsQuery(selectedMeterTypeId);

const earliestReportDate = computed(() => {
  return reportRowsQuery.data.value?.[0]?.timestamp ?? new Date(0);
});

const latestReportDate = computed(() => {
  const rows = reportRowsQuery.data.value ?? [];
  const latestRow = rows[rows.length - 1];
  return latestRow?.timestamp ?? new Date(0);
});
</script>
