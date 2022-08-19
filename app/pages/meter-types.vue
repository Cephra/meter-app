<template>
  <CardGrid v-slot="slotProps" :items="store.meterTypes">
      <MeterTypeCard :meter-type="slotProps.item"/>
  </CardGrid>
</template>

<script setup>
const store = useStore()

await callOnce(store.fetchMeterTypes)
</script>