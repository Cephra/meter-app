<template>
  <v-number-input
v-model="model" :reverse="false" control-variant="default" placeholder="Zählerstand eingeben" label=""
    :hide-input="false" :inset="false" :suffix="unitForMeter?.suffix"/>
</template>

<script setup>
const store = useStore()

const model = defineModel()

const props = defineProps([
  'meterId'
])

const unitForMeter = computed(() => {
  return store.getUnitByMeterId(props.meterId)
})
</script>