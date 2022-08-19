<template>
  <v-card :title="unit.name" :subtitle="unit.suffix">
    <v-card-text>
      <dl>
        <dt><strong>Zählergattungen:</strong></dt>
        <dd>{{ store.getMeterTypesByUnitId(unit.id).length }}</dd>
      </dl>
    </v-card-text>
  </v-card>
</template>
<script setup>
const store = useStore()

defineProps([
  "unit"
])

await callOnce(store.fetchMeterTypes)
</script>