<template>
  <v-card :title="meterType.name" :subtitle="unit.suffix">
    <v-card-text>
      <dl>
        <dt><strong>Zähler:</strong></dt>
        <dd>{{ store.getMetersByMeterTypeId(meterType.id).length }}</dd>
      </dl>
    </v-card-text>
  </v-card>
</template>
<script setup>
const store = useStore()

const props = defineProps([
  "meterType"
])

const unit = computed(() => {
  return store.getUnitByMeterTypeId(props.meterType.id)
})

await Promise.all([
  callOnce(store.fetchMeters),
  callOnce(store.fetchUnits),
])
</script>