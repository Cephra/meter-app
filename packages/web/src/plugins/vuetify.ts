import '@mdi/font/css/materialdesignicons.css';
import 'vuetify/styles';
import { createVuetify } from 'vuetify';
import { de } from 'vuetify/locale';
import { VNumberInput } from 'vuetify/components';
import { VDateInput } from 'vuetify/labs/components';

export const vuetify = createVuetify({
  components: {
    VNumberInput,
    VDateInput,
  },
  locale: {
    locale: 'de',
    fallback: 'en',
    messages: {
      de,
    },
  },
  theme: {
    defaultTheme: 'dark',
  },
});
