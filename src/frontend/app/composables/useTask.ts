import type { TaskExpandResponse } from '../../../declarations/backend/backend.did'

export function useTask() {
    const session = useSessionStore()
    const taskData = ref(null)
    const bidsDetails = ref(null)
    const author = ref(null)
    const isAuthor = ref(false)

    const loadTask = async (taskId: bigint) => {
        const taskResponse = await session.backend.expandTask(taskId) as TaskExpandResponse
        if (!taskResponse[0]) return false

        taskData.value = taskResponse[0].task
        bidsDetails.value = taskResponse[0].bidsDetails
        author.value = taskResponse[0].author
        isAuthor.value = taskResponse[0].author.principal.toString() === session.user.principal.toString()
        return true
    }

    return {
        taskData,
        bidsDetails,
        author,
        isAuthor,
        loadTask
    }
}
