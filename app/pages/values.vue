<template>
  <div>
    <MeterSelect v-model="meterId" />
    <v-data-table :headers="headers" :items="store.values">
      <template #item.timestamp="{ value }">
        <DateFormat :date="value" />
      </template>
      <template #item.meterId="{ value }">
        {{ store.getMeterById(value).name }}
      </template>
      <template #item.value="{ value, item }">
        <MeterValue :value="value" :unit="store.getUnitByMeterId(item.meterId)"/>
      </template>
    </v-data-table>
  </div>
</template>
<script setup>
const store = useStore()

const meterId = ref(null)

const headers = [
  { title: 'Wert', key: 'value', width: "8rem"},
  { title: 'Zähler', key: 'meterId', width: "8rem"},
  { title: 'Datum', key: 'timestamp', width: "8rem" },
];

watch(meterId, async (meterId) => {
  await store.fetchValues(meterId)
})

await callOnce(async () => {
  await Promise.all([
    store.fetchMeters(),
    store.fetchMeterTypes(),
    store.fetchUnits(),
    store.fetchValues(meterId.value),
  ])
})
</script>