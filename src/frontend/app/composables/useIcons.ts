
import { defineProps, defineEmits } from "vue"

export function useIconProps() {
  interface Props {
    class?: string
    qty?: number
  }

  const props = defineProps<Props>()
  const emit = defineEmits(["click"])

  return { props, emit }
}
