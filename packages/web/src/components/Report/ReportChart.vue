<template>
  <div class="bg-slate-600">
    <Line :options="chartOptions" :data="chartData" />
  </div>
</template>

<script setup>
import { Line } from 'vue-chartjs'
import { Chart as ChartJS, PointElement, LineElement, Title, Tooltip, Legend, CategoryScale, LinearScale } from 'chart.js'

import { format } from 'date-fns';

const store = useStore()

const props = defineProps([
  "reportData", "unit"
])

ChartJS.register(Title, Tooltip, Legend, PointElement, LineElement, CategoryScale, LinearScale)
ChartJS.defaults.color = "lightgray";

const chartData = computed(() => {
  const reportChartData = props.reportData.data.reduce((acc, r) => {
    acc.labels.push(format(r.timestamp, store.dateFormat));

    acc.datasets.map(dataset => {
      // TODO figure out why we get negative usage values on gas meter (temp fix is set min to 0)
      dataset.data.push(r[dataset.dataKey])
    });

    return acc;
  }, {
    labels: [],
    datasets: [
      {
        label: 'usage/year',
        data: [],
        borderColor: 'transparent',
        backgroundColor: 'cyan',
        dataKey: 'deltaYear',
      },
      {
        label: 'avgusage/year',
        data: [],
        borderColor: 'blue',
        dataKey: 'deltaYearAvg',
      },
      {
        label: 'avglast4/year',
        data: [],
        borderColor: 'red',
        dataKey: 'deltaLast4Avg',
      },
    ],
  });

  reportChartData.datasets.push({
    label: 'notes',
    data: props.reportData.notes.map(note => ({
      x: format(note.timestamp, store.dateFormat),
      y: 0.95,
      text: note.text,
    })),
    backgroundColor: 'yellow',
    borderColor: 'transparent',
    pointRadius: 8,
    pointHoverRadius: 12,
    yAxisID: 'textAxis',
  })

  return reportChartData;
});

const chartOptions = computed(() => ({
  responsive: true,
  scales: {
    y: {
      // this is the temporary fix for the negative values on gas meter
      min: 0,
      display: true,
      title: {
        display: true,
        text: props.unit,
      }
    },
    x: {
      display: true,
      title: {
        display: true,
        text: 'Datum',
      }
    },
    textAxis: {
      display: false,
      min: 0,
      max: 1,
    },
  },
  plugins: {
    tooltip: {
      callbacks: {
        label: (context) => {
          return context.raw.text;
        },
      }
    }
  }
}))
</script>
