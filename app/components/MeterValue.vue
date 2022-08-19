<template>
  {{ (value).toFixed(2) }} {{ (unit || store.getUnitById(unitId)).suffix }}
</template>
<script setup>
const store = useStore()

defineProps(["value", "unitId", "unit"])
</script>