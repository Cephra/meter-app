<template>
  <CardGrid v-slot="slotProps" :items="store.meters">
      <MeterCard :meter="slotProps.item"/>
  </CardGrid>
</template>

<script setup>
const store = useStore()

await callOnce(store.fetchMeters)
</script>