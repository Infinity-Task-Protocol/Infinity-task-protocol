import type { TaskExpandResponse } from 'declarations/backend/backend.did'
import type { Opt } from '@/utils/types'

export function useTask() {
  const session = useSessionStore()
  const taskData = ref<TaskExpandResponse['task'] | null>(null)
  const bidsDetails = ref<TaskExpandResponse['bidsDetails'] | null>(null)
  const author = ref<TaskExpandResponse['author'] | null>(null)
  const isAuthor = ref(false)
  const taskStatus = ref("");
  const loadTask = async (taskId: bigint) => {
    console.log('Loading task:', taskId)
    const taskResponse: Opt<TaskExpandResponse> = await session.backend.expandTask(taskId)
    console.log('Task response:', taskResponse)
    if (taskResponse.length === 0) return false

    const { task, bidsDetails: bids, author: auth } = taskResponse[0]

    taskData.value = task
    bidsDetails.value = bids
    author.value = auth
    isAuthor.value = auth.principal.toString() === session.user?.principal.toString()
    taskStatus.value = Object.keys(taskData.value.status)[0]!

    return true
  }

  return {
    taskData,
    bidsDetails,
    author,
    isAuthor,
    loadTask,
    taskStatus
  }
}