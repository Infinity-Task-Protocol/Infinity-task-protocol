import { useRoute } from 'vue-router'


// Desestructura el ID de la ruta para obtener el id como string 
export function useRouteId(paramName: string): string | null {
  const route = useRoute()
  const raw = route.params[paramName]
  
  if (raw === undefined) return null
  
  if (Array.isArray(raw)) {
    return raw.length > 0 && raw[0] !== undefined ? raw[0] : null
  }
  
  return raw
}