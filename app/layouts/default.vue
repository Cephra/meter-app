<template>
  <v-app>
    <NavBar>
      <slot />
    </NavBar>
  </v-app>
</template>

<script>
export default {
  data: () => ({
    menu: [
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
    ]
  })
}
</script>