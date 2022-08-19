<template>
  {{ formattedDate }}
</template>
<script setup>
import { useDate } from 'vuetify';

const dateLib = useDate()

const props = defineProps(["date", "format"])

const formattedDate = computed(() => {
  return dateLib.format(props.date, props.format || 'keyboardDate')
})
</script>