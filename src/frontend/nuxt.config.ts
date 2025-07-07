// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
    compatibilityDate: '2025-05-15',
    devtools: {enabled: true},
    ssr: false,
    future: {
        compatibilityVersion: 4,
    },

    experimental: {
        sharedPrerenderData: false,
        compileTemplate: true,
        resetAsyncDataToUndefined: true,
        templateUtils: true,
        defaults: {
            useAsyncData: {
                deep: true,
            }
        },
    },
    pinia: {
        storesDirs: ['./stores/**']
    },
    googleFonts: {
        families: {
            Montserrat: true,

        }
    },
    css: ["@/assets/css/app.css"],
    unhead: {
        renderSSRHeadOptions: {
            omitLineBreaks: false,
        },
    },

    modules: [
        '@nuxtjs/tailwindcss',
        '@nuxtjs/google-fonts',
        '@nuxt/icon',
        '@nuxt/image',
        '@pinia/nuxt',
        'pinia-plugin-persistedstate/nuxt',
    ],
})