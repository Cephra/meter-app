// import this after install `@mdi/font` package
import '@mdi/font/css/materialdesignicons.css'

import 'vuetify/styles'
import { createVuetify } from 'vuetify'
import { de } from 'vuetify/locale'
import { VNumberInput } from 'vuetify/labs/VNumberInput'

export default defineNuxtPlugin((app) => {
  const vuetify = createVuetify({
    components: {
      VNumberInput
    },
    locale: {
      locale: 'de',
      fallback: 'en',
      messages: {
        de,
      },
    },
    theme: {
      defaultTheme: 'dark'
    },
  })
  app.vueApp.use(vuetify)
})
