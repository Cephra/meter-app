<template>
  <v-form @submit.prevent>
    <v-row>
      <v-col cols="12" lg="4">
        <v-card :disabled="valueStore.loading" :loading="valueStore.loading">
          <template #loader="{ isActive }">
            <v-progress-linear
              :active="isActive"
              color="green"
              height="6"
              indeterminate
            />
          </template>
          <v-card-text>
            <v-date-picker
v-model="valueStore.selectedDate" :show-adjacent-months="true" width="100%"
              :max="new Date()" />
            <v-textarea label="Notiz" clearable />
          </v-card-text>
          <v-card-actions class="pt-0">
            <v-btn text="Heute" @click="goToToday" />
            <v-spacer />
            <v-btn color="green" variant="outlined" type="submit" text="Speichern" @click="valueStore.store" />
          </v-card-actions>
        </v-card>
      </v-col>
      <v-col cols="12" lg="8">
        <v-row>
          <v-col v-for="mt in meterTypes" :key="mt.id" cols="12" lg="6">
            <ValueCard
v-model="valueStore.inputValues[mt.id]"
              :selected-for-meter-type="valueStore.getSelectedForMeterType(mt.id)" />
          </v-col>
        </v-row>
      </v-col>
    </v-row>
  </v-form>
</template>

<script setup lang="ts">
import { useMeterTypesQuery } from '@/composables/queries/useMeterTypes';

const valueStore = useValueStore()
const meterTypesQuery = useMeterTypesQuery();

const meterTypes = computed(() => meterTypesQuery.data.value ?? []);

function goToToday() {
  valueStore.selectedDate = new Date();
}

watch(meterTypes, async (resolvedMeterTypes) => {
  if (!resolvedMeterTypes.length) {
    return;
  }

  await valueStore.fetch(resolvedMeterTypes);
}, {
  immediate: true,
})
</script>
