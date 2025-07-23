
import { AuthClient } from '@dfinity/auth-client'
import { AnonymousIdentity } from '@dfinity/agent'

export function useAuth() {
    const router = useRouter()
    async function loginWith(provider: 'ii' | 'nfid') {
        const providerUrl = provider === 'ii'
            ? 'http://rdmx6-jaaaa-aaaaa-aaadq-cai.localhost:4943'
            : 'https://nfid.one/auth';

        const authClient = await AuthClient.create();

        await authClient.login({
            identityProvider: providerUrl,
            maxTimeToLive: BigInt(7 * 24 * 60 * 60 * 1_000_000_000),
            onSuccess: async () => {
                const newIdentity = authClient.getIdentity();
                const session = useSessionStore();
                await session.setIdentity(newIdentity);
                session.isAuthenticated = true;
                await session.signIn();

                // redirect to verify if not register
                if (!session.user && !session.user?.verified) await router.push('/account/register');



            },
            onError: (err) => console.error('Login error', err)
        });
        await router.push('/')
    }

    async function logout() {
        const session = useSessionStore();
        const authClient = await AuthClient.create();
        await authClient.logout();

        await session.setIdentity(new AnonymousIdentity());
        session.isAuthenticated = false;
        session.user = null;
        session.notifications = [];
        session.msgs = [];
        await router.push('/')
    }

    return { loginWith, logout };
}
