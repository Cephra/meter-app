<template>
  <v-navigation-drawer v-model="drawer">
    <v-list>
      <NavItem v-for="item in menu" :key="item.name" :item="item"/>
    </v-list>
  </v-navigation-drawer>
  <v-app-bar>
    <v-app-bar-nav-icon @click="drawer = !drawer"/>
    <v-app-bar-title>Hausdaten</v-app-bar-title>
  </v-app-bar>
  <v-main>
    <v-container>
      <slot />
    </v-container>
  </v-main>
</template>

<script setup>
import { ref } from 'vue';

const drawer = ref(null)
const menu = ref([
  {
    name: "Eingabe",
    page: "/",
  },
  {
    name: "Messwerte",
    page: "/values",
  },
  {
    name: "Verwaltung",
    items: [
      {
        name: "Zähler",
        page: "/meters",
      },
      {
        name: "Zählergattungen",
        page: "/meter-types",
      },
      {
        name: "Einheiten",
        page: "/units",
      },
    ],
  },
  {
    name: "Auswertungen",
    items: [
      {
        name: "Verbrauch",
        page: "/reports",
      },
    ],
  },
])
</script>