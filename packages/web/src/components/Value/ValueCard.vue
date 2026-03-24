<template>
  <v-card :disabled="valueStore.loading" :loading="valueStore.loading" variant="outlined">
    <template #loader="{ isActive }">
      <v-progress-linear :active="isActive" color="green" height="6" indeterminate />
    </template>
    <v-card-title>
      <MeterTypeTitle :meter-type-id="model.meterTypeId" />
    </v-card-title>
    <v-card-subtitle>
      <MeterTitle :meter-id="latestMeterId" />
    </v-card-subtitle>
    <v-card-text>
      <ValueHistory :raw="true" class="mb-2" density="compact" :meter-type-id="model.meterTypeId" />
      <ValueInput
v-model="model.value" density="compact" label="Zählerstand" :original-value="model.originalValue"
        :meter-type-id="model.meterTypeId" />
      <v-expand-transition>
        <div v-show="model.newMeter">
          <ValueInput
v-model="model.newMeterValue" :hide-date="true" density="compact" label="Zählerstand neuer Zähler"
            :original-value="model.originalNewMeterValue" :meter-type-id="model.meterTypeId" />
        </div>
      </v-expand-transition>
      <v-alert
v-if="model.originalValue?.id && valueChanged" class="mb-2" type="warning"
        text="Sie editieren einen existierenden Wert!" />
    </v-card-text>
    <v-card-actions>
      <v-checkbox
v-model="model.newMeter" :disabled="!valueStore.meterChangePossible(model.meterTypeId)"
        label="Zählerwechsel?" />
      <v-spacer />
      <v-btn color="blue" text="Zurücksetzen" @click="reset" />
    </v-card-actions>
  </v-card>
</template>

<script setup lang="ts">
import type { ReportRow } from '@/api/reports';
import type { ValueFormState } from '@/stores/value';

type SelectedValuePair = {
  selectedValue?: ReportRow;
  selectedNewMeterValue?: ReportRow;
  newMeter: boolean;
};

function resolveSelectedValues(selectedForMeterType: ReportRow[]): SelectedValuePair {
  if (selectedForMeterType.length > 1) {
    const selectedNewMeterValue = selectedForMeterType[selectedForMeterType.length - 1];
    const selectedValue = selectedForMeterType[selectedForMeterType.length - 2];
    return {
      selectedValue,
      selectedNewMeterValue,
      newMeter: selectedValue?.meterId !== selectedNewMeterValue?.meterId,
    };
  }

  if (selectedForMeterType.length === 1) {
    return {
      selectedValue: selectedForMeterType[0],
      selectedNewMeterValue: undefined,
      newMeter: false,
    };
  }

  return {
    selectedValue: undefined,
    selectedNewMeterValue: undefined,
    newMeter: false,
  };
}

const valueStore = useValueStore();

const model = defineModel<ValueFormState>({
  default: () => ({
    meterTypeId: 0,
    originalValue: undefined,
    originalNewMeterValue: undefined,
    value: undefined,
    newMeterValue: undefined,
    newMeter: false,
  }),
});

const latestMeterId = computed(() => {
  return valueStore.latestReportForMeterType(model.value.meterTypeId)?.meterId;
});

const props = withDefaults(defineProps<{
  selectedForMeterType?: ReportRow[];
}>(), {
  selectedForMeterType: () => [],
});

watch(() => props.selectedForMeterType, (selectedForMeterType) => {
  const { selectedValue, selectedNewMeterValue, newMeter } = resolveSelectedValues(selectedForMeterType);
  model.value.originalValue = selectedValue;
  model.value.originalNewMeterValue = selectedNewMeterValue;
  model.value.value = selectedValue?.rawValue;
  model.value.newMeterValue = selectedNewMeterValue?.rawValue;
  model.value.newMeter = newMeter;
}, { immediate: true });

const valueChanged = computed(() => {
  return (model.value.value !== model.value.originalValue?.rawValue) ||
    (model.value.newMeterValue !== model.value.originalNewMeterValue?.rawValue);
});

function reset() {
  model.value.value = model.value.originalValue?.rawValue;
  model.value.newMeterValue = model.value.originalNewMeterValue?.rawValue;
}
</script>
