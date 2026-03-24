# Frontend Architecture

## Direction

`packages/web` is the active frontend.

## State Rules

- Use Vue Query for server state.
- Use Pinia for UI and client state only.
- Route all HTTP access through `packages/web/src/api`.
- Prefer generated backend DTO types from `packages/shared-api` where they are usable.
- Do not add compatibility layers that reintroduce old framework behavior.
- Keep Vuetify as the primary UI system; use Tailwind for lightweight utility styling only.

## Current Priorities

1. Introduce a typed API layer in `packages/web`.
2. Move one vertical slice at a time from fetch-heavy Pinia stores to Vue Query.
3. Add focused tests in `packages/web` for each migrated slice.
4. Replace placeholder platform concerns such as auth with standalone Vue implementations.
5. Simplify remaining migration-era workflow logic, especially in the value entry flow.

## Reference Slice

The `units` slice is the reference implementation for the current pattern:

- API functions in `src/api/units.ts`
- Vue Query composables in `src/composables/queries/useUnits.ts`
- Components and pages calling composables directly
- Thin compatibility store retained only where it still reduces churn
