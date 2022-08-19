<template>
  <v-select v-model="model" placeholder="Zähler auswählen" :items="meters"/>
</template>

<script setup>
const store = useStore()

const meters = computed(() => {
  return store.meters.map(meter => ({
    title: meter.name,
    value: meter.id
  }))
})

const model = defineModel()

await callOnce(store.fetchMeters)
</script>