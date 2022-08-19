// @ts-check
import withNuxt from './.nuxt/eslint.config.mjs'

export default withNuxt(
  // Your custom configs here
  {
    rules: {
      '@typescript-eslint/no-explicit-any': 'off',
      'vue/require-prop-types': 'off',
      'vue/valid-v-slot': ['error', {
        allowModifiers: true,
      }],
    }
  }
)
