export function useOidcAuth() {
  const user = ref({ userName: 'local-dev' });
  const currentProvider = ref('keycloak');

  const logout = async (): Promise<void> => {
    // Placeholder during migration. Real OIDC integration will replace this.
  };

  return {
    user,
    logout,
    currentProvider,
  };
}
