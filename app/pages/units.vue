<template>
  <CardGrid v-slot="slotProps" :items="store.units">
      <UnitCard :unit="slotProps.item"/>
  </CardGrid>
</template>

<script setup>
const store = useStore()

await callOnce(store.fetchUnits)
</script>