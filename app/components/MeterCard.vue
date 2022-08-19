<template>
  <v-card :title="meter.name" :subtitle="subtitle">
    <v-card-text>
      <dl>
        <dt class="mt-1"><strong>Erster Eintrag:</strong></dt>
        <dd>
          <DateFormat :date="meterStats.data.value.firstValue.timestamp" />
        </dd>
        <dd>
          <MeterValue :value="meterStats.data.value.firstValue.value" :unit="unit" />
        </dd>
        <dt class="mt-1"><strong>Letzter Eintrag:</strong></dt>
        <dd>
          <DateFormat :date="meterStats.data.value.lastValue.timestamp" />
        </dd>
        <dd>
          <MeterValue :value="meterStats.data.value.lastValue.value" :unit="unit" />
        </dd>
        <dt class="mt-1"><strong>Erfasste Messwerte:</strong></dt>
        <dd>{{ meterStats.data.value.valueCount }}</dd>
      </dl>
    </v-card-text>
  </v-card>
</template>
<script setup>
const store = useStore()

const props = defineProps([
  "meter"])

const meterType = computed(() => {
  return store.getMeterTypeById(props.meter.meterTypeId)
})

const unit = computed(() => {
  return store.getUnitByMeterTypeId(props.meter.meterTypeId)
})

const subtitle = computed(() => {
  return `${meterType.value.name} (${unit.value.suffix})`;
})

await Promise.all([
  callOnce(store.fetchMeterTypes),
  callOnce(store.fetchUnits),
])

const meterStats = await useAsyncData(
  `meterStats:${props.meter.id}`,
  () => store.getMeterStatsByMeterId(props.meter.id)
)
</script>