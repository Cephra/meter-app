<template>
  <div>
    <v-form>
      <v-container>
        <v-row>
          <v-col>
            <v-date-picker v-model="model.date" :max="new Date()" />
            <div class="pt-5 max-w-md">
              <MeterSelect v-model="model.meterId" />
              <ValueInput :meter-id="model.meterId" />
            </div>
            <v-btn class="mr-4">Senden</v-btn>
            <v-btn>Zurücksetzen</v-btn>
          </v-col>
        </v-row>
      </v-container>
    </v-form>
  </div>
</template>

<script setup>
const store = useStore()

const model = ref({
  date: null,
  meterId: null,
  value: null,
})

await Promise.all([
  callOnce(store.fetchMeterTypes),
  callOnce(store.fetchUnits),
])
</script>